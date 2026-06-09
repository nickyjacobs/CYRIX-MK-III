#!/usr/bin/env bash
# CYRIX MK-III SessionEnd hook — auto-sessie pipeline kern
#
# Wat dit doet bij elke sessie-eind (matcher: clear|resume|logout|other):
#   1. Lees hook-input JSON (session_id, transcript_path, cwd, reason)
#   2. Bepaal of sessie substantieel was (>= 3 tool-uses en/of content-changes)
#   3. Parse transcript: focus, tool-uses, decision-markers
#   4. Schrijf RAW log → wiki/30-sessions/raw/ (gitignored)
#   5. Schrijf processed log → wiki/30-sessions/ (committable, zonder secrets)
#   6. Roep pre-commit-secret-scan.sh aan voor safety
#   7. Auto-stage + auto-commit (NIET pushen)
#   8. Schrijf ingest-marker voor /process-sessions
#
# Geen blokkering — alleen observational. Faal-modus = log naar audit, geen actie.

set -euo pipefail

HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${HOOK_DIR}/../.." && pwd)"
cd "${REPO_ROOT}"

# Lees hook-input JSON via stdin
stdin_data=$(cat 2>/dev/null || echo "{}")

session_id=$(echo "${stdin_data}" | python3 -c "
import json, sys
try: print(json.load(sys.stdin).get('session_id', ''))
except: print('')
" 2>/dev/null || echo "")

transcript_path=$(echo "${stdin_data}" | python3 -c "
import json, sys
try: print(json.load(sys.stdin).get('transcript_path', ''))
except: print('')
" 2>/dev/null || echo "")

reason=$(echo "${stdin_data}" | python3 -c "
import json, sys
try: print(json.load(sys.stdin).get('reason', 'unknown'))
except: print('unknown')
" 2>/dev/null || echo "unknown")

# Substantialiteit-check: content-changes EN/OF tool-use-count
content_changes=0
if [[ -d .git ]]; then
    content_changes=$(git status --porcelain wiki/ MEMORY.md .claude/ scripts/ docs/ integrations/ *.md 2>/dev/null | wc -l | tr -d ' ')
fi

tool_uses=0
if [[ -n "${transcript_path}" && -f "${transcript_path}" ]]; then
    tool_uses=$(grep -c '"type":"tool_use"' "${transcript_path}" 2>/dev/null || echo 0)
fi

# Skip triviale sessies (geen tool-uses EN geen content-changes)
if [[ "${tool_uses}" -lt 3 && "${content_changes}" -eq 0 ]]; then
    exit 0
fi

# === Bepaal datums + sessie-slug ===
today=$(date +%Y-%m-%d)
timestamp=$(date +%Y-%m-%d-%H%M)

# Probeer een korte titel uit eerste user-prompt af te leiden (geen secrets)
session_focus=""
if [[ -n "${transcript_path}" && -f "${transcript_path}" ]]; then
    session_focus=$(python3 - <<PYEOF 2>/dev/null || echo ""
import json, sys
try:
    with open("${transcript_path}") as f:
        for line in f:
            try:
                entry = json.loads(line)
            except: continue
            # Eerste user-message-content
            if entry.get('type') == 'message' and entry.get('role') == 'user':
                content = entry.get('content', '')
                if isinstance(content, list):
                    content = ' '.join(c.get('text', '') for c in content if isinstance(c, dict))
                if content and len(str(content)) > 5:
                    # Pak eerste 60 chars, slugify
                    words = str(content)[:80].lower()
                    import re
                    slug = re.sub(r'[^a-z0-9]+', '-', words).strip('-')[:40]
                    if slug:
                        print(slug)
                        break
except Exception:
    pass
PYEOF
)
fi

slug="${session_focus:-session}"
raw_path="wiki/30-sessions/raw/${timestamp}-${slug}.md"
processed_path="wiki/30-sessions/${today}-${slug}.md"
mkdir -p "wiki/30-sessions/raw" "wiki/30-sessions"

# === Stap 1: RAW log (gitignored — kan secrets bevatten via transcript) ===
{
    echo "---"
    echo "date: ${today}"
    echo "session-id: ${session_id:-unknown}"
    echo "reason: ${reason}"
    echo "tool-uses: ${tool_uses}"
    echo "content-changes: ${content_changes}"
    echo "type: session-raw"
    echo "transcript: ${transcript_path}"
    echo "---"
    echo ""
    echo "# Sessie raw — ${timestamp}"
    echo ""
    if [[ -n "${transcript_path}" && -f "${transcript_path}" ]]; then
        echo "## Eerste user-prompt"
        echo ""
        python3 - <<PYEOF 2>/dev/null || echo "(geen prompt gevonden)"
import json
try:
    with open("${transcript_path}") as f:
        for line in f:
            try: e = json.loads(line)
            except: continue
            if e.get('type') == 'message' and e.get('role') == 'user':
                c = e.get('content', '')
                if isinstance(c, list):
                    c = ' '.join(x.get('text', '') for x in c if isinstance(x, dict))
                print(str(c)[:800])
                break
except Exception as ex:
    print(f"(error: {ex})")
PYEOF
        echo ""
        echo "## Tool-uses (Edit/Write/MultiEdit)"
        echo ""
        python3 - <<PYEOF 2>/dev/null || echo "(geen tool-uses gevonden)"
import json
files_seen = set()
try:
    with open("${transcript_path}") as f:
        for line in f:
            try: e = json.loads(line)
            except: continue
            if e.get('type') == 'tool_use' and e.get('name') in ('Edit', 'Write', 'MultiEdit'):
                inp = e.get('input', {})
                fp = inp.get('file_path')
                if fp and fp not in files_seen:
                    files_seen.add(fp)
                    print(f"- {e['name']}: {fp}")
except Exception as ex:
    print(f"(error: {ex})")
PYEOF
    fi
} > "${raw_path}"

# === Stap 2: Processed log (committable, alleen safe metadata) ===
{
    echo "---"
    echo "date: ${today}"
    echo "session-id: ${session_id:-unknown}"
    echo "reason: ${reason}"
    echo "tool-uses: ${tool_uses}"
    echo "content-changes: ${content_changes}"
    echo "type: session"
    echo "status: needs-distillation"
    echo "tags: [session]"
    echo "category: 30-sessions"
    echo "---"
    echo ""
    echo "# Sessie ${today} — ${slug}"
    echo ""
    echo "## Wat is er gebeurd"
    echo ""
    echo "- Reason: ${reason}"
    echo "- Tool uses: ${tool_uses}"
    echo "- Content changes: ${content_changes} bestand(en)"
    echo ""
    echo "## Gewijzigde bestanden"
    echo ""
    if [[ "${content_changes}" -gt 0 ]]; then
        git status --porcelain | sed 's/^/- `/; s/$/`/' | head -20
    else
        echo "_Geen gecommitteerd-relevante wijzigingen._"
    fi
    echo ""
    echo "## Volgende stap"
    echo ""
    echo "Run \`/process-sessions\` om deze sessie te distilleren naar gestructureerde wiki-content."
    echo ""
    echo "---"
    echo ""
    echo "_Raw transcript-data in [\`raw/${timestamp}-${slug}.md\`](raw/${timestamp}-${slug}.md) (gitignored)._"
} > "${processed_path}"

# === Stap 3: Schrijf ingest-marker ===
echo "${session_id}|${raw_path}|${processed_path}|${today}" >> /tmp/cyrix-ingest-backlog.txt

# === Stap 4: Pre-commit safety scan ===
if ! bash .claude/hooks/pre-commit-secret-scan.sh; then
    # HARD findings — stage NIET committen, geef audit-info
    echo "[SESSION-END] Pre-commit scan blokkeerde auto-commit. Audit: wiki/60-audits/" >&2
    exit 0
fi

# === Stap 5: Auto-stage + auto-commit (brede scope) ===
# Stage alleen toegestane paden
git add wiki/ MEMORY.md docs/ 2>/dev/null || true
git add .claude/skills/ .claude/agents/ .claude/rules/ .claude/hooks/ .claude/settings.json 2>/dev/null || true
git add scripts/ integrations/ 2>/dev/null || true
git add ./*.md 2>/dev/null || true

# Alleen committen als er daadwerkelijk staged changes zijn
if git diff --cached --quiet 2>/dev/null; then
    # Niets te committen — verwijder lege processed log
    if [[ -f "${processed_path}" ]] && ! git ls-files --error-unmatch "${processed_path}" > /dev/null 2>&1; then
        # processed_path is untracked, want geen content changes was — laat 'm staan voor audit
        :
    fi
else
    commit_msg="Session ${today}: ${slug}

Auto-commit door SessionEnd hook.
Reason: ${reason} · Tool-uses: ${tool_uses} · Changes: ${content_changes}
Session-ID: ${session_id:-unknown}

Raw log: ${raw_path} (gitignored)
Processed: ${processed_path}

Run /process-sessions om kennis te distilleren naar 20-knowledge/, 50-decisions/, project-READMEs."

    git commit -m "${commit_msg}" 2>&1 | tail -3 || {
        echo "[SESSION-END] Commit faalde (mogelijk geen changes na pre-commit fixes)" >&2
    }
fi

# NIET auto-pushen — eigenaar beslist wanneer

exit 0

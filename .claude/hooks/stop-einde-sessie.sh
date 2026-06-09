#!/usr/bin/env bash
# CYRIX MK-III Stop hook
# Smart-trigger: bij substantiële sessie zonder formele afsluiting een stub-log schrijven.
# De /einde-sessie skill kan een stub later upgraden tot volledige log.

set -euo pipefail

HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${HOOK_DIR}/../.." && pwd)"
cd "${REPO_ROOT}"

# Stop hook ontvangt JSON via stdin met sessie-context
stdin_data=$(cat 2>/dev/null || echo "{}")

# Bepaal aantal tool uses (één van twee signalen voor "substantieel")
tool_uses=$(echo "${stdin_data}" | python3 -c "
import json, sys
try:
    d = json.load(sys.stdin)
    print(d.get('tool_use_count', d.get('tool_uses', 0)))
except Exception:
    print(0)
" 2>/dev/null || echo "0")

# Detectie "substantieel": twee signalen, OR-logica
# Signaal A: content-wijzigingen in tracked folders (echte werk)
content_changes=0
if [[ -d .git ]]; then
    content_changes=$(git status --porcelain wiki/ docs/ .claude/ scripts/ *.md 2>/dev/null | wc -l | tr -d ' ')
fi

# Signaal B: lange sessie (>= 10 tool-uses, ook zonder content-changes)
long_session=0
if [[ "${tool_uses}" -ge 10 ]]; then
    long_session=1
fi

# Triviale sessie: <3 tool-uses (snelle vraag/antwoord) OF geen van beide signalen
if [[ "${tool_uses}" -lt 3 ]] || ( [[ "${content_changes}" -eq 0 ]] && [[ "${long_session}" -eq 0 ]] ); then
    exit 0
fi

today=$(date +%Y-%m-%d)

# Bestaat er al een log voor vandaag? Niet overschrijven.
existing=$(find wiki/30-sessions -name "${today}-*.md" -type f 2>/dev/null | head -n 1)
if [[ -n "${existing}" ]]; then
    exit 0
fi

# Schrijf stub
stub_path="wiki/30-sessions/${today}-onafgesloten.md"
mkdir -p "$(dirname "${stub_path}")"
cat > "${stub_path}" <<EOF
---
date: ${today}
type: session-stub
status: needs-closure
tool-uses: ${tool_uses}
created-by: stop-hook
---

# Onafgesloten sessie ${today}

Deze sessie eindigde zonder \`/einde-sessie\` aanroep. Tool uses: ${tool_uses}.

Run \`/einde-sessie\` in een volgende sessie om deze stub te vervangen met een volledige log, of vul handmatig in.
EOF

exit 0

#!/usr/bin/env bash
# CYRIX MK-III pre-commit safety gate
#
# Wordt aangeroepen door session-end.sh VÓÓR een auto-commit.
# Scant alle staged files op HARD secrets. Bij hit: blokkeert commit en logt audit.
#
# Exit codes:
#   0 = veilig om te committen (mogelijk soft warnings, niet blokkerend)
#   2 = HARD findings — commit MOET geblokkeerd worden

set -euo pipefail

HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${HOOK_DIR}/../.." && pwd)"
cd "${REPO_ROOT}"

# Alleen draaien als er staged files zijn
if [[ -z "$(git diff --cached --name-only --diff-filter=ACM 2>/dev/null)" ]]; then
    exit 0
fi

# Scan via validate.py --staged
audit_dir="wiki/60-audits"
mkdir -p "${audit_dir}"

audit_log="${audit_dir}/blocked-commits-$(date +%Y-%m-%d).md"

scan_output=$(python3 scripts/validate.py --staged 2>&1) && exit_code=0 || exit_code=$?

if [[ "${exit_code}" -eq 2 ]]; then
    # HARD findings — blokkeer en log
    {
        echo ""
        echo "## $(date +%Y-%m-%d\ %H:%M:%S) — Commit blocked"
        echo "**Session-ID:** ${SESSION_ID:-unknown}"
        echo "**Staged files:**"
        git diff --cached --name-only | sed 's/^/  - /'
        echo ""
        echo "**Findings:**"
        echo '```'
        echo "${scan_output}"
        echo '```'
        echo ""
        echo "**Actie nodig:** unstage of scrub met \`scripts/anonymize.py\`."
        echo ""
        echo "---"
    } >> "${audit_log}"

    echo "${scan_output}" >&2
    echo "" >&2
    echo "[PRE-COMMIT] HARD findings — commit geblokkeerd. Audit: ${audit_log}" >&2
    exit 2
fi

if [[ -n "${scan_output}" ]]; then
    echo "${scan_output}" >&2
fi
exit 0

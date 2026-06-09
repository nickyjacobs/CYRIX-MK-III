#!/usr/bin/env bash
# CYRIX MK-III PostToolUse hook (matcher: Edit|Write|MultiEdit)
# Re-scan: vangt secrets die de pre-edit hook gemist heeft.
# Non-blocking als secret gevonden (file is al geschreven) — exit 0 maar print warning.
# Voor Nederlandse markdown: optionele check_verboden_woorden warnings.

set -euo pipefail

HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${HOOK_DIR}/../.." && pwd)"
cd "${REPO_ROOT}"

stdin_data=$(cat 2>/dev/null || echo "{}")

file_path=$(echo "${stdin_data}" | python3 -c "
import json, sys
try:
    d = json.load(sys.stdin)
    ti = d.get('tool_input', {})
    print(ti.get('file_path', ''))
except Exception:
    print('')
" 2>/dev/null || echo "")

if [[ -z "${file_path}" || ! -f "${file_path}" ]]; then
    exit 0
fi

case "${file_path}" in
    *.md|*.json|*.yml|*.yaml|*.sh|*.py) ;;
    *) exit 0 ;;
esac

# Re-scan disk (non-blocking — exit 0 zelfs bij hits, alleen waarschuwen)
python3 scripts/validate.py --file "${file_path}" || {
    echo "[POST-EDIT WARNING] Re-scan vond secrets na write — fix vóór commit." >&2
}

# Optionele NL-check voor .md in docs/, wiki/, root README
case "${file_path}" in
    docs/*.md|wiki/*.md|README.md|*.nl.md)
        if [[ -f scripts/check_verboden_woorden.py ]]; then
            python3 scripts/check_verboden_woorden.py "${file_path}" 2>/dev/null || true
        fi
        ;;
esac

exit 0

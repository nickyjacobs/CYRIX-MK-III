#!/usr/bin/env bash
# CYRIX MK-III PreToolUse hook (matcher: Edit|Write|MultiEdit)
# Hard-block: scant new content op secrets vóór de file wordt geschreven.
# Exit 2 = block (Claude moet content aanpassen).

set -euo pipefail

HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${HOOK_DIR}/../.." && pwd)"
cd "${REPO_ROOT}"

stdin_data=$(cat 2>/dev/null || echo "{}")

# Extract file_path en new content uit Claude Code's tool_input JSON
file_path=$(echo "${stdin_data}" | python3 -c "
import json, sys
try:
    d = json.load(sys.stdin)
    ti = d.get('tool_input', {})
    print(ti.get('file_path', ''))
except Exception:
    print('')
" 2>/dev/null || echo "")

# Geen file_path of niet-relevante extensie: skip
if [[ -z "${file_path}" ]]; then
    exit 0
fi
case "${file_path}" in
    *.md|*.json|*.yml|*.yaml|*.sh|*.py) ;;
    *) exit 0 ;;
esac

# Extract content (Edit/MultiEdit hebben new_string, Write heeft content)
new_content=$(echo "${stdin_data}" | python3 -c "
import json, sys
try:
    d = json.load(sys.stdin)
    ti = d.get('tool_input', {})
    for k in ('content', 'new_string'):
        if k in ti and ti[k]:
            print(ti[k])
            sys.exit(0)
    edits = ti.get('edits', [])
    if edits:
        print('\n'.join(e.get('new_string','') for e in edits))
except Exception:
    pass
" 2>/dev/null || echo "")

if [[ -z "${new_content}" ]]; then
    exit 0
fi

# Run validator
echo "${new_content}" | python3 scripts/validate.py --stdin --path "${file_path}"

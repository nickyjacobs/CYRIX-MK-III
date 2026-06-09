#!/usr/bin/env bash
# CYRIX MK-III SessionStart auto-naming hook
#
# Genereert automatisch een sessie-titel op basis van:
#   1. Git branch (als niet main/master)
#   2. "Volgende concrete stap" uit wiki/00-context/current-priorities.md
#   3. Fallback: session-<datum>-<tijd>
#
# Returnt JSON met hookSpecificOutput.sessionTitle.
# Werkt bij matcher "startup" — niet bij resume (sessie heeft dan al naam).

set -euo pipefail

HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${HOOK_DIR}/../.." && pwd)"
cd "${REPO_ROOT}"

# Helper: slugify een string
slugify() {
    echo "$1" | tr '[:upper:]' '[:lower:]' \
              | tr -cs 'a-z0-9' '-' \
              | sed 's/^-*//; s/-*$//' \
              | cut -c1-40
}

today=$(date +%Y-%m-%d)
title=""

# Strategie 1 — branch-naam (als niet main/master)
branch=$(git branch --show-current 2>/dev/null || echo "")
if [[ -n "${branch}" && "${branch}" != "main" && "${branch}" != "master" ]]; then
    branch_slug=$(slugify "${branch}")
    title="${branch_slug}-${today}"
fi

# Strategie 2 — "Volgende concrete stap" uit current-priorities (als branch niet bruikbaar)
if [[ -z "${title}" && -f wiki/00-context/current-priorities.md ]]; then
    # Pak de eerste niet-lege regel ná "Volgende concrete stap"
    next_step=$(awk '
        /^## Volgende concrete stap/{f=1; next}
        /^## /{f=0}
        f && NF > 0 && !/^>/ && !/^---/{print; exit}
    ' wiki/00-context/current-priorities.md 2>/dev/null | \
        sed 's/[*`#]//g' | \
        awk '{for(i=1;i<=8 && i<=NF;i++) printf "%s ", $i; print ""}')

    if [[ -n "${next_step}" ]]; then
        step_slug=$(slugify "${next_step}")
        if [[ -n "${step_slug}" ]]; then
            title="${step_slug}-${today}"
        fi
    fi
fi

# Strategie 3 — fallback
if [[ -z "${title}" ]]; then
    title="session-${today}-$(date +%H%M)"
fi

# Trim totaal naar 60 chars (Claude Code limit verwacht ~60-80)
title=$(echo "${title}" | cut -c1-60)

# Output JSON
cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "sessionTitle": "${title}"
  }
}
EOF

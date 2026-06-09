#!/usr/bin/env bash
# CYRIX MK-III SessionStart hook
# Dumpt context aan begin van elke sessie:
# - MEMORY.md (max 80 regels)
# - Active priorities uit wiki/00-context/current-priorities.md
# - Laatste 3 sessie-logs
# - Audit-findings ouder dan 7 dagen

set -euo pipefail

# Cd naar repo-root (hook draait vanuit working dir van Claude Code; veiliger om expliciet te navigeren)
HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${HOOK_DIR}/../.." && pwd)"
cd "${REPO_ROOT}"

echo "=== CYRIX MK-III session context ==="
echo ""

# MEMORY (max 80 lines, filtered headings + content)
if [[ -f MEMORY.md ]]; then
    echo "## MEMORY (top 80 regels)"
    head -n 80 MEMORY.md
    echo ""
fi

# Current priorities
if [[ -f wiki/00-context/current-priorities.md ]]; then
    echo "## Huidige prioriteiten"
    # Pak de inhoud onder "## Top prioriteiten" tot de volgende ## heading.
    # Range-overlap vermijden: zet vlag aan ná de header, uit bij de volgende heading.
    awk '/^## Top prioriteiten/{f=1; next} /^## /{f=0} f' \
        wiki/00-context/current-priorities.md \
        | head -n 20 || true
    echo ""
fi

# Last 3 session logs (excluding stubs)
if [[ -d wiki/30-sessions ]]; then
    sessions=$(find wiki/30-sessions -name "*.md" ! -name "*-onafgesloten.md" -type f 2>/dev/null \
               | sort -r | head -n 3)
    if [[ -n "${sessions}" ]]; then
        echo "## Laatste 3 sessies"
        while IFS= read -r s; do
            echo "  - $(basename "$s")"
        done <<< "${sessions}"
        echo ""
    fi
fi

# Open audit findings older than 7 days
if [[ -d wiki/60-audits ]]; then
    old=$(find wiki/60-audits -name "*.md" -mtime +7 -type f 2>/dev/null | head -n 3)
    if [[ -n "${old}" ]]; then
        echo "## Audit-findings ouder dan 7 dagen"
        while IFS= read -r a; do
            echo "  - $(basename "$a")"
        done <<< "${old}"
        echo ""
    fi
fi

# Git status (kort)
if [[ -d .git ]]; then
    changed=$(git status --short 2>/dev/null | wc -l | tr -d ' ')
    if [[ "${changed}" -gt 0 ]]; then
        echo "## Git status: ${changed} gewijzigde bestand(en)"
        git status --short | head -n 10
        echo ""
    fi
fi

echo "=== Einde context ==="

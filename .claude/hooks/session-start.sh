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

# MEMORY (alle inzichten)
# Niet de eerste N regels tonen: MEMORY groeit en een vaste afkap verbergt juist
# de nieuwste inzichten. Het format-blok bovenaan is instructie, geen context.
if [[ -f MEMORY.md ]]; then
    if grep -q '<!-- Begin van de inzichten -->' MEMORY.md; then
        memory_body=$(awk '/<!-- Begin van de inzichten -->/{f=1; next} f' MEMORY.md)
    else
        memory_body=$(cat MEMORY.md)
    fi
    memory_count=$(printf '%s\n' "${memory_body}" | grep -c '^## ' || true)
    echo "## MEMORY (${memory_count} inzichten)"
    printf '%s\n' "${memory_body}" | head -n 400
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
    # maxdepth 1: alleen de gecureerde logs in de root, niet raw/ en processed/
    sessions=$(find wiki/30-sessions -maxdepth 1 -name "*.md" ! -name "*-onafgesloten.md" -type f 2>/dev/null \
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
    # Alleen rapporten die nog openstaan; een afgehandeld rapport krijgt
    # 'status: done' in de frontmatter en verdwijnt dan uit deze melding.
    old=$(find wiki/60-audits -name "*.md" -mtime +7 -type f 2>/dev/null \
          | xargs grep -l '^status: open' 2>/dev/null | head -n 3 || true)
    if [[ -n "${old}" ]]; then
        echo "## Audit-findings ouder dan 7 dagen"
        while IFS= read -r a; do
            echo "  - $(basename "$a")"
        done <<< "${old}"
        echo ""
    fi
fi

# Onverwerkte sessie-logs
# Distillatie via /process-sessions is een handmatige stap. Zonder deze melding
# valt het niet op dat de backlog oploopt, en Claude Code ruimt de onderliggende
# transcripts na enkele weken op: wat dan niet verwerkt is, is niet meer te
# reconstrueren buiten de prompts in de log zelf.
if [[ -d wiki/30-sessions/raw ]]; then
    raw_count=$(find wiki/30-sessions/raw -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
    if [[ "${raw_count}" -gt 0 ]]; then
        oldest=$(find wiki/30-sessions/raw -maxdepth 1 -name "*.md" -type f 2>/dev/null \
                 | sort | head -n 1 | xargs basename 2>/dev/null | cut -c1-10 || true)
        echo "## Onverwerkte sessie-logs: ${raw_count}"
        if [[ -n "${oldest}" ]]; then
            echo "  Oudste: ${oldest}. Draai /process-sessions om ze te distilleren."
        else
            echo "  Draai /process-sessions om ze te distilleren."
        fi
        if [[ "${raw_count}" -ge 10 ]]; then
            echo "  Let op: bij meer dan 10 logs zijn de oudste transcripts waarschijnlijk al opgeruimd."
        fi
        echo ""
    fi
fi

# Wiki-audit reminder
# De cloud-routine ziet alleen de publieke template; de persoonlijke wiki-content
# is gitignored. De echte wiki-audit draait dus lokaal via @wiki-librarian.
if [[ -d wiki/60-audits/lint ]]; then
    last_audit=$(find wiki/60-audits/lint -name "*audit*.md" -type f 2>/dev/null \
                 | xargs ls -t 2>/dev/null | head -n 1 || true)
    if [[ -z "${last_audit}" ]]; then
        echo "## Wiki-audit"
        echo "  Nog geen lokale wiki-audit gedraaid. Start met: @wiki-librarian daily"
        echo ""
    else
        last_mtime=$(stat -f %m "${last_audit}" 2>/dev/null || echo 0)
        audit_age=$(( ( $(date +%s) - last_mtime ) / 86400 ))
        if [[ "${audit_age}" -gt 14 ]]; then
            echo "## Wiki-audit"
            echo "  Laatste lokale audit was ${audit_age} dagen geleden ($(basename "${last_audit}"))."
            echo "  Draai @wiki-librarian daily voor een verse scan van de volledige wiki."
            echo ""
        fi
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

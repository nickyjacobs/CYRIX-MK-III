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
# Distillatie via /process-sessions is een handmatige stap. Die bleef liggen omdat
# niets eraan herinnerde, terwijl Claude Code de onderliggende transcripts na enkele
# weken opruimt: wat dan niet verwerkt is, valt alleen nog uit de prompts in de log
# zelf te reconstrueren. Drempels voorkomen dat dit na elke sessie gaat zeuren en
# daardoor opnieuw genegeerd wordt.
if [[ -d wiki/30-sessions/raw ]]; then
    raw_count=$(find wiki/30-sessions/raw -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
    if [[ "${raw_count}" -gt 0 ]]; then
        oldest_file=$(find wiki/30-sessions/raw -maxdepth 1 -name "*.md" -type f 2>/dev/null | sort | head -n 1 || true)
        oldest_date=$(basename "${oldest_file}" 2>/dev/null | cut -c1-10 || true)
        oldest_days=""
        if [[ -n "${oldest_date}" ]]; then
            oldest_epoch=$(date -j -f "%Y-%m-%d" "${oldest_date}" "+%s" 2>/dev/null || echo "")
            if [[ -n "${oldest_epoch}" ]]; then
                oldest_days=$(( ( $(date +%s) - oldest_epoch ) / 86400 ))
            fi
        fi

        echo "## Onverwerkte sessie-logs: ${raw_count}"
        if [[ -n "${oldest_days}" ]]; then
            echo "  Oudste: ${oldest_date} (${oldest_days} dagen geleden)."
        fi

        # Voorstellen vanaf 3 logs of zodra de oudste ouder is dan 7 dagen.
        # Daaronder alleen tellen: bij een of twee verse logs is er geen haast.
        should_prompt=0
        [[ "${raw_count}" -ge 3 ]] && should_prompt=1
        [[ -n "${oldest_days}" && "${oldest_days}" -gt 7 ]] && should_prompt=1

        if [[ "${should_prompt}" -eq 1 ]]; then
            if [[ "${raw_count}" -ge 10 || ( -n "${oldest_days}" && "${oldest_days}" -gt 21 ) ]]; then
                echo "  De oudste transcripts zijn waarschijnlijk al opgeruimd; wat daar niet uit de"
                echo "  log zelf te halen is, is weg."
            fi
            echo ""
            echo "  INSTRUCTIE AAN CYRIX: stel in je eerste antwoord in een enkele zin voor om deze"
            echo "  logs te verwerken met /process-sessions, en noem waarom het nu relevant is"
            echo "  (aantal, ouderdom, transcript-retentie). Doe dat als losse regel na je antwoord"
            echo "  op de vraag van de gebruiker, niet als opening. Slaat de gebruiker het af of"
            echo "  gaat het gesprek een andere kant op, laat het dan rusten voor deze sessie."
        else
            echo "  Nog geen haast. /process-sessions verwerkt ze."
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

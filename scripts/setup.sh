#!/usr/bin/env bash
# CYRIX MK-III interactive setup
# Begeleidt eerste configuratie na "Use this template" fork.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${REPO_ROOT}"

echo ""
echo "================================="
echo "  CYRIX MK-III — interactive setup"
echo "================================="
echo ""

# Check prerequisites
if ! command -v claude > /dev/null 2>&1; then
    echo "[WARN] Claude Code CLI niet gevonden. Installeer via https://claude.ai/install of brew."
    echo "       Setup gaat door, maar Claude Code wordt niet gestart aan het einde."
fi

# Step 1 — wiki/00-context examples → real files
echo "[1/4] Setup persoonlijke context in wiki/00-context/"
for example in wiki/00-context/*.example.md; do
    real="${example%.example.md}.md"
    if [[ -f "${real}" ]]; then
        echo "    SKIP: ${real} bestaat al"
        continue
    fi
    cp "${example}" "${real}"
    echo "    OK:   ${real} (kopie van $(basename "${example}"))"
done
echo ""
echo "    -> Open ${REPO_ROOT}/wiki/00-context/ in je editor en vul de me.md, work.md, team.md, current-priorities.md, goals.md in."
echo ""

# Step 2 — wiki/50-decisions/log example → real
echo "[2/4] Setup decisions log"
if [[ -f wiki/50-decisions/log.md ]]; then
    echo "    SKIP: wiki/50-decisions/log.md bestaat al"
else
    cp wiki/50-decisions/log.example.md wiki/50-decisions/log.md
    echo "    OK:   wiki/50-decisions/log.md (kopie van example)"
fi
echo ""

# Step 3 — CLAUDE.local.md
echo "[3/4] Setup CLAUDE.local.md (persoonlijke identiteit + overrides)"
if [[ -f CLAUDE.local.md ]]; then
    echo "    SKIP: CLAUDE.local.md bestaat al"
else
    cat > CLAUDE.local.md <<'EOF'
# CYRIX MK-III — lokale identiteit en overrides

> Dit bestand is gitignored. Persoonlijke configuratie hoort hier.

## Persoonlijke rules

# @.claude/rules-private/identity.md            # uncomment + create file als je gebruikt
# @.claude/rules-private/security-personal.md
# @.claude/rules-private/writing-personal.md

## Eigenaar

- Naam: <vul in>
- Aanspreekvorm: <bv. voornaam>
- Focus: <waaraan werk je primair>

## Notities

- Pas deze file aan naar wens — alles hierin wordt automatisch geladen door Claude Code naast CLAUDE.md.
EOF
    echo "    OK:   CLAUDE.local.md aangemaakt — vul je identiteit in"
fi
echo ""

# Step 4 — .env
echo "[4/4] Setup .env (API keys)"
if [[ -f .env ]]; then
    echo "    SKIP: .env bestaat al"
else
    cp .env.example .env
    echo "    OK:   .env (kopie van .env.example) — vul je API keys in"
fi
echo ""

# Optioneel: rules-private folder
echo "[OPT] Wil je een persoonlijke rules-private folder aanmaken? [y/N]"
read -r answer
if [[ "${answer}" =~ ^[yY]$ ]]; then
    mkdir -p .claude/rules-private
    touch .claude/rules-private/identity.md \
          .claude/rules-private/security-personal.md \
          .claude/rules-private/writing-personal.md
    echo "    OK: .claude/rules-private/ aangemaakt met 3 lege override-files"
    echo "        Vul ze in en uncomment de @imports in CLAUDE.local.md"
fi
echo ""

echo "================================="
echo "  Setup voltooid"
echo "================================="
echo ""
echo "Volgende stappen:"
echo "  1. Vul wiki/00-context/*.md aan met je eigen profiel/werk/doelen"
echo "  2. Vul .env aan met API keys (GitHub, Tavily, optioneel Home Assistant)"
echo "  3. Vul CLAUDE.local.md aan met je naam en aanspreekvorm"
echo "  4. Open Obsidian → Open folder as vault → wiki/"
echo "  5. Start een sessie: claude"
echo ""
echo "Documentatie: docs/routines.md (cloud routines), docs/verificatie-fase1.md (checks)"
echo ""

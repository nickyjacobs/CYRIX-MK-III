# CYRIX MK-III — Verificatie fase 1

> Status: 2026-06-09 · Repo: https://github.com/nickyjacobs/cyrix-mk-iii

## Automatische tests (PASS)

### ✅ SessionStart hook draait standalone

Manueel uitgevoerd `bash .claude/hooks/session-start.sh` — dumpt MEMORY, priorities, last sessions, git status zoals verwacht.

### ✅ Privacy: persoonlijke data niet op GitHub

`gh api repos/nickyjacobs/cyrix-mk-iii/contents/wiki/00-context` levert alleen 5 `.example.md` files. Echte `me.md`, `work.md`, `team.md`, `current-priorities.md`, `goals.md` zijn lokaal aanwezig maar gitignored. Ook `wiki/50-decisions/log.md` blijft lokaal.

### ✅ Pre-edit hook blokkeert secrets

Test-input met fake GitHub PAT (`ghp_*36chars`) → hook exit 2 (hard block), error-output naar stderr met file:line:type.

### ✅ Pre-edit hook laat clean content door

Test-input zonder secrets → hook exit 0.

### ✅ validate.py detecteert secret-patterns

Standalone test: Tavily key, GitHub PAT, AWS access key, JWT, /Users/-paden — alle gedetecteerd, exit 2.

### ✅ check_verboden_woorden.py advisory werkt

Test-input met "essentieel", "proactief", "baanbrekend", "passie", em-dash → 5 advisory-warnings, non-blocking exit 0.

---

## Handmatige checks (vragen jouw actie)

Loop deze door in een nieuwe `claude` sessie binnen `~/Desktop/Agentic AI Workflows/My/cyrix-mk-iii/`:

### ☐ Check 1: SessionStart in echte sessie

1. `cd ~/Desktop/Agentic\ AI\ Workflows/My/cyrix-mk-iii`
2. `claude`
3. Verwacht: MEMORY-content + huidige prioriteiten + last sessions verschijnen automatisch bovenaan sessie

### ☐ Check 2: `/search` werkt + Tavily fallback

1. In een sessie: `/search latest Claude Code routines documentation`
2. Verwacht: resultaten met top-3 bronnen
3. Vervolgens test fallback: tijdelijk `unset TAVILY_API_KEY` in shell, herstart claude, `/search` opnieuw
4. Verwacht: WebSearch + WebFetch fallback wordt automatisch gebruikt, geen errors

### ☐ Check 3: `/ingest` werkt

1. `/ingest https://code.claude.com/docs/en/routines`
2. Verwacht: pagina(s) gecrawld, samenvatting in `wiki/40-references/claude-code/routines.md` met frontmatter, link in `00-index.md` toegevoegd

### ☐ Check 4: `/einde-sessie` schrijft sessie-log

1. Na minimaal 5 tool-uses in een sessie: `/einde-sessie`
2. Verwacht: 
   - `wiki/30-sessions/2026-06-09-<slug>.md` aangemaakt
   - `MEMORY.md` met eventuele nieuwe inzichten ge-merged
   - Bij besluiten: append in `wiki/50-decisions/log.md`

### ☐ Check 5: Stop hook schrijft stub

1. Werk een sessie met >5 tool-uses, sluit dan zonder `/einde-sessie`
2. Verwacht: `wiki/30-sessions/2026-06-09-onafgesloten.md` aangemaakt

### ☐ Check 6: Obsidian opent wiki/

1. Obsidian → "Open folder as vault" → kies `~/Desktop/Agentic AI Workflows/My/cyrix-mk-iii/wiki/`
2. Verwacht: 
   - `index.md` opent als landingspagina
   - Wikilinks `[[00-context/me]]` werken
   - 8 folder-categorieën zichtbaar

### ☐ Check 7: `/dutch-write` past DutchQuill-regels toe

1. `/dutch-write Het is essentieel om proactief te zijn — onze passie is baanbrekend.`
2. Verwacht: herschrijving zonder verboden woorden + zonder em-dash, met rapportage van wat veranderd is

### ☐ Check 8: GitHub-template testfork

1. Login met een tweede GitHub-account (of incognito)
2. Ga naar https://github.com/nickyjacobs/cyrix-mk-iii → "Use this template"
3. Verwacht: 
   - Skelet wordt gefork zonder persoonlijke data
   - Alleen `.example.md` files zichtbaar in `wiki/00-context/`
   - `wiki/50-decisions/log.md` ontbreekt (gitignored)
   - `MEMORY.md` is leeg-template-versie

---

## Open / nog niet relevant in fase 1

### ⏸ Check: Externe workspace lazy-lookup

> "Vanuit Pentest-workspace (eenvoudige test: tweede terminal met andere cwd, `.mcp.json` met obsidian-MCP) is `wiki/10-projects/pentest/` leesbaar/schrijfbaar."

**Status:** **Skip voor fase 1.** Externe workspaces aansluiten is fase 2 (zie `docs/routines.md` + roadmap). Lazy-lookup pad via Pentest/THM/homelab `.mcp.json` aanpassen gebeurt dan.

### ⏸ Check: daily-audit-snapshot.sh standalone

> "scripts/daily-audit-snapshot.sh draait standalone en produceert findings-bestand."

**Status:** **Niet gebouwd in fase 1.** Het plan benoemde dit als optie naast de `wiki-librarian` agent + routines. We hebben gekozen voor de routine-route (zie `docs/routines.md`). Een no-LLM standalone audit-script kan in fase 2 als snelheidsoptimalisatie.

---

## Conclusie fase 1

**6 automatische tests PASS.** 8 handmatige checks staan klaar om door te lopen in een verse Claude Code sessie binnen MK-III.

Fase 1 deliverables uit het plan:

- [x] Repo aangemaakt (`nickyjacobs/cyrix-mk-iii`, publiek, template-enabled)
- [x] Repo skeleton + `.gitignore` + `.mcp.json` + `.claude/rules/`
- [x] Wiki-vault skeleton + `index.md` bento-grid + `_templates/`
- [x] MCP servers geconfigureerd (GitHub + Tavily; HA via `.env.example` placeholder)
- [x] Skills: `/search`, `/einde-sessie`, `/ingest`, `/dutch-write` (4 i.p.v. 5 omdat `/new-page` en `/jot` geschrapt)
- [x] Hooks: SessionStart, Stop, PreToolUse, PostToolUse
- [x] MEMORY.md template
- [x] MK-II context + decisions gemigreerd
- [x] Eerste ingest: Claude Code docs, DutchQuill
- [x] CLAUDE.md/CLAUDE.local.md split (publiek/privé)

Open voor fase 2:

- [ ] `wiki-librarian` cloud-routines opzetten (zie `docs/routines.md`)
- [ ] Externe workspaces (Pentest/THM/homelab) `.mcp.json` aansluiten op gedeelde wiki
- [ ] Subpagina frontmatter retroactief toevoegen op Claude Code docs (wiki-librarian zal flagged)
- [ ] Project-migratie uit MK-II (`certifications`, `woning-griendweg`, `z900-motor`, etc.)
- [ ] Bento-grid CSS-snippets voor `wiki/.obsidian/snippets/` (visuele polish)
- [ ] Skill-publicatie als Claude Code plugin (fase 3)

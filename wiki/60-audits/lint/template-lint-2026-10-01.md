---
title: Template-lint 2026-10-01
date: 2026-10-01
type: audit
category: 60-audits
status: open
tags: [audit, template-lint, cyrix-template-lint, hygiene]
---

# Template-lint 2026-10-01

Maandelijkse lint van de publieke CYRIX MK-III template: consistentie tussen documentatie en
werkelijkheid, links en frontmatter in het publieke deel van de wiki, template-bruikbaarheid,
schrijfstijl (advisory) en hygiene (persoonlijke content die niet in een publieke template hoort).

De gitignored persoonlijke wiki-mappen (`00-context/`, `10-projects/`, `20-knowledge/`,
`30-sessions/`, `50-decisions/`, `90-archives/`) zitten niet in deze checkout. Dat is de
bedoeling en komt dus niet terug als finding.

## Samenvatting

- Findings HOOG: 3
- Findings MIDDEN: 6
- Findings LAAG: 2
- Stijl-advisory: zie sectie onderaan, non-blocking

---

## HOOG

### Hygiene: persoonlijke content in de publieke template

- [ ] `wiki/40-references/ninja-possiblecooker-mc1001eu.md` bevat de voornaam van de eigenaar
  ("Nicky", meerdere keren) plus persoonlijke context (een specifiek keukenapparaat, het
  persoonlijke "Gezondheid"-project). Dit is precies het soort content dat `40-references/index.md`
  zelf uitsluit ("references zijn niet-persoonlijk, publieke docs, dus committable"). Het is ook
  een regressie: commit `03bacc8` (2026-09-10, "Fix: persoonlijke content uit de publieke template
  halen") verwijderde al eens dit soort content, en vier dagen later kwam dit bestand er via
  `/ingest` weer bij.
  - **Voorgestelde actie:** verwijder het bestand uit de publieke template of verplaats het naar
    een gitignored locatie (bijvoorbeeld `wiki/90-archives/` is ook publiek niet geschikt; een
    persoonlijke `10-projects/`-notitie is de juiste plek). Overweeg een guard in de `/ingest`
    skill of de `wiki-librarian` die op eigennamen in `40-references/` controleert, zodat dit niet
    een derde keer gebeurt.
  - **First seen:** 2026-10-01

- [ ] `wiki/40-references/log.md` bevat de voornaam van de eigenaar meerdere keren en een
  letterlijk thuismap-pad (`~/Desktop/Agentic AI Workflows/DutchQuill AI/`, regel 42), plus
  beschrijvingen van persoonlijke projecten (Gezondheid, CPTS-certificering).
  - **Voorgestelde actie:** scrub namen en paden uit de audit-trail, of verplaats de entries die
    persoonlijke ingests beschrijven naar een gitignored log. Vervang het thuismap-pad door een
    generieke verwijzing ("lokale DutchQuill AI-checkout").
  - **First seen:** 2026-10-01

- [ ] `docs/archief/verificatie-fase1.md` en `docs/archief/verificatie-fase2.md` bevatten
  herhaaldelijk een letterlijk thuismap-pad (`~/Desktop/Agentic AI Workflows/My/CYRIX-MK-III/`,
  o.a. fase1 regels 45, 49, 80 en fase2 regels 36, 93). Root cause: `scripts/validate.py` regel
  59-60 detecteert alleen `/Users/<naam>/` en `/home/<naam>/`, geen `~/`-paden. Daardoor hebben de
  pre-edit-, post-edit- en pre-commit-secret-scans (die alle drie op dezelfde pattern-library
  draaien) dit pad nooit geblokkeerd.
  - **Voorgestelde actie:** vervang de paden in beide bestanden door een generieke placeholder
    (bijvoorbeeld `~/<jouw-pad>/CYRIX-MK-III/`), en voeg een `~/`-pattern toe aan de
    `PATTERNS`-lijst in `scripts/validate.py` (en aan de "Pad-leaks"-sectie van
    `.claude/agents/security-reviewer.md`, die ook alleen `/Users/` en `/home/` noemt) zodat
    tilde-paden voortaan wel hard blokkeren.
  - **First seen:** 2026-10-01

---

## MIDDEN

### Consistentie

- [ ] README.md, sectie **Agents**: de tabel zegt dat `security-reviewer` getriggerd wordt door
  de "post-edit hook + manual". In werkelijkheid roept `.claude/hooks/post-edit-secret-scan.sh`
  alleen `scripts/validate.py` aan (regex-scan), niet de agent zelf. De agent draait uitsluitend
  handmatig via `@security-reviewer`. Dat is relevant omdat juist de agent (niet de regex-scan)
  namen en persoonlijke content zou opmerken, zie de HOOG-findings hierboven.
  - **Voorgestelde actie:** pas de tabel aan naar "manual (`@security-reviewer`)" of koppel de
    agent daadwerkelijk aan de PostToolUse-hook.
  - **First seen:** 2026-10-01

- [ ] README.md, architectuurdiagram, regel `scripts/`: noemt `validate.py,
  check_verboden_woorden.py, setup.sh, statusline.example.sh`, maar niet `scripts/anonymize.py`.
  Dat script wordt wel actief gebruikt: `pre-commit-secret-scan.sh` regel 44 verwijst er als
  aanbevolen remedy naar.
  - **Voorgestelde actie:** voeg `anonymize.py` toe aan de scripts-regel in het diagram.
  - **First seen:** 2026-10-01

- [ ] `scripts/setup.sh`, laatste regel (134): verwijst naar `docs/verificatie-fase1.md`. Het
  bestand staat op `docs/archief/verificatie-fase1.md`.
  - **Voorgestelde actie:** pad in de echo-regel corrigeren naar `docs/archief/verificatie-fase1.md`.
  - **First seen:** 2026-10-01

- [ ] `docs/archief/README.md`, regel 10: verwijst naar `wiki/60-audits/audit-2026-09-10-compleet.md`,
  dat niet bestaat in deze checkout.
  - **Voorgestelde actie:** maak het bestand aan, of pas de verwijzing aan naar een bestaand
    actueel-staat-bestand (bijvoorbeeld `wiki/60-audits/lint/_tracking.md`), of verwijder de zin
    als er geen actueel "compleet"-overzicht meer bijgehouden wordt.
  - **First seen:** 2026-10-01

### Template-bruikbaarheid

- [ ] `docs/routines.md` hardcodet `nickyjacobs/CYRIX-MK-III` als voorbeeld-repo in drie
  copy-paste-commando's (regels 54, 74, 86), terwijl README.md's eigen quick-start-conventie een
  placeholder gebruikt (`git clone https://github.com/<you>/CYRIX-MK-III.git`). Een forker die de
  `/schedule`-commando's letterlijk overneemt, zet daarmee routines op tegen de repo van de
  template-eigenaar in plaats van de eigen fork.
  - **Voorgestelde actie:** vervang `nickyjacobs/CYRIX-MK-III` door een placeholder zoals
    `<jouw-gebruikersnaam>/CYRIX-MK-III`, consistent met README.md.
  - **First seen:** 2026-10-01

- [ ] `wiki/40-references/cpts-tips-brm.md` is een persoonlijke cert-voorbereidingsnotitie
  (video-samenvatting plus de eigenaar se eigen naamgevingskeuze voor een methodology-checklist)
  die inhoudelijk weinig waarde heeft voor een forker, en qua toon afwijkt van de generieke
  publieke references (vergelijk met de `claude-code/`- en `dutchquill/`-pagina's). Minder
  acuut dan de HOOG-findings omdat de eigenaar zelf niet met naam genoemd wordt, maar wel
  inconsistent met de eigen regel in `40-references/index.md` dat references "niet-persoonlijk"
  moeten zijn.
  - **Voorgestelde actie:** beoordeel of dit bestand generiek bruikbaar gemaakt kan worden (puur
    de CPTS-tips, zonder de eigen-naamgeving-sectie) of beter naar een persoonlijke, gitignored
    locatie verplaatst wordt.
  - **First seen:** 2026-10-01

---

## LAAG

- [ ] README.md's Hooks-sectie en architectuurdiagram vermelden niet de losse
  `.claude/hooks/session-name.sh` (apart gewired onder `SessionStart` met matcher `"startup"` in
  `.claude/settings.json`, auto-naamgeving van de sessie). De huidige SessionStart-bullet
  beschrijft alleen het gedrag van `session-start.sh`.
  - **Voorgestelde actie:** voeg een losse bullet of sub-punt toe voor de auto-naming hook.
  - **First seen:** 2026-10-01

- [ ] `.env.example`, README.md (quick start) en `scripts/setup.sh` noemen een optionele Home
  Assistant-integratie (`HASS_URL`, `HASS_TOKEN`), maar nergens in de repo (`.mcp.json`,
  `.claude/skills/`, `integrations/`) bestaat daadwerkelijk een MCP-server, skill of integratie
  die deze variabelen gebruikt.
  - **Voorgestelde actie:** verwijder de HA-variabelen uit `.env.example` tot er een echte
    integratie is, of voeg een korte noot toe dat dit een geplande/toekomstige integratie is.
  - **First seen:** 2026-10-01

---

## Stijl (advisory, non-blocking)

`python3 scripts/check_verboden_woorden.py` gedraaid op README.md en op alle bestanden in
`docs/`:

- **README.md:** 24 hits, bijna allemaal em-dashes in bullet-structuren (regels 4, 19, 27-32,
  108-112, 141, 145, 147-148, 154-156, 160-162, 166). Geen treffers op verboden woorden.
- **docs/archief/verificatie-fase1.md:** 18 hits (em-dashes plus de woorden essentieel,
  baanbrekend, proactief, passie, uitgebreid). Grotendeels bewuste test-strings die de
  secret-scanner en de stijl-checker zelf testen (regels 39 en 88), dus geen echte
  schrijfstijl-fout. Regel 7, 11, 15, 19, 35 en 121 zijn wel gewone lopende tekst met em-dashes.
- **docs/archief/verificatie-fase2.md:** schoon.
- **docs/archief/README.md:** schoon.
- **docs/routines.md:** schoon.

Geen van deze zijn blokkerend. Fix bij gelegenheid, bijvoorbeeld met `/dutch-write`.

---

## Niet gevonden (gecontroleerd, geen finding)

- CLAUDE.md somt alle 6 skills in `.claude/skills/` en alle 3 agents in `.claude/agents/`
  correct op.
- README.md's skills-tabel, agents-tabel (op de trigger-kolom na) en de 5 rules in
  `.claude/rules/` kloppen met de werkelijkheid.
- De hook-events in `.claude/settings.json` komen overeen met de scripts in `.claude/hooks/`.
- Frontmatter in `wiki/40-references/`, `wiki/_templates/`, `wiki/00-context/*.example.md`,
  `wiki/50-decisions/log.example.md` en de index-pagina's volgt de conventie in `wiki/index.md`
  consistent.
- Wikilinks in `wiki/index.md`, `wiki/_templates/` en de `.example`-bestanden die naar
  persoonlijke pagina's wijzen, zijn bewust gedocumenteerde placeholders, geen gebroken links.
- `.env.example` komt overeen met wat `.mcp.json` nodig heeft (GITHUB_TOKEN, TAVILY_API_KEY),
  met uitzondering van de losse HA-variabelen, zie LAAG hierboven.
- De DutchQuill-cijfers in `integrations/dutchquill/README.md` (26 verboden woorden, 6
  openers, 7 schrijfregels) kloppen exact met `wiki/40-references/dutchquill/schrijfstijl.md`
  en met `scripts/check_verboden_woorden.py`.

---
title: "Daily Audit 2026-06-20"
date: 2026-06-20
type: audit
audit-date: 2026-06-20
audit-mode: daily
findings-total: 13
findings-hard: 8
findings-soft: 5
---

# Wiki audit 2026-06-20 (daily)

## Samenvatting

- Files gescand: 52
- Hard findings: 8
- Soft findings: 5
- Geescaleerd vanuit vorige cadens: 4 (hard findings van 2026-06-09, >10 dagen open)

- Vier hard findings van audit 2026-06-09 zijn opgelost: broken wikilinks in `index.md` (10-projects, 20-knowledge, 40-references, 50-decisions) en `wiki/index.md` had al een `title`-veld.
- Vier hard findings blijven open en escaleren naar weekly: twee sessies missen `title`-veld, twee raw-transcript-links zijn broken.
- Nieuw gevonden: `40-references/log.md` heeft verkeerde frontmatter-velden (`created`/`updated` in plaats van `ingest-date`/`review-date`), en `30-sessions/processed/2026-06-10-1838-session.md` heeft malformed YAML (`0` op losse regel).
- Alle 7 sessie-stubs staan op `status: needs-distillation` — al 5 tot 10 dagen oud zonder `/process-sessions`.
- Orphan-pagina's in `30-sessions/processed/` zijn per definitie niet gelinkt — acceptabel voor sessie-logs (soft).

---

## Hard findings

### Geescaleerd vanuit 2026-06-09 (>10 dagen open)

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — mist verplicht frontmatter-veld `title`
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10: session"` toe aan de frontmatter
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — mist verplicht frontmatter-veld `title`
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10: kan-je-me-de-vergelijking-benchmarks-gev"` toe aan de frontmatter
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md:34` — link naar `../raw/2026-06-10-0011-session.md` verwijst naar een bestand dat niet bestaat (`30-sessions/raw/` is leeg)
  - **Voorgestelde actie:** verwijder de raw-link of herstel het raw-bestand in `wiki/30-sessions/raw/`
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` — link naar `../raw/2026-06-10-0025-kan-je-me-de-vergelijking-benchmarks-gev.md` verwijst naar een bestand dat niet bestaat
  - **Voorgestelde actie:** verwijder de raw-link of herstel het raw-bestand in `wiki/30-sessions/raw/`
  - **First seen:** 2026-06-09

### Broken links (nieuw)

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md:32` — link naar `../raw/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` verwijst naar een bestand dat niet bestaat
  - **Voorgestelde actie:** verwijder de raw-link of herstel het bestand in `wiki/30-sessions/raw/`
  - **First seen:** 2026-06-20

- [ ] `wiki/30-sessions/processed/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md:33` — link naar `../raw/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md` bestaat niet
  - **Voorgestelde actie:** verwijder de raw-link of herstel het bestand in `wiki/30-sessions/raw/`
  - **First seen:** 2026-06-20

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md:34` — link naar `../raw/2026-06-10-1838-session.md` bestaat niet
  - **Voorgestelde actie:** verwijder de raw-link
  - **First seen:** 2026-06-20

- [ ] `wiki/30-sessions/processed/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md:32` — link naar `../raw/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md` bestaat niet
  - **Voorgestelde actie:** verwijder de raw-link
  - **First seen:** 2026-06-20

- [ ] `wiki/30-sessions/processed/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md:37` — link naar `../raw/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md` bestaat niet
  - **Voorgestelde actie:** verwijder de raw-link
  - **First seen:** 2026-06-20

### Onjuiste frontmatter-velden (nieuw)

- [ ] `wiki/40-references/log.md` — gebruikt `created`/`updated` maar behoort als `40-references/`-bestand `ingest-date` en `review-date` te gebruiken (geen `source-url` aanwezig)
  - **Voorgestelde actie:** vervang `created` door `ingest-date`, vervang `updated` door `review-date`, voeg `source-url: internal` toe
  - **First seen:** 2026-06-20

### Malformed frontmatter (nieuw)

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md` — YAML-frontmatter bevat een losse `0` op regel 6 (na `tool-uses: 0`), wat de YAML ongeldig maakt
  - **Voorgestelde actie:** verwijder de losse `0` op regel 6 van de frontmatter
  - **First seen:** 2026-06-20

---

## Soft findings

### Orphan pages (acceptabel voor sessie-logs)

- [ ] `wiki/30-sessions/processed/` — alle 7 sessie-stubs zijn orphan pages (geen backlinks vanuit andere wiki-content)
  - **Voorgestelde actie:** acceptabel zolang sessies `status: needs-distillation` dragen. Overweeg een index-pagina in `30-sessions/` aan te maken die alle processed sessions opsomt.
  - **First seen:** 2026-06-20

### Orphan audit-bestanden

- [ ] `wiki/60-audits/lint/docs-drift-claudecode-2026-06-10.md` — geen backlinks vanuit andere wiki-content
  - **Voorgestelde actie:** acceptabel als stand-alone audit-rapport; overweeg een `60-audits/index.md` aan te maken.
  - **First seen:** 2026-06-20

### Sessies wachten op distillatie

- [ ] 7 sessie-stubs in `wiki/30-sessions/processed/` staan op `status: needs-distillation`, oudste van 2026-06-10 (10 dagen geleden)
  - **Voorgestelde actie:** run `/process-sessions` om de relevante sessies te distilleren naar `20-knowledge/`. Niet-substantieve sessies (tool-uses 0 of alleen context-vragen) mogen direct op `status: archived` gezet worden.
  - **First seen:** 2026-06-20

### Soft finding geescaleerd vanuit 2026-06-09 (>10 dagen)

- [ ] `wiki/50-decisions/log.example.md:23` — wikilink `[[30-sessions/YYYY-MM-DD-slug]]` is een templateplaatshouder, geen echte link
  - **Voorgestelde actie:** acceptabel als voorbeeld; overweeg een code-block of HTML-comment om de placeholder te markeren zodat link-checkers hem overslaan.
  - **First seen:** 2026-06-09

---

## Opgeloste findings (vergeleken met 2026-06-09)

- [x] `wiki/index.md:34` — wikilink `[[10-projects/index]]` — **opgelost** (`10-projects/index.md` bestaat nu)
- [x] `wiki/index.md:43` — wikilink `[[20-knowledge/index]]` — **opgelost** (`20-knowledge/index.md` bestaat nu)
- [x] `wiki/index.md:61` — wikilink `[[40-references/index]]` — **opgelost** (`40-references/index.md` bestaat nu)
- [x] `wiki/index.md:70` — wikilink `[[50-decisions/log]]` — **opgelost** (link aangepast naar `log.example`)
- [x] `wiki/index.md` — miste `title`-veld — **opgelost** (title aanwezig)

---

## Escalatie-status

- Findings ouder dan 7d die naar weekly escaleren: 4
  - `wiki/30-sessions/processed/2026-06-10-session.md` — missend title-veld (first seen 2026-06-09)
  - `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — missend title-veld (first seen 2026-06-09)
  - `wiki/30-sessions/processed/2026-06-10-session.md:34` — broken raw-link (first seen 2026-06-09)
  - `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` — broken raw-link (first seen 2026-06-09)
- Findings ouder dan 30d die naar monthly escaleren: 0

---

## Wiki-structuuroverzicht

| Map | Bestanden | Status |
|-----|-----------|--------|
| `00-context/` | 5 (alleen `.example.md`) | Template-only, persoonlijke invulling lokaal (gitignored) |
| `10-projects/` | 1 (index) | Alleen index aanwezig, projecten zijn lokaal |
| `20-knowledge/` | 1 (index) | Alleen index aanwezig, kennis-notes zijn lokaal |
| `30-sessions/processed/` | 7 | Alle 7 wachten op distillatie |
| `40-references/claude-code/` | 24 | Goed gevuld, review-date 2026-09-09/10 |
| `40-references/dutchquill/` | 4 | Volledig, review-date 2026-09-09 |
| `50-decisions/` | 1 (alleen `.example.md`) | Echte log is lokaal (gitignored) |
| `60-audits/lint/` | 3 (incl. dit rapport) | Actief |
| `90-archives/` | 0 | Leeg |
| `_templates/` | 4 | Compleet |

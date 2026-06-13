---
title: "Daily Wiki Audit 2026-06-13"
date: 2026-06-13
type: audit
mode: daily
audit-date: 2026-06-13
audit-mode: daily
findings-total: 10
findings-hard: 7
findings-soft: 3
---

# Wiki audit 2026-06-13 (daily)

## Samenvatting

- Files gescand: 46
- Hard findings: 7
- Soft findings: 3
- Geescaleerd vanuit vorige cadens: 6 (open findings uit 2026-06-09 audit, nu >7 dagen oud)

---

## Hard findings

### Broken wikilinks

- [ ] `wiki/20-knowledge/index.md:16` — wikilink `[[wikilinks]]` is een broken placeholder-link ingebed in een instructietekst
  - **Voorgestelde actie:** vervang door backtick-notatie `` `[[wikilinks]]`` zodat het als code wordt weergegeven, niet als kapotte wikilink
  - **First seen:** 2026-06-13

### Geescaleerd vanuit daily-audit 2026-06-09 (>7 dagen open)

- [ ] `wiki/index.md:34` — wikilink `[[10-projects/index]]` verwijst naar `wiki/10-projects/index.md` — OPGELOST (bestand bestaat nu)
  - **Status:** resolved, bestand aanwezig na re-scan

- [ ] `wiki/index.md:43` — wikilink `[[20-knowledge/index]]` verwijst naar `wiki/20-knowledge/index.md` — OPGELOST
  - **Status:** resolved, bestand aanwezig na re-scan

- [ ] `wiki/index.md:61` — wikilink `[[40-references/index]]` verwijst naar `wiki/40-references/index.md` — OPGELOST
  - **Status:** resolved, bestand aanwezig na re-scan

- [ ] `wiki/index.md:70` — wikilink `[[50-decisions/log.example]]` — link bestaat en resolvet correct
  - **Status:** resolved

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md:34` — link naar `../raw/2026-06-10-0011-session.md` verwijst naar een gitignored bestand dat niet aanwezig is in de working tree
  - **Voorgestelde actie:** verwijder de link of annoteer expliciet dat het raw-bestand gitignored is (bijv. in commentaar)
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` — link naar `../raw/2026-06-10-0025-kan-je-me-de-vergelijking-benchmarks-gev.md` verwijst naar een gitignored bestand
  - **Voorgestelde actie:** verwijder de link of annoteer als gitignored
  - **First seen:** 2026-06-09

### Ontbrekende frontmatter-velden

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — mist verplicht veld `title` (categorie `30-sessions` vereist: `title`, `date`, `type`, `status`, `tags`, `category`)
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — session"` toe aan de frontmatter
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — mist verplicht veld `title`
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — kan-je-me-de-vergelijking-benchmarks-gev"` toe aan de frontmatter
  - **First seen:** 2026-06-09

- [ ] `wiki/40-references/log.md` — in categorie `40-references` maar gebruikt `created`/`updated` in plaats van `ingest-date`/`review-date`. Mist ook `source-url`.
  - **Voorgestelde actie:** dit is een intern log-bestand, geen externe reference. Overweeg `category: internal-log` of voeg de verplichte reference-velden toe als je het als reference behoudt.
  - **First seen:** 2026-06-13

---

## Soft findings

### Orphan pages

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` — geen enkel wiki-bestand linkt naar deze sessie
  - **Voorgestelde actie:** verwacht gedrag voor sessie-notes; optioneel een sessie-index aanmaken in `30-sessions/`
  - **First seen:** 2026-06-13

### Broken directory-link

- [ ] `wiki/index.md:113` — relatieve link `[_templates/](./_templates/)` verwijst naar een directory, niet een bestand. Werkt niet als markdown-link in de meeste renderers.
  - **Voorgestelde actie:** wijzig naar een link naar een specifieke template, bijv. `[_templates/knowledge-note.md](./_templates/knowledge-note.md)`, of verwijder de hyperlink en laat het als tekst staan
  - **First seen:** 2026-06-13

### Lege notes (content <200 bytes excl. frontmatter)

- [ ] `wiki/20-knowledge/index.md` — 94 bytes content na frontmatter (skelet zonder inhoud)
  - **Voorgestelde actie:** acceptabel als placeholder-index; voeg minimale uitleg toe of documenteer expliciet dat dit een lege index is in afwachting van echte notes
  - **First seen:** 2026-06-13

---

## Escalatie-status

- Findings ouder dan 7d die naar weekly escaleren: 4 (broken raw-links + missing titles in sessions, open sinds 2026-06-09)
- Findings ouder dan 30d die naar monthly escaleren: 0

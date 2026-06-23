---
title: Daily Wiki Audit 2026-06-23
audit-date: 2026-06-23
audit-mode: daily
findings-total: 12
findings-hard: 7
findings-soft: 5
date: 2026-06-23
tags: [audit, lint, daily]
---

# Wiki audit 2026-06-23 (daily)

## Samenvatting

- Files gescand: 52
- Hard findings: 7
- Soft findings: 5
- Geescaleerd vanuit vorige cadens: 0

---

## Hard findings

### Broken wikilinks

- [ ] `wiki/50-decisions/log.example.md:23` — wikilink `[[30-sessions/YYYY-MM-DD-slug]]` verwijst naar een niet-bestaand bestand
  - **Voorgestelde actie:** dit is een templateplaatshouder; vervang door commentaar of een echt voorbeeld-pad
  - **Prioriteit:** medium
  - **First seen:** 2026-06-23

### Ontbrekende frontmatter — verplichte velden

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — ontbreekt `title` in frontmatter (verplicht voor 30-sessions)
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — kan-je-me-de-vergelijking-benchmarks-gev"` toe aan de frontmatter
  - **Prioriteit:** medium
  - **First seen:** 2026-06-23

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — ontbreekt `title` in frontmatter (verplicht voor 30-sessions)
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — session"` toe aan de frontmatter
  - **Prioriteit:** medium
  - **First seen:** 2026-06-23

### Corrupte frontmatter

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md` — frontmatter bevat een losse `0` op regels 6 en 21 (waarschijnlijk schrijffout bij `tool-uses: 0`)
  - **Voorgestelde actie:** verwijder de losse `0`-regels; controleer of `tool-uses: 0` correct staat
  - **Prioriteit:** high
  - **First seen:** 2026-06-23

### Lege/dunne sessie-notes (geen inhoudelijke distillatie)

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md` — 649 bytes, alleen boilerplate (status: needs-distillation, 0 tool-uses)
  - **Voorgestelde actie:** distilleer via `/process-sessions` of verplaats naar `90-archives/` als de sessie geen waarde had
  - **Prioriteit:** low
  - **First seen:** 2026-06-23

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` — 777 bytes, alleen boilerplate (status: needs-distillation)
  - **Voorgestelde actie:** distilleer via `/process-sessions` of archiveer
  - **Prioriteit:** low
  - **First seen:** 2026-06-23

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — 711 bytes, alleen boilerplate (status: needs-distillation)
  - **Voorgestelde actie:** distilleer via `/process-sessions` of archiveer
  - **Prioriteit:** low
  - **First seen:** 2026-06-23

---

## Soft findings

### Orphan pages — geen backlinks

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` — geen enkel wiki-bestand linkt naar deze sessie
  - **Voorgestelde actie:** verwacht gedrag voor sessies (er is geen centrale sessie-index); geen actie vereist tenzij je een sessie-overzicht wil bijhouden
  - **Prioriteit:** low
  - **First seen:** 2026-06-23

- [ ] `wiki/30-sessions/processed/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md` — geen backlinks
  - **Voorgestelde actie:** zie boven
  - **Prioriteit:** low
  - **First seen:** 2026-06-23

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md` — geen backlinks
  - **Voorgestelde actie:** zie boven
  - **Prioriteit:** low
  - **First seen:** 2026-06-23

- [ ] `wiki/30-sessions/processed/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md` — geen backlinks
  - **Voorgestelde actie:** zie boven
  - **Prioriteit:** low
  - **First seen:** 2026-06-23

- [ ] `wiki/30-sessions/processed/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md` — geen backlinks
  - **Voorgestelde actie:** zie boven
  - **Prioriteit:** low
  - **First seen:** 2026-06-23

### Frontmatter-afwijking — 40-references/log.md

- [ ] `wiki/40-references/log.md` — staat in `40-references/` maar gebruikt `created`/`updated` in plaats van `ingest-date`/`review-date`, en heeft geen `source-url`
  - **Voorgestelde actie:** dit is een intern logbestand, geen externe reference; overweeg verplaatsen naar `wiki/60-audits/` of een aparte `wiki/log.md`, of accepteer de afwijking en documenteer de uitzondering
  - **Prioriteit:** low
  - **First seen:** 2026-06-23

---

## Niet gevonden (schoon)

- Geen broken relatieve markdown-links in `40-references/claude-code/` of `40-references/dutchquill/`
- Geen lege `tags: []` velden
- Alle wikilinks in `wiki/index.md` naar `00-context/*.example`, `10-projects/index`, `20-knowledge/index`, `40-references/index`, `50-decisions/log.example` zijn intact
- Alle 23 claude-code reference-bestanden hebben volledige verplichte frontmatter

---

## Escalatie-status

- Findings ouder dan 7d die naar weekly escaleren: 0
- Findings ouder dan 30d die naar monthly escaleren: 0

---

## Noot: raw/ links in sessie-files

Alle processed sessie-files linken naar `../raw/<session-slug>.md`. De `raw/`-directory bestaat maar is leeg (gitignored). Dit is verwacht gedrag — de raw transcripts zijn lokaal en niet gecommit. Geen actie vereist.

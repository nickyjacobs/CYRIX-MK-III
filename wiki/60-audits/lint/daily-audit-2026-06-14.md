---
title: "Daily Wiki Audit 2026-06-14"
audit-date: 2026-06-14
audit-mode: daily
findings-total: 9
findings-hard: 5
findings-soft: 4
---

# Daily Wiki Audit — 2026-06-14

## Samenvatting

Gescand: 49 bestanden in `wiki/**/*.md`. Vijf hard findings, vier soft findings. De broken links uit de audit van 2026-06-09 zijn deels opgelost (de drie missende index-pagina's bestaan nu), maar drie findings staan nog steeds open: twee sessie-bestanden missen een `title`-veld, en de raw-links in alle drie sessie-bestanden verwijzen naar een lege `raw/`-directory. Nieuw gedetecteerd: `wiki/40-references/log.md` gebruikt `created`/`updated` in plaats van de voor `40-references/` vereiste `ingest-date`/`review-date`-velden.

- Files gescand: 49
- Hard findings: 5
- Soft findings: 4
- Geescaleerd vanuit vorige cadens (>5 dagen open): 3

---

## Hard findings

### Broken markdown-links (raw-sessie-bestanden)

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md:34` — link naar `../raw/2026-06-10-0011-session.md` verwijst naar een bestand dat niet bestaat (`30-sessions/raw/` bevat alleen `.gitkeep`)
  - **Voorgestelde actie:** verwijder de link of herstel het raw-bestand; dit is een gitignored bestand, dus waarschijnlijk lokaal aanwezig maar niet gecommit — acceptabel om te laten staan als informatieve verwijzing
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` — link naar `../raw/2026-06-10-0025-kan-je-me-de-vergelijking-benchmarks-gev.md` verwijst naar een bestand dat niet bestaat
  - **Voorgestelde actie:** zie hierboven
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md:32` — link naar `../raw/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` verwijst naar een bestand dat niet bestaat
  - **Voorgestelde actie:** zie hierboven
  - **First seen:** 2026-06-14

### Ontbrekende frontmatter-velden

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — mist verplicht veld `title` (frontmatter heeft `date`, `type`, `status`, `tags`, `category` maar geen `title`)
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10"` toe aan de frontmatter
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — mist verplicht veld `title`
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — kan-je-me-de-vergelijking-benchmarks-gev"` toe aan de frontmatter
  - **First seen:** 2026-06-09

---

## Soft findings

### Frontmatter-conventie-afwijking

- [ ] `wiki/40-references/log.md` — zit in `40-references/` maar gebruikt `created`/`updated` in plaats van de voor die categorie vereiste `ingest-date`/`review-date` (conform wiki/index.md conventie en template)
  - **Voorgestelde actie:** dit is een log-bestand, geen ingestuurde referentie — overweeg een uitzondering te documenteren in `wiki/index.md`, of hernoem de velden naar `ingest-date: 2026-06-09` en `review-date: 2026-09-09`
  - **First seen:** 2026-06-14

- [ ] `wiki/index.md` — frontmatter heeft `updated: 2026-06-09` maar geen `tags`-veld; andere index-pagina's (`10-projects/index.md`, `20-knowledge/index.md`, `40-references/index.md`) hebben wel `tags`
  - **Voorgestelde actie:** voeg `tags: [index]` toe voor consistentie
  - **First seen:** 2026-06-14

### Orphan pages (sessies zonder backlink)

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — geen enkel wiki-bestand linkt naar deze pagina
  - **Voorgestelde actie:** acceptabel voor sessie-bestanden; `index.md` verwijst naar de map `30-sessions/` als geheel, niet naar individuele sessies
  - **First seen:** 2026-06-14

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — geen enkel wiki-bestand linkt naar deze pagina
  - **Voorgestelde actie:** zie hierboven
  - **First seen:** 2026-06-14

---

## Opgeloste findings t.o.v. 2026-06-09

De volgende hard findings uit de vorige daily-audit zijn opgelost (bestanden bestaan nu):

- `wiki/index.md` wikilinks naar `10-projects/index`, `20-knowledge/index`, `40-references/index` — alle drie bestaan
- `wiki/index.md:70` link naar `50-decisions/log` — aangepast naar `50-decisions/log.example` (correct)
- `wiki/40-references/claude-code/00-index.md` orphan — is nu bereikbaar via `40-references/index.md`

---

## Escalatie-status

- Findings ouder dan 5 dagen (open sinds 2026-06-09, escaleren bij >7d naar weekly): **3**
  - `wiki/30-sessions/processed/2026-06-10-session.md` — broken raw-link + missing title
  - `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — broken raw-link + missing title
- Findings ouder dan 30d die naar monthly escaleren: 0

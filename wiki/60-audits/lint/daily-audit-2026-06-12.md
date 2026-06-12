---
title: "Daily wiki audit 2026-06-12"
date: 2026-06-12
type: audit
scope: daily
audit-mode: daily
findings-total: 9
findings-hard: 6
findings-soft: 3
---

# Wiki audit 2026-06-12 (daily)

## Samenvatting

- Files gescand: 48 (incl. templates en 60-audits)
- Content-bestanden gecontroleerd: 42 (excl. 60-audits)
- Hard findings: 6
- Soft findings: 3
- Geescaleerd vanuit vorige cadens: 4 (open sinds 2026-06-09, >3 dagen maar nog binnen 7d-grens)

---

## Hard findings

### Broken standaard markdown-links (gitignored raw-bestanden)

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md:34` — link naar `../raw/2026-06-10-0011-session.md` verwijst naar een bestand dat niet bestaat (raw/ is gitignored, bestand lokaal afwezig)
  - **Voorgestelde actie:** verwijder de link of vervang door een noot zoals `_Raw transcript niet beschikbaar (gitignored)._`
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` — link naar `../raw/2026-06-10-0025-kan-je-me-de-vergelijking-benchmarks-gev.md` verwijst naar een bestand dat niet bestaat
  - **Voorgestelde actie:** zie hierboven
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md:32` — link naar `../raw/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` verwijst naar een bestand dat niet bestaat
  - **Voorgestelde actie:** zie hierboven
  - **First seen:** 2026-06-12

### Ontbrekende frontmatter-velden

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — mist verplicht veld `title` (30-sessions vereist: title, date, type, status, tags, category)
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — session"` toe aan de frontmatter
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — mist verplicht veld `title`
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — kan-je-me-de-vergelijking-benchmarks-gev"` toe aan de frontmatter
  - **First seen:** 2026-06-09

- [ ] `wiki/40-references/log.md` — bestand staat in `40-references/` maar gebruikt `created`/`updated` in plaats van de verplichte velden `ingest-date`, `review-date` en `source-url` voor references
  - **Voorgestelde actie:** ofwel (a) voeg `ingest-date`, `review-date`, `source-url` toe en verwijder `created`/`updated`, ofwel (b) verplaats dit bestand naar een andere categorie (bv. als wiki-intern logboek) of behandel het als index-pagina door het te hernoemen naar iets buiten de reference-conventie
  - **First seen:** 2026-06-12

---

## Soft findings

### Orphan pages

- [ ] `wiki/40-references/claude-code/00-index.md` — geen enkel ander wiki-bestand linkt direct naar deze pagina (`40-references/index.md` linkt naar `overview.md`, niet naar `00-index.md`; de vermelding in `log.md` is plain text, geen link)
  - **Voorgestelde actie:** voeg in `wiki/40-references/index.md` een link toe naar `[[40-references/claude-code/00-index|Claude Code — volledige index]]`, of laat `overview.md` verwijzen naar de index
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` — geen enkel wiki-bestand linkt naar deze sessie
  - **Voorgestelde actie:** acceptabel voor sessies die nog `needs-distillation` hebben; wordt automatisch geresolveerd zodra `/process-sessions` een gestructureerde knowledge-note aanmaakt die ernaar verwijst
  - **First seen:** 2026-06-12

### Sessies met status needs-distillation

- [ ] 3 sessie-bestanden in `wiki/30-sessions/processed/` hebben `status: needs-distillation` en zijn sindsdien (2026-06-10) niet verwerkt:
  - `2026-06-10-session.md`
  - `2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md`
  - `2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md`
  - **Voorgestelde actie:** draai `/process-sessions` om deze sessies te distilleren, of markeer handmatig als `status: archived` als ze geen distillatie-waarde hebben
  - **First seen:** 2026-06-12

---

## Opgeloste findings t.o.v. 2026-06-09

De volgende findings uit de vorige audit zijn inmiddels opgelost:

- `wiki/index.md:34` — `[[10-projects/index]]` werkt nu (`10-projects/index.md` aangemaakt)
- `wiki/index.md:43` — `[[20-knowledge/index]]` werkt nu (`20-knowledge/index.md` aangemaakt)
- `wiki/index.md:61` — `[[40-references/index]]` werkt nu (`40-references/index.md` aangemaakt)
- `wiki/index.md` — `title`-veld aanwezig
- Alle wikilinks in `index.md` zijn nu geldig

---

## Escalatie-status

- Findings ouder dan 7d die naar weekly escaleren: 0
- Findings ouder dan 30d die naar monthly escaleren: 0
- Findings die bij volgende weekly (na 2026-06-19) escaleren als onopgelost: 4 (open since 2026-06-09)
  - `30-sessions/processed/2026-06-10-session.md` raw link + ontbrekende title
  - `30-sessions/processed/2026-06-10-kan-je-me-...md` raw link + ontbrekende title

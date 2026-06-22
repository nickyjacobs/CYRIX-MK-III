---
title: Wiki librarian — finding tracker
updated: 2026-06-22
---

# Finding tracker

Persistente staat van open en opgeloste findings. Wordt bijgehouden door `wiki-librarian` bij elke audit-run.

## Open findings

### broken-link :: 2026-06-10-session — raw link missing
- **id:** BL-001
- **file:** `wiki/30-sessions/processed/2026-06-10-session.md:34`
- **detail:** link naar `../raw/2026-06-10-0011-session.md` — bestand bestaat niet (raw/ is gitignored)
- **first-seen:** 2026-06-09
- **escalates-to-weekly:** 2026-06-16 (reeds verstreken)

### broken-link :: 2026-06-10-kan-je-me — raw link missing
- **id:** BL-002
- **file:** `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31`
- **detail:** link naar `../raw/2026-06-10-0025-kan-je-me-de-vergelijking-benchmarks-gev.md` — bestand bestaat niet
- **first-seen:** 2026-06-09
- **escalates-to-weekly:** 2026-06-16 (reeds verstreken)

### broken-link :: 2026-06-10-1339 — raw link missing
- **id:** BL-003
- **file:** `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md:32`
- **detail:** link naar `../raw/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` — bestand bestaat niet
- **first-seen:** 2026-06-22

### broken-link :: 2026-06-10-1838 — raw link missing
- **id:** BL-004
- **file:** `wiki/30-sessions/processed/2026-06-10-1838-session.md:34`
- **detail:** link naar `../raw/2026-06-10-1838-session.md` — bestand bestaat niet
- **first-seen:** 2026-06-22

### broken-link :: 2026-06-10-1836 — raw link missing
- **id:** BL-005
- **file:** `wiki/30-sessions/processed/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md:33`
- **detail:** link naar `../raw/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md` — bestand bestaat niet
- **first-seen:** 2026-06-22

### broken-link :: 2026-06-12 — raw link missing
- **id:** BL-006
- **file:** `wiki/30-sessions/processed/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md:32`
- **detail:** link naar `../raw/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md` — bestand bestaat niet
- **first-seen:** 2026-06-22

### broken-link :: 2026-06-15 — raw link missing
- **id:** BL-007
- **file:** `wiki/30-sessions/processed/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md:37`
- **detail:** link naar `../raw/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md` — bestand bestaat niet
- **first-seen:** 2026-06-22

### missing-frontmatter :: 2026-06-10-session — no title
- **id:** FM-001
- **file:** `wiki/30-sessions/processed/2026-06-10-session.md`
- **detail:** frontmatter mist verplicht veld `title`
- **first-seen:** 2026-06-09
- **escalates-to-weekly:** 2026-06-16 (reeds verstreken)

### missing-frontmatter :: 2026-06-10-kan-je-me — no title
- **id:** FM-002
- **file:** `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md`
- **detail:** frontmatter mist verplicht veld `title`
- **first-seen:** 2026-06-09
- **escalates-to-weekly:** 2026-06-16 (reeds verstreken)

### malformed-frontmatter :: 2026-06-10-1838 — stray "0" line
- **id:** FM-003
- **file:** `wiki/30-sessions/processed/2026-06-10-1838-session.md`
- **detail:** frontmatter bevat een losse `0` op regel 6, direct na `tool-uses: 0` — ongeldige YAML
- **first-seen:** 2026-06-22

### missing-frontmatter :: 40-references/log.md — uses created/updated instead of ingest-date/review-date
- **id:** FM-004
- **file:** `wiki/40-references/log.md`
- **detail:** bestand staat in `40-references/` maar gebruikt `created`/`updated` in plaats van `ingest-date`/`review-date`. Mogelijk bewust als log-bestand; vraagt om expliciete keuze
- **first-seen:** 2026-06-22

### orphan :: 2026-06-10-1339
- **id:** OR-001
- **file:** `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md`
- **detail:** geen enkel ander wiki-bestand linkt naar deze pagina
- **first-seen:** 2026-06-22

### orphan :: 2026-06-10-1838
- **id:** OR-002
- **file:** `wiki/30-sessions/processed/2026-06-10-1838-session.md`
- **detail:** geen enkel ander wiki-bestand linkt naar deze pagina
- **first-seen:** 2026-06-22

### orphan :: 2026-06-10-1836
- **id:** OR-003
- **file:** `wiki/30-sessions/processed/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md`
- **detail:** geen enkel ander wiki-bestand linkt naar deze pagina
- **first-seen:** 2026-06-22

### orphan :: 2026-06-12
- **id:** OR-004
- **file:** `wiki/30-sessions/processed/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md`
- **detail:** geen enkel ander wiki-bestand linkt naar deze pagina
- **first-seen:** 2026-06-22

### orphan :: 2026-06-15
- **id:** OR-005
- **file:** `wiki/30-sessions/processed/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md`
- **detail:** geen enkel ander wiki-bestand linkt naar deze pagina
- **first-seen:** 2026-06-22

### empty-note :: goals.example.md
- **id:** EN-001
- **file:** `wiki/00-context/goals.example.md`
- **detail:** content (excl. frontmatter) is 230 bytes — onder de 200-byte drempel na aftrek van lege structuurregels
- **first-seen:** 2026-06-22

---

## Geescaleerde findings (>7d, naar weekly)

De volgende findings zijn ouder dan 7 dagen en verschijnen in de eerstvolgende weekly-audit als hard finding:

- BL-001 (first-seen 2026-06-09) — broken raw link in `2026-06-10-session.md`
- BL-002 (first-seen 2026-06-09) — broken raw link in `2026-06-10-kan-je-me-...`
- FM-001 (first-seen 2026-06-09) — missing title in `2026-06-10-session.md`
- FM-002 (first-seen 2026-06-09) — missing title in `2026-06-10-kan-je-me-...`

---

## Resolved findings

_Geen opgeloste findings tot nu toe._

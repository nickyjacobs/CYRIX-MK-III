---
title: Wiki audit — findings tracking
updated: 2026-06-24
category: 60-audits
status: active
---

# Findings tracking

Committable state tussen audit-runs. Bij oplossing: verplaats naar "resolved" sectie.

## Open findings

| id | first-seen | categorie | bestand | beschrijving |
|----|------------|-----------|---------|-------------|
| F-001 | 2026-06-09 | broken-wikilink | wiki/index.md:70 | `[[50-decisions/log]]` — target `50-decisions/log.md` bestaat niet |
| F-002 | 2026-06-09 | broken-link | wiki/30-sessions/processed/2026-06-10-session.md:34 | link naar `raw/2026-06-10-0011-session.md` (raw/ is leeg) |
| F-003 | 2026-06-09 | broken-link | wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31 | link naar `raw/2026-06-10-0025-...md` (raw/ is leeg) |
| F-004 | 2026-06-09 | missing-frontmatter | wiki/30-sessions/processed/2026-06-10-session.md | mist veld `title` |
| F-005 | 2026-06-09 | missing-frontmatter | wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md | mist veld `title` |
| F-006 | 2026-06-24 | broken-link | wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md:32 | link naar raw/ (gitignored, bestand niet aanwezig) |
| F-007 | 2026-06-24 | broken-link | wiki/30-sessions/processed/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md:33 | link naar raw/ (gitignored, bestand niet aanwezig) |
| F-008 | 2026-06-24 | broken-link | wiki/30-sessions/processed/2026-06-10-1838-session.md:34 | link naar raw/ (gitignored, bestand niet aanwezig) |
| F-009 | 2026-06-24 | broken-link | wiki/30-sessions/processed/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md:32 | link naar raw/ (gitignored, bestand niet aanwezig) |
| F-010 | 2026-06-24 | broken-link | wiki/30-sessions/processed/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md:37 | link naar raw/ (gitignored, bestand niet aanwezig) |
| F-011 | 2026-06-24 | corrupted-frontmatter | wiki/30-sessions/processed/2026-06-10-1838-session.md:6 | stray "0" op regel 6 in YAML-block (ook regel 21 in body) |
| F-012 | 2026-06-24 | missing-frontmatter | wiki/40-references/log.md | categorie 40-references maar gebruikt `created`/`updated` i.p.v. `ingest-date`/`review-date` + geen `source-url` |
| F-013 | 2026-06-24 | stale-sessions | wiki/30-sessions/processed/ | 5 sessies van 2026-06-10 hebben status `needs-distillation` (>7 dagen) |
| F-014 | 2026-06-24 | orphan | wiki/40-references/dutchquill/schrijfstijl.md | geen backlink buiten dutchquill/ map (alleen via 00-index intern) |
| F-015 | 2026-06-24 | orphan | wiki/40-references/dutchquill/taal_gids.md | geen backlink buiten dutchquill/ map |
| F-016 | 2026-06-24 | orphan | wiki/40-references/dutchquill/humanize_nl_gids.md | geen backlink buiten dutchquill/ map |
| F-017 | 2026-06-24 | orphan | wiki/60-audits/lint/docs-drift-claudecode-2026-06-10.md | geen backlink vanuit enig ander wiki-bestand |

## Resolved findings

| id | resolved-date | beschrijving |
|----|---------------|-------------|
| F-R01 | 2026-06-10 | `wiki/index.md:34` — `[[10-projects/index]]` was broken; `10-projects/index.md` is aangemaakt |
| F-R02 | 2026-06-10 | `wiki/index.md:43` — `[[20-knowledge/index]]` was broken; `20-knowledge/index.md` is aangemaakt |
| F-R03 | 2026-06-10 | `wiki/index.md:61` — `[[40-references/index]]` was broken; `40-references/index.md` is aangemaakt |
| F-R04 | 2026-06-24 | `wiki/index.md` — geen `created` veld; per spec zijn index.md-pagina's vrijgesteld van datum-velden |

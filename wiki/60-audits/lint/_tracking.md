# Wiki audit tracking

Escalatie-state tussen audit-runs. Wordt door `wiki-librarian` bijgehouden.

---

## Open findings

| ID | Categorie | Bestand | Omschrijving | First seen | Escalaties |
|----|-----------|---------|--------------|------------|------------|
| T-001 | broken-wikilink | `wiki/index.md:70` | `[[50-decisions/log]]` — target bestaat niet | 2026-06-09 | weekly (>7d) |
| T-002 | broken-mdlink | `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` | link naar niet-bestaand raw-bestand | 2026-06-09 | weekly (>7d) |
| T-003 | broken-mdlink | `wiki/30-sessions/processed/2026-06-10-session.md:34` | link naar niet-bestaand raw-bestand | 2026-06-09 | weekly (>7d) |
| T-004 | missing-frontmatter | `wiki/30-sessions/processed/2026-06-10-session.md` | mist veld `title` | 2026-06-09 | weekly (>7d) |
| T-005 | missing-frontmatter | `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` | mist veld `title` | 2026-06-09 | weekly (>7d) |
| T-006 | orphan | `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` | geen backlinks | 2026-06-18 | — |
| T-007 | orphan | `wiki/30-sessions/processed/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md` | geen backlinks | 2026-06-18 | — |
| T-008 | orphan | `wiki/30-sessions/processed/2026-06-10-1838-session.md` | geen backlinks | 2026-06-18 | — |
| T-009 | orphan | `wiki/30-sessions/processed/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md` | geen backlinks | 2026-06-18 | — |
| T-010 | orphan | `wiki/30-sessions/processed/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md` | geen backlinks | 2026-06-18 | — |
| T-011 | broken-mdlink | `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md:32` | link naar niet-bestaand raw-bestand | 2026-06-18 | — |
| T-012 | broken-mdlink | `wiki/30-sessions/processed/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md:33` | link naar niet-bestaand raw-bestand | 2026-06-18 | — |
| T-013 | broken-mdlink | `wiki/30-sessions/processed/2026-06-10-1838-session.md:34` | link naar niet-bestaand raw-bestand | 2026-06-18 | — |
| T-014 | broken-mdlink | `wiki/30-sessions/processed/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md:32` | link naar niet-bestaand raw-bestand | 2026-06-18 | — |
| T-015 | broken-mdlink | `wiki/30-sessions/processed/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md:37` | link naar niet-bestaand raw-bestand | 2026-06-18 | — |
| T-016 | corrupt-frontmatter | `wiki/30-sessions/processed/2026-06-10-1838-session.md:6` | losse `0` op eigen regel maakt YAML ongeldig | 2026-06-18 | — |
| T-017 | soft-placeholder | `wiki/50-decisions/log.example.md:23` | wikilink `[[30-sessions/YYYY-MM-DD-slug]]` is templateplaatshouder | 2026-06-09 | weekly (>7d) |
| T-018 | soft-orphan | `wiki/50-decisions/log.example.md` | geen backlink vanuit index | 2026-06-09 | weekly (>7d) |
| T-019 | soft-orphan | `wiki/40-references/claude-code/00-index.md` | geen directe backlink | 2026-06-09 | weekly (>7d) |
| T-020 | soft-frontmatter | `wiki/40-references/log.md` | heeft created/updated i.p.v. ingest-date/review-date; mist source-url | 2026-06-18 | — |

---

## Resolved findings

_(leeg — geen findings opgelost tot nu toe)_

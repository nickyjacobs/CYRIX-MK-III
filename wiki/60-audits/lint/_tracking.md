# Wiki audit tracking

Committable state-file voor het bijhouden van open en opgeloste findings tussen audit-runs.

---

## Open findings

| ID | Categorie | Bestand | Omschrijving | First seen | Escalatie |
|----|-----------|---------|--------------|------------|-----------|
| T-001 | broken-link | `wiki/30-sessions/processed/2026-06-10-session.md:34` | Link naar gitignored raw-bestand `../raw/2026-06-10-0011-session.md` | 2026-06-09 | weekly (>7d) |
| T-002 | broken-link | `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` | Link naar gitignored raw-bestand | 2026-06-09 | weekly (>7d) |
| T-003 | missing-frontmatter | `wiki/30-sessions/processed/2026-06-10-session.md` | Mist verplicht veld `title` | 2026-06-09 | weekly (>7d) |
| T-004 | missing-frontmatter | `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` | Mist verplicht veld `title` | 2026-06-09 | weekly (>7d) |
| T-005 | broken-link | `wiki/20-knowledge/index.md:16` | Broken wikilink `[[wikilinks]]` (placeholder in instructietekst) | 2026-06-13 | - |
| T-006 | frontmatter-convention | `wiki/40-references/log.md` | Gebruikt `created`/`updated` i.p.v. `ingest-date`/`review-date` voor 40-references | 2026-06-13 | - |
| T-007 | orphan | `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-siden-de-nieuwe-.md` | Geen backlinks | 2026-06-13 | - |
| T-008 | broken-link | `wiki/index.md:113` | Directory-link `./_templates/` werkt niet als markdown-link | 2026-06-13 | - |
| T-009 | empty-note | `wiki/20-knowledge/index.md` | 94 bytes content na frontmatter | 2026-06-13 | - |

---

## Resolved findings

| ID | Categorie | Bestand | Omschrijving | First seen | Resolved |
|----|-----------|---------|--------------|------------|---------|
| R-001 | broken-link | `wiki/index.md:34` | Wikilink `[[10-projects/index]]` — bestand aangemaakt | 2026-06-09 | 2026-06-13 |
| R-002 | broken-link | `wiki/index.md:43` | Wikilink `[[20-knowledge/index]]` — bestand aangemaakt | 2026-06-09 | 2026-06-13 |
| R-003 | broken-link | `wiki/index.md:61` | Wikilink `[[40-references/index]]` — bestand aangemaakt | 2026-06-09 | 2026-06-13 |
| R-004 | broken-link | `wiki/index.md:70` | Wikilink `[[50-decisions/log.example]]` — resolvet correct | 2026-06-09 | 2026-06-13 |

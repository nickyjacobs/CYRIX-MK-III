# Audit tracking

Persistente staat tussen audit-runs. Elke open finding staat hier met first-seen datum.
Bij oplossing: verplaats naar "Resolved" sectie.

---

## Open findings

| ID | Bestand | Bevinding | First seen | Status |
|----|---------|-----------|------------|--------|
| T001 | `wiki/50-decisions/log.example.md:23` | Broken wikilink: templateplaatshouder `[[30-sessions/YYYY-MM-DD-slug]]` | 2026-06-23 | open |
| T002 | `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` | Ontbreekt `title` in frontmatter | 2026-06-23 | open |
| T003 | `wiki/30-sessions/processed/2026-06-10-session.md` | Ontbreekt `title` in frontmatter | 2026-06-23 | open |
| T004 | `wiki/30-sessions/processed/2026-06-10-1838-session.md` | Corrupte frontmatter (losse `0` op regels 6 en 21) | 2026-06-23 | open |
| T005 | `wiki/30-sessions/processed/2026-06-10-1838-session.md` | Lege note: alleen boilerplate, 649 bytes | 2026-06-23 | open |
| T006 | `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` | Lege note: alleen boilerplate, 777 bytes | 2026-06-23 | open |
| T007 | `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` | Lege note: alleen boilerplate, 711 bytes | 2026-06-23 | open |
| T008 | `wiki/30-sessions/processed/*.md` (5 bestanden) | Orphan pages: geen backlinks (verwacht voor sessies) | 2026-06-23 | soft/open |
| T009 | `wiki/40-references/log.md` | Frontmatter-afwijking: intern logbestand in 40-references/ zonder source-url/ingest-date | 2026-06-23 | soft/open |

---

## Resolved findings

_(leeg — eerste audit-run)_

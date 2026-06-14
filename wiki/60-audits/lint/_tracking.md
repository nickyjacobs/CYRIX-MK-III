# Wiki audit — finding tracking

Committable state-file. Bijgehouden door `wiki-librarian` routine. Bij oplossing: verplaats entry naar "Resolved" sectie.

---

## Open findings

| ID | Categorie | Bestand | Beschrijving | First seen | Escalatie |
|----|-----------|---------|-------------|------------|-----------|
| F01 | broken-link | `wiki/30-sessions/processed/2026-06-10-session.md:34` | Link naar niet-bestaand raw-bestand | 2026-06-09 | weekly (>7d) |
| F02 | broken-link | `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` | Link naar niet-bestaand raw-bestand | 2026-06-09 | weekly (>7d) |
| F03 | broken-link | `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md:32` | Link naar niet-bestaand raw-bestand | 2026-06-14 | — |
| F04 | missing-frontmatter | `wiki/30-sessions/processed/2026-06-10-session.md` | Mist verplicht veld `title` | 2026-06-09 | weekly (>7d) |
| F05 | missing-frontmatter | `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` | Mist verplicht veld `title` | 2026-06-09 | weekly (>7d) |
| F06 | wrong-frontmatter | `wiki/40-references/log.md` | Gebruikt `created`/`updated` ipv `ingest-date`/`review-date` | 2026-06-14 | — |
| F07 | missing-frontmatter | `wiki/index.md` | Mist `tags`-veld | 2026-06-14 | — |
| F08 | broken-link | `wiki/40-references/claude-code/00-index.md:24` | Source-url voor cli-reference verouderd (`/cli-usage` ipv `/cli-reference`) | 2026-06-10 | — |
| F09 | orphan | `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` | Geen backlinks | 2026-06-14 | — |
| F10 | orphan | `wiki/60-audits/lint/daily-audit-2026-06-09.md` | Geen backlinks | 2026-06-14 | — |
| F11 | orphan | `wiki/60-audits/lint/docs-drift-claudecode-2026-06-10.md` | Geen backlinks | 2026-06-14 | — |
| F12 | naming | `wiki/40-references/dutchquill/taal_gids.md` | Underscore in bestandsnaam i.p.v. kebab-case | 2026-06-14 | — |
| F13 | naming | `wiki/40-references/dutchquill/humanize_nl_gids.md` | Underscore in bestandsnaam i.p.v. kebab-case | 2026-06-14 | — |
| F14 | naming | `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` | Inconsistent tijdstip-prefix in sessienaam | 2026-06-14 | — |
| F15 | needs-distillation | `wiki/30-sessions/processed/2026-06-10-session.md` | Status `needs-distillation` | 2026-06-14 | — |
| F16 | needs-distillation | `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` | Status `needs-distillation` | 2026-06-14 | — |
| F17 | needs-distillation | `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` | Status `needs-distillation` | 2026-06-14 | — |
| F18 | missing-index | `wiki/60-audits/` | Geen index.md voor audits-overzicht | 2026-06-14 | — |

---

## Resolved findings

| ID | Beschrijving | Opgelost op | Hoe |
|----|-------------|-------------|-----|
| R01 | `wiki/index.md:34` — broken wikilink `[[10-projects/index]]` | 2026-06-14 | `wiki/10-projects/index.md` aangemaakt |
| R02 | `wiki/index.md:43` — broken wikilink `[[20-knowledge/index]]` | 2026-06-14 | `wiki/20-knowledge/index.md` aangemaakt |
| R03 | `wiki/index.md:61` — broken wikilink `[[40-references/index]]` | 2026-06-14 | `wiki/40-references/index.md` aangemaakt |
| R04 | `wiki/40-references/claude-code/00-index.md` orphan | 2026-06-14 | `wiki/40-references/index.md` linkt er nu naar |

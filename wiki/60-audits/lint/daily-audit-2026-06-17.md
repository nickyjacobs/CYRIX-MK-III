---
audit-date: 2026-06-17
audit-mode: daily
findings-total: 13
findings-hard: 10
findings-soft: 3
---

# Wiki audit 2026-06-17 (daily)

## Samenvatting

- Files gescand: 50
- Hard findings: 10
- Soft findings: 3
- Geescaleerd vanuit vorige cadens: 2

---

## Hard findings

### Broken markdown links (raw session files)

Alle session-files in `30-sessions/processed/` linken naar raw transcript-bestanden in `../raw/` die gitignored zijn en niet bestaan in de repo.

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md:34` — link naar `../raw/2026-06-10-0011-session.md` bestaat niet
  - **Voorgestelde actie:** verwijder de link of herstel het raw-bestand in `wiki/30-sessions/raw/` (gitignored)
  - **First seen:** 2026-06-09 (T-001, geescaleerd)

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` — link naar `../raw/2026-06-10-0025-kan-je-me-de-vergelijking-benchmarks-gev.md` bestaat niet
  - **Voorgestelde actie:** verwijder de link of herstel het raw-bestand
  - **First seen:** 2026-06-09 (T-002, geescaleerd)

- [ ] `wiki/30-sessions/processed/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md:33` — link naar `../raw/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md` bestaat niet
  - **Voorgestelde actie:** verwijder de link of herstel het raw-bestand
  - **First seen:** 2026-06-17 (T-005)

- [ ] `wiki/30-sessions/processed/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md:32` — link naar `../raw/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md` bestaat niet
  - **Voorgestelde actie:** verwijder de link of herstel het raw-bestand
  - **First seen:** 2026-06-17 (T-006)

- [ ] `wiki/30-sessions/processed/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md:37` — link naar `../raw/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md` bestaat niet
  - **Voorgestelde actie:** verwijder de link of herstel het raw-bestand
  - **First seen:** 2026-06-17 (T-007)

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md:34` — link naar `../raw/2026-06-10-1838-session.md` bestaat niet
  - **Voorgestelde actie:** verwijder de link of herstel het raw-bestand
  - **First seen:** 2026-06-17 (T-008)

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md:32` — link naar `../raw/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` bestaat niet
  - **Voorgestelde actie:** verwijder de link of herstel het raw-bestand
  - **First seen:** 2026-06-17 (T-009)

### Ontbrekende frontmatter-velden

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — mist verplicht veld `title` (30-sessions vereist: title, date, type, status, tags, category)
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10: session"` toe aan de frontmatter
  - **First seen:** 2026-06-09 (T-003, geescaleerd)

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — mist verplicht veld `title`
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10: kan-je-me-de-vergelijking-benchmarks-gev"` toe
  - **First seen:** 2026-06-09 (T-004, geescaleerd)

- [ ] `wiki/40-references/log.md` — gebruikt `created`/`updated` stijl maar is opgeslagen in `40-references/` (die `ingest-date`/`review-date`/`source-url` vereisen als reference-page, of moet als log/index behandeld worden)
  - **Voorgestelde actie:** behandel als interne log (geen externe bron), voeg `tags`-veld toe als dat ontbreekt, of verplaats naar `50-decisions/` als append-only log
  - **First seen:** 2026-06-17 (T-010)

---

## Soft findings

### Orphan pages (audit-bestanden)

Auditbestanden worden doorgaans niet gelinkt vanuit content-pagina's — dit is verwacht gedrag voor `60-audits/lint/`. Toch gemeld voor volledigheid.

- [ ] `wiki/60-audits/lint/docs-drift-claudecode-2026-06-10.md` — geen backlink vanuit andere wiki-pagina's
  - **Voorgestelde actie:** acceptabel voor audit-bestanden; overweeg een index in `60-audits/` indien gewenst
  - **First seen:** 2026-06-17 (T-011)

- [ ] `wiki/60-audits/lint/daily-audit-2026-06-09.md` — geen backlink vanuit andere wiki-pagina's
  - **Voorgestelde actie:** zie hierboven
  - **First seen:** 2026-06-17 (T-012)

### Template-placeholder (soft)

- [ ] `wiki/50-decisions/log.example.md:23` — wikilink `[[30-sessions/YYYY-MM-DD-slug]]` is een templateplaatshouder, geen echte link
  - **Voorgestelde actie:** acceptabel als voorbeeld; overweeg een code-block om te markeren als placeholder
  - **First seen:** 2026-06-09 (T-013)

---

## Escalatie-status

- Findings ouder dan 7d die naar weekly escaleren: 4 (T-001, T-002, T-003, T-004 — first seen 2026-06-09)
- Findings ouder dan 30d die naar monthly escaleren: 0

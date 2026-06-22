---
audit-date: 2026-06-22
audit-mode: daily
findings-total: 17
findings-hard: 14
findings-soft: 3
---

# Wiki audit 2026-06-22 (daily)

## Samenvatting

- Files gescand: 50
- Hard findings: 14
- Soft findings: 3
- Geescaleerd vanuit vorige cadens: 4 (BL-001, BL-002, FM-001, FM-002 — ouder dan 7d, verschijnen in weekly)

---

## Hard findings

### Broken markdown-links — raw session files ontbreken

Alle sessie-bestanden in `30-sessions/processed/` verwijzen naar een raw transcript in `30-sessions/raw/`. Die map bestaat maar is leeg (raw-bestanden zijn gitignored). Zeven broken links totaal, waarvan twee al sinds 2026-06-09 open staan.

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md:34` — link naar `../raw/2026-06-10-0011-session.md` bestaat niet
  - **Voorgestelde actie:** verwijder de raw-link uit de footer, of accepteer structureel dat raw-bestanden lokaal gitignored zijn en documenteer dit eenmalig in een README in `30-sessions/`
  - **First seen:** 2026-06-09 (BL-001 — geescaleerd naar weekly)

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` — link naar `../raw/2026-06-10-0025-kan-je-me-de-vergelijking-benchmarks-gev.md` bestaat niet
  - **Voorgestelde actie:** zie BL-001
  - **First seen:** 2026-06-09 (BL-002 — geescaleerd naar weekly)

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md:32` — link naar `../raw/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` bestaat niet
  - **Voorgestelde actie:** zie BL-001
  - **First seen:** 2026-06-22 (BL-003)

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md:34` — link naar `../raw/2026-06-10-1838-session.md` bestaat niet
  - **Voorgestelde actie:** zie BL-001
  - **First seen:** 2026-06-22 (BL-004)

- [ ] `wiki/30-sessions/processed/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md:33` — link naar `../raw/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md` bestaat niet
  - **Voorgestelde actie:** zie BL-001
  - **First seen:** 2026-06-22 (BL-005)

- [ ] `wiki/30-sessions/processed/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md:32` — link naar `../raw/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md` bestaat niet
  - **Voorgestelde actie:** zie BL-001
  - **First seen:** 2026-06-22 (BL-006)

- [ ] `wiki/30-sessions/processed/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md:37` — link naar `../raw/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md` bestaat niet
  - **Voorgestelde actie:** zie BL-001
  - **First seen:** 2026-06-22 (BL-007)

### Ontbrekende of foutieve frontmatter

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — mist verplicht veld `title`
  - **Voorgestelde actie:** voeg toe `title: "Sessie 2026-06-10: session"` aan de frontmatter
  - **First seen:** 2026-06-09 (FM-001 — geescaleerd naar weekly)

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — mist verplicht veld `title`
  - **Voorgestelde actie:** voeg toe `title: "Sessie 2026-06-10: kan-je-me-de-vergelijking-benchmarks-gev"` aan de frontmatter
  - **First seen:** 2026-06-09 (FM-002 — geescaleerd naar weekly)

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md` — ongeldige YAML in frontmatter: losse `0` op regel 6 na `tool-uses: 0`
  - **Voorgestelde actie:** verwijder de losse `0` op regel 6 uit de frontmatter-block. Dezelfde `0` staat ook op regel 22 in de body — beide verwijderen
  - **First seen:** 2026-06-22 (FM-003)

- [ ] `wiki/40-references/log.md` — staat in `40-references/` maar gebruikt `created`/`updated` in plaats van `ingest-date`/`review-date`
  - **Voorgestelde actie:** beslissing vereist: als dit een log-file is (geen reference), verplaats dan naar `50-decisions/` of maak een aparte subcategorie. Als het een reference blijft, vervang `created`/`updated` door `ingest-date`/`review-date` conform de 40-references-conventie
  - **First seen:** 2026-06-22 (FM-004)

### Orphan pages

Vijf sessie-bestanden in `30-sessions/processed/` worden nergens vanuit de wiki gelinkt. Sessies zijn van nature geen cross-linked content, maar ze worden ook niet opgenomen in een sessielijst of index.

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` — geen backlinks
  - **Voorgestelde actie:** acceptabel voor sessie-bestanden als er een `30-sessions/index.md` of README bestaat met een overzicht; anders: maak zo'n index aan
  - **First seen:** 2026-06-22 (OR-001)

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md` — geen backlinks
  - **Voorgestelde actie:** zie OR-001
  - **First seen:** 2026-06-22 (OR-002)

- [ ] `wiki/30-sessions/processed/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md` — geen backlinks
  - **Voorgestelde actie:** zie OR-001
  - **First seen:** 2026-06-22 (OR-003)

- [ ] `wiki/30-sessions/processed/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md` — geen backlinks
  - **Voorgestelde actie:** zie OR-001
  - **First seen:** 2026-06-22 (OR-004)

- [ ] `wiki/30-sessions/processed/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md` — geen backlinks
  - **Voorgestelde actie:** zie OR-001
  - **First seen:** 2026-06-22 (OR-005)

---

## Soft findings

### Lege note (onder 200 bytes content)

- [ ] `wiki/00-context/goals.example.md` — content (excl. frontmatter) is ~230 bytes; bevat alleen lege placeholders zonder ingevulde tekst
  - **Voorgestelde actie:** dit is een template-bestand, dus acceptabel. Geen actie nodig tenzij je de echte `goals.md` nog niet hebt aangemaakt
  - **First seen:** 2026-06-22 (EN-001)

### Frontmatter-conventie-afwijking (informatief)

- [ ] `wiki/index.md` — heeft `updated: 2026-06-09` maar geen `created`-veld. Conform de index.md-categorie zijn datum-velden niet verplicht, maar de aanwezige `updated` zonder `created` is inconsistent
  - **Voorgestelde actie:** voeg `created: 2026-06-09` toe, of verwijder `updated` als datum-tracking niet gewenst is voor de hoofdindex
  - **First seen:** 2026-06-22

### Sessie-bestanden met status needs-distillation (informatief)

- [ ] 7 sessie-bestanden in `wiki/30-sessions/processed/` hebben `status: needs-distillation` — zij zijn nog niet verwerkt via `/process-sessions`
  - **Voorgestelde actie:** run `/process-sessions` om distillatie naar `20-knowledge/` en `MEMORY.md` te voltooien
  - **First seen:** 2026-06-22

---

## Escalatie-status

- Findings ouder dan 7d die naar weekly escaleren: 4 (BL-001, BL-002, FM-001, FM-002)
- Findings ouder dan 30d die naar monthly escaleren: 0

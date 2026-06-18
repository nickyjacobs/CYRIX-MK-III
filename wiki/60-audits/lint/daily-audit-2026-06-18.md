---
audit-date: 2026-06-18
audit-mode: daily
findings-total: 22
findings-hard: 16
findings-soft: 6
---

# Wiki audit 2026-06-18 (daily)

## Samenvatting

- Files gescand: 46 (excl. 60-audits en _templates)
- Hard findings: 16
- Soft findings: 6
- Geescaleerd vanuit vorige cadens: 10 (van daily-audit-2026-06-09, >7 dagen oud)

---

## Hard findings

### Broken wikilinks (geescaleerd — first seen 2026-06-09, >7 dagen open)

- [ ] `wiki/index.md:34` — wikilink `[[10-projects/index]]` — bestand bestaat wel (`wiki/10-projects/index.md`), maar de vorige audit rapporteerde dat de map ontbrak. **Opgelost in tussentijd.** Verifieer dat de link werkt in je Obsidian/viewer.
  - **Voorgestelde actie:** markeer als opgelost in `_tracking.md`
  - **First seen:** 2026-06-09

- [ ] `wiki/index.md:43` — wikilink `[[20-knowledge/index]]` — bestand bestaat (`wiki/20-knowledge/index.md`). Zie opmerking hierboven.
  - **Voorgestelde actie:** markeer als opgelost in `_tracking.md`
  - **First seen:** 2026-06-09

- [ ] `wiki/index.md:61` — wikilink `[[40-references/index]]` — bestand bestaat (`wiki/40-references/index.md`). Zie opmerking hierboven.
  - **Voorgestelde actie:** markeer als opgelost in `_tracking.md`
  - **First seen:** 2026-06-09

- [ ] `wiki/index.md:70` — wikilink `[[50-decisions/log]]` verwijst naar `wiki/50-decisions/log.md` — dit bestand bestaat niet (alleen `log.example.md`). Nog steeds open.
  - **Voorgestelde actie:** kopieer `log.example.md` naar `log.md` (gitignored), of pas de link aan naar `[[50-decisions/log.example|Decisions log]]`
  - **First seen:** 2026-06-09

### Broken markdown-links naar raw-sessiebestanden

Alle processed-sessies linken naar gitignored `raw/`-bestanden die lokaal niet aanwezig zijn. De `raw/`-directory bestaat maar is leeg.

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md:32` — link naar `../raw/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` — bestand niet aanwezig
  - **Voorgestelde actie:** verwijder de raw-link of zet het raw-bestand terug als het bewaard moet blijven
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md:33` — link naar `../raw/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md` — bestand niet aanwezig
  - **Voorgestelde actie:** zie boven
  - **First seen:** 2026-06-18

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md:34` — link naar `../raw/2026-06-10-1838-session.md` — bestand niet aanwezig
  - **Voorgestelde actie:** zie boven
  - **First seen:** 2026-06-18

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` — link naar `../raw/2026-06-10-0025-kan-je-me-de-vergelijking-benchmarks-gev.md` — bestand niet aanwezig
  - **Voorgestelde actie:** verwijder de raw-link (first seen 2026-06-09 voor dit bestand)
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md:34` — link naar `../raw/2026-06-10-0011-session.md` — bestand niet aanwezig
  - **Voorgestelde actie:** verwijder de raw-link
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md:32` — link naar `../raw/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md` — bestand niet aanwezig
  - **Voorgestelde actie:** zie boven
  - **First seen:** 2026-06-18

- [ ] `wiki/30-sessions/processed/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md:37` — link naar `../raw/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md` — bestand niet aanwezig
  - **Voorgestelde actie:** zie boven
  - **First seen:** 2026-06-18

### Ontbrekende frontmatter-velden

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — mist verplicht veld `title` (geescaleerd, first seen 2026-06-09)
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10: session"` toe aan de frontmatter
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — mist verplicht veld `title` (geescaleerd, first seen 2026-06-09)
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10: kan-je-me-de-vergelijking-benchmarks-gev"` toe aan de frontmatter
  - **First seen:** 2026-06-09

### Corrupte frontmatter

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md:6` — losse `0` op eigen regel tussen `tool-uses: 0` en `content-changes: 0`, waardoor het YAML-blok ongeldig is
  - **Voorgestelde actie:** verwijder de losse `0` op regel 6
  - **First seen:** 2026-06-18

### Orphan pages (geescaleerd)

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` — geen enkel wiki-bestand linkt naar deze pagina
  - **Voorgestelde actie:** acceptabel voor sessie-logs; overweeg een sessie-index of maak `/einde-sessie` consistent
  - **First seen:** 2026-06-18

- [ ] `wiki/30-sessions/processed/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md` — geen backlinks
  - **Voorgestelde actie:** zie boven
  - **First seen:** 2026-06-18

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md` — geen backlinks
  - **Voorgestelde actie:** zie boven
  - **First seen:** 2026-06-18

- [ ] `wiki/30-sessions/processed/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md` — geen backlinks
  - **Voorgestelde actie:** zie boven
  - **First seen:** 2026-06-18

- [ ] `wiki/30-sessions/processed/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md` — geen backlinks
  - **Voorgestelde actie:** zie boven
  - **First seen:** 2026-06-18

---

## Soft findings

### Frontmatter-afwijking in 40-references (nav/utility files)

- [ ] `wiki/40-references/log.md` — heeft `created`/`updated` in plaats van `ingest-date`/`review-date`; veld `source-url` ontbreekt. Het bestand is een ingest-auditlog, geen reference-page.
  - **Voorgestelde actie:** verplaats naar `wiki/50-decisions/` of een aparte `wiki/60-audits/` subfolder, of voeg een `note: utility-file` veld toe om te voorkomen dat de monthly-audit dit blijft flaggen
  - **First seen:** 2026-06-18

### Broken wikilink — templateplaatshouder (geescaleerd, informatief)

- [ ] `wiki/50-decisions/log.example.md:23` — wikilink `[[30-sessions/YYYY-MM-DD-slug]]` is een plaatshouder, geen echte link
  - **Voorgestelde actie:** zet in een code-block of voeg een HTML-comment toe: dit is bedoeld als voorbeeld
  - **First seen:** 2026-06-09

### Orphan pages — voorbeeld- en templatebestanden

- [ ] `wiki/50-decisions/log.example.md` — geen backlink vanuit index (index verwijst naar `log.md`, niet `log.example.md`)
  - **Voorgestelde actie:** acceptabel als setup-bestand; overweeg vermelding in `index.md` dat `log.example.md` het startpunt is
  - **First seen:** 2026-06-09

- [ ] `wiki/40-references/claude-code/00-index.md` — de references-index linkt naar `overview.md`, niet naar `00-index.md` zelf; geen directe backlink
  - **Voorgestelde actie:** voeg `[[40-references/claude-code/00-index|Claude Code index]]` toe in `wiki/40-references/index.md`
  - **First seen:** 2026-06-09

### Sessies met minimale inhoud

Vijf sessie-bestanden in `30-sessions/processed/` bevatten na de frontmatter slechts 5-7 inhoudsregels (alleen een header en een "Wat is er gebeurd"-blok zonder verdere uitwerking). Dit is conform het `/einde-sessie`-patroon, maar ze staan op `needs-distillation`.

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-…md`, `2026-06-10-1836-…md`, `2026-06-10-1838-…md`, `2026-06-10-session.md`, `2026-06-10-kan-je-…md`, `2026-06-12-0537-…md`, `2026-06-15-1416-…md` — status `needs-distillation`, geen verdere inhoud gedistilleerd
  - **Voorgestelde actie:** run `/process-sessions` of update status naar `archived` als distillatie niet meer relevant is
  - **First seen:** 2026-06-18

---

## Escalatie-status

- Findings ouder dan 7d die naar weekly escaleren: 10 (broken wikilink `[[50-decisions/log]]`, 2x broken raw-links, 2x ontbrekende title, 2x orphan sessions, placeholder-wikilink, 2x orphan templatebestanden)
- Findings ouder dan 30d die naar monthly escaleren: 0

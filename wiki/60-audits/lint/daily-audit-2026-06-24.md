---
audit-date: 2026-06-24
audit-mode: daily
findings-total: 17
findings-hard: 13
findings-soft: 4
---

# Wiki audit 2026-06-24 (daily)

## Samenvatting

- Files gescand: 52 (46 content + 4 templates + 2 bestaande audit-rapporten)
- Hard findings: 13
- Soft findings: 4
- Geescaleerd vanuit vorige cadens: 3 (F-001, F-004, F-005 — open sinds 2026-06-09, >7 dagen)

---

## Hard findings

### Broken wikilinks

- [ ] `wiki/index.md:70` — wikilink `[[50-decisions/log]]` verwijst naar `wiki/50-decisions/log.md` die niet bestaat (alleen `log.example.md` aanwezig)
  - **Voorgestelde actie:** kopieer `log.example.md` naar `log.md` (gitignored) of pas de link aan naar `[[50-decisions/log.example]]`
  - **First seen:** 2026-06-09 (geescaleerd — >7 dagen open)

### Broken relatieve markdown-links (raw/ sessie-bestanden)

Alle 7 sessiebestanden linken naar een `../raw/<naam>.md` transcript-bestand. De map `30-sessions/raw/` bestaat maar is leeg. De bestanden zijn gitignored, maar de links zijn broken voor iedereen die de repo kloont.

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md:34` — link naar `raw/2026-06-10-0011-session.md` bestaat niet
  - **Voorgestelde actie:** verwijder de link-regel of verplaats naar een opmerking `<!-- raw transcript gitignored -->`
  - **First seen:** 2026-06-09 (geescaleerd — >7 dagen open)

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` — link naar `raw/2026-06-10-0025-kan-je-me-de-vergelijking-benchmarks-gev.md` bestaat niet
  - **Voorgestelde actie:** zie vorige finding
  - **First seen:** 2026-06-09 (geescaleerd — >7 dagen open)

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md:32` — link naar `raw/2026-06-10-1339-...md` bestaat niet
  - **Voorgestelde actie:** zie vorige finding
  - **First seen:** 2026-06-24

- [ ] `wiki/30-sessions/processed/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md:33` — link naar `raw/2026-06-10-1836-...md` bestaat niet
  - **Voorgestelde actie:** zie vorige finding
  - **First seen:** 2026-06-24

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md:34` — link naar `raw/2026-06-10-1838-session.md` bestaat niet
  - **Voorgestelde actie:** zie vorige finding
  - **First seen:** 2026-06-24

- [ ] `wiki/30-sessions/processed/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md:32` — link naar `raw/2026-06-12-0537-...md` bestaat niet
  - **Voorgestelde actie:** zie vorige finding
  - **First seen:** 2026-06-24

- [ ] `wiki/30-sessions/processed/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md:37` — link naar `raw/2026-06-15-1416-...md` bestaat niet
  - **Voorgestelde actie:** overweeg of de `raw/`-link-template in `/einde-sessie` aangepast moet worden; als raw altijd gitignored is, is de link structureel broken
  - **First seen:** 2026-06-24

### Ontbrekende frontmatter-velden

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — mist verplicht veld `title`
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — session"` toe aan de frontmatter
  - **First seen:** 2026-06-09 (geescaleerd — >7 dagen open)

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — mist verplicht veld `title`
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — kan-je-me-de-vergelijking-benchmarks-gev"` toe
  - **First seen:** 2026-06-09 (geescaleerd — >7 dagen open)

- [ ] `wiki/40-references/log.md` — categorie is `40-references` maar gebruikt `created`/`updated` in plaats van `ingest-date`/`review-date`; ook geen `source-url`
  - **Voorgestelde actie:** vervang `created`/`updated` door `ingest-date: 2026-06-09` en `review-date: <datum>`; voeg `source-url: internal` of verwijder het veld toe; of herclassificeer als andere categorie
  - **First seen:** 2026-06-24

### Corrupte frontmatter

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md:6` — stray `0` op een eigen regel binnen het YAML-frontmatter-block (ook op regel 21 in de body)
  - **Voorgestelde actie:** verwijder de losse `0` op regel 6 (binnen `---` blok) en op regel 21 (in de body-tekst); vermoedelijk een codeer-artefact van `/einde-sessie`
  - **First seen:** 2026-06-24

---

## Soft findings

### Stale sessies (needs-distillation > 7 dagen)

- [ ] `wiki/30-sessions/processed/` — 5 sessies van 2026-06-10 en 1 sessie van 2026-06-12 hebben status `needs-distillation` en zijn meer dan 7 dagen onbehandeld
  - Betrokken bestanden: `2026-06-10-1339-...`, `2026-06-10-1836-...`, `2026-06-10-1838-...`, `2026-06-10-kan-je-me-...`, `2026-06-10-session.md`, `2026-06-12-0537-...`
  - **Voorgestelde actie:** run `/process-sessions` of verplaats naar `90-archives/` als de inhoud niet meer relevant is
  - **First seen:** 2026-06-24

### Orphan pages — collectie-bestanden zonder externe backlink

De volgende bestanden zijn alleen bereikbaar via een interne `./`-link binnen hun eigen map (via `00-index.md`) maar hebben geen backlink vanuit de rest van de wiki. Dit is structureel acceptabel voor een sub-collectie, maar vermeldenswaard.

- [ ] `wiki/40-references/dutchquill/schrijfstijl.md` — geen backlink buiten `40-references/dutchquill/`
  - **Voorgestelde actie:** verwijs vanuit `wiki/40-references/index.md` naar `dutchquill/00-index.md` (dat linkt intern door); of accepteer als collectie-intern bestand
  - **First seen:** 2026-06-24

- [ ] `wiki/40-references/dutchquill/taal_gids.md` — geen backlink buiten `40-references/dutchquill/`
  - **Voorgestelde actie:** zie vorige finding
  - **First seen:** 2026-06-24

- [ ] `wiki/60-audits/lint/docs-drift-claudecode-2026-06-10.md` — geen backlink vanuit enig wiki-bestand
  - **Voorgestelde actie:** soft finding; audit-rapporten zijn navigeerbaar via browse, niet per se gelinkt; acceptabel
  - **First seen:** 2026-06-24

---

## Opgeloste findings t.o.v. audit 2026-06-09

De volgende findings uit de vorige audit zijn opgelost:

- `wiki/index.md:34` — `[[10-projects/index]]` was broken; `wiki/10-projects/index.md` is aangemaakt
- `wiki/index.md:43` — `[[20-knowledge/index]]` was broken; `wiki/20-knowledge/index.md` is aangemaakt
- `wiki/index.md:61` — `[[40-references/index]]` was broken; `wiki/40-references/index.md` is aangemaakt
- `wiki/index.md` — ontbrekend `created` veld; per spec zijn `index.md`-landingspagina's vrijgesteld van datum-velden (false positive in vorige audit)

---

## Escalatie-status

- Findings ouder dan 7d die naar weekly escaleren: 3 (F-001: broken wikilink `50-decisions/log`, F-004 en F-005: missende `title`-velden in sessies)
- Findings ouder dan 30d die naar monthly escaleren: 0

---

## Summary

**Dagelijkse wiki-audit van 2026-06-24.** 52 bestanden gescand, 17 findings (13 hard, 4 soft).

Voornaamste aandachtspunten:

- Alle 7 sessiebestanden in `30-sessions/processed/` linken naar gitignored `raw/`-transcripts die niet in de repo aanwezig zijn — structureel broken links. Aanbeveling: pas de `/einde-sessie`-template aan zodat de raw-link niet als markdown-link maar als commentaar verschijnt.
- Drie findings escaleren vanuit de audit van 2026-06-09 (>7 dagen onopgelost): de wikilink naar `50-decisions/log.md` en twee sessiebestanden zonder `title`-veld.
- `40-references/log.md` gebruikt de verkeerde frontmatter-velden voor zijn categorie.
- `2026-06-10-1838-session.md` heeft een corrupte YAML-frontmatter met een stray `0` op regel 6.
- Vier positieve resoluties t.o.v. vorige audit: drie index-bestanden zijn aangemaakt en een false-positive frontmatter-finding is gecorrigeerd.

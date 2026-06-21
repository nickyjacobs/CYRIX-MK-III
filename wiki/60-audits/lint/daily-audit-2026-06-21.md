---
title: "Wiki Daily Audit 2026-06-21"
date: 2026-06-21
type: audit
mode: daily
audit-date: 2026-06-21
audit-mode: daily
findings-total: 21
findings-hard: 13
findings-soft: 8
---

# Wiki audit 2026-06-21 (daily)

## Samenvatting

De wiki telt 51 `.md`-bestanden verspreid over 10 categorieën. De grootste problemen zijn zeven session-bestanden die linken naar een niet-bestaande `raw/`-directory, twee wikilinks die naar niet-bestaande targets wijzen, en twee session-files met ontbrekend `title`-veld in de frontmatter. Daarnaast zijn alle zeven processed session-bestanden orphans: ze worden vanuit geen enkele andere pagina gelinkt.

- Files gescand: 51
- Hard findings: 13
- Soft findings: 8
- Geescaleerd vanuit vorige cadens: 0

---

## Hard findings

### Broken links (relatieve markdown-links)

Alle zeven processed session-bestanden linken naar `../raw/<slug>.md`. De `raw/`-map bestaat wel, maar is leeg — de raw-bestanden zijn er nooit naartoe geschreven of zijn al verwijderd.

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md:32` — link naar `../raw/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` werkt niet
  - **Voorgestelde actie:** verwijder de raw-link of herstel het raw-bestand in `wiki/30-sessions/raw/`
  - **First seen:** 2026-06-21

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md:34` — link naar `../raw/2026-06-10-0011-session.md` werkt niet
  - **Voorgestelde actie:** verwijder de raw-link of herstel het raw-bestand
  - **First seen:** 2026-06-21

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md:34` — link naar `../raw/2026-06-10-1838-session.md` werkt niet
  - **Voorgestelde actie:** verwijder de raw-link of herstel het raw-bestand
  - **First seen:** 2026-06-21

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` — link naar `../raw/2026-06-10-0025-kan-je-me-de-vergelijking-benchmarks-gev.md` werkt niet
  - **Voorgestelde actie:** verwijder de raw-link of herstel het raw-bestand
  - **First seen:** 2026-06-21

- [ ] `wiki/30-sessions/processed/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md:37` — link naar `../raw/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md` werkt niet
  - **Voorgestelde actie:** verwijder de raw-link of herstel het raw-bestand
  - **First seen:** 2026-06-21

- [ ] `wiki/30-sessions/processed/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md:32` — link naar `../raw/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md` werkt niet
  - **Voorgestelde actie:** verwijder de raw-link of herstel het raw-bestand
  - **First seen:** 2026-06-21

- [ ] `wiki/30-sessions/processed/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md:33` — link naar `../raw/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md` werkt niet
  - **Voorgestelde actie:** verwijder de raw-link of herstel het raw-bestand
  - **First seen:** 2026-06-21

### Broken wikilinks

- [ ] `wiki/20-knowledge/index.md:16` — wikilink `[[wikilinks]]` verwijst naar een niet-bestaande pagina
  - **Voorgestelde actie:** maak `wiki/20-knowledge/wikilinks.md` aan als conceptuitleg, of vervang door platte tekst
  - **First seen:** 2026-06-21

- [ ] `wiki/60-audits/lint/daily-audit-2026-06-09.md:36` — wikilink `[[50-decisions/log]]` verwijst naar niet-bestaand bestand (alleen `log.example.md` bestaat)
  - **Voorgestelde actie:** maak `wiki/50-decisions/log.md` aan vanuit het example-bestand, of laat staan (audit-bestand, historisch)
  - **First seen:** 2026-06-21

### Ontbrekende frontmatter-velden

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — frontmatter mist `title`
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — benchmarks vergelijking"` toe aan frontmatter
  - **First seen:** 2026-06-21

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — frontmatter mist `title`
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10"` toe aan frontmatter
  - **First seen:** 2026-06-21

- [ ] `wiki/40-references/log.md` — frontmatter gebruikt `created`/`updated` maar categorie `40-references` vereist `ingest-date`, `review-date` en `source-url`
  - **Voorgestelde actie:** dit is een intern log-bestand, geen externe reference — overweeg categorie te wijzigen naar `meta` of `audit`, of voeg de vereiste reference-velden toe als N/A
  - **First seen:** 2026-06-21

- [ ] `wiki/60-audits/lint/daily-audit-2026-06-09.md` — frontmatter mist `title`
  - **Voorgestelde actie:** voeg `title: "Wiki Daily Audit 2026-06-09"` toe, of accepteer dat audit-bestanden geen `title` nodig hebben en pas de check-scope aan
  - **First seen:** 2026-06-21

---

## Soft findings

### Orphan pages

De zeven processed session-bestanden worden door geen enkele andere wiki-pagina gelinkt. Ook de twee `00-index.md`-bestanden in de reference-collecties zijn orphans (de overkoepelende `40-references/index.md` linkt direct naar `overview.md`, niet naar de index-bestanden).

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` — geen backlinks gevonden
  - **Voorgestelde actie:** sessions zijn van nature niet gelinkt vanuit content; overweeg een sessie-index aan te maken in `wiki/30-sessions/` als navigatie gewenst is
  - **First seen:** 2026-06-21

- [ ] `wiki/30-sessions/processed/2026-06-10-1836-kan-je-het-volgende-verifieren-1-session.md` — geen backlinks gevonden
  - **First seen:** 2026-06-21

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md` — geen backlinks gevonden
  - **First seen:** 2026-06-21

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — geen backlinks gevonden
  - **First seen:** 2026-06-21

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — geen backlinks gevonden
  - **First seen:** 2026-06-21

- [ ] `wiki/30-sessions/processed/2026-06-12-0537-doe-even-onderzoek-naar-wat-de-snelste-m.md` — geen backlinks gevonden
  - **First seen:** 2026-06-21

- [ ] `wiki/30-sessions/processed/2026-06-15-1416-hi-hoe-gaat-het-ik-wil-even-een-project-.md` — geen backlinks gevonden
  - **First seen:** 2026-06-21

- [ ] `wiki/40-references/claude-code/00-index.md` — geen backlinks gevonden (40-references/index.md linkt rechtstreeks naar `overview.md`)
  - **Voorgestelde actie:** voeg een link toe vanuit `wiki/40-references/index.md` of `wiki/index.md` naar deze index
  - **First seen:** 2026-06-21

### Dunne content (index-landingspagina's)

De volgende index-pagina's hebben minder dan 10 regels inhoud. Dit is acceptabel voor navigatie-bestanden, maar signaleer voor bewustwording.

- [ ] `wiki/40-references/index.md` — 8 niet-lege inhoudsregels (excl. frontmatter)
  - **Voorgestelde actie:** informatief; actie pas nodig als de index inhoudelijk achterloopt op de collectie
  - **First seen:** 2026-06-21

- [ ] `wiki/20-knowledge/index.md` — 8 niet-lege inhoudsregels (excl. frontmatter)
  - **First seen:** 2026-06-21

- [ ] `wiki/10-projects/index.md` — 8 niet-lege inhoudsregels (excl. frontmatter)
  - **First seen:** 2026-06-21

---

## Escalatie-status

- Findings ouder dan 7d die naar weekly escaleren: 0 (eerste run, geen vorige tracking)
- Findings ouder dan 30d die naar monthly escaleren: 0

---

## Totaaloverzicht

| Categorie | Aantal |
|---|---|
| Broken relatieve links (raw/) | 7 |
| Broken wikilinks | 2 |
| Frontmatter-issues | 4 |
| Orphan pages (sessions) | 7 |
| Orphan pages (00-index) | 1 |
| Dunne index-pagina's (soft) | 3 |
| **Totaal** | **24** |

**Hard findings: 13 — Soft findings: 8**

> Patroon: de broken `raw/`-links en session-orphans zijn structureel. De `/einde-sessie`-routine schrijft processed bestanden maar bewaart de raw-bestanden niet in de repo. Overweeg de raw-link uit het session-template te verwijderen als raw-bestanden niet worden bewaard.

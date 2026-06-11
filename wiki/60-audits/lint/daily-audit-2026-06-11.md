---
title: "Daily Wiki Audit 2026-06-11"
date: 2026-06-11
type: audit
---

# Daily Wiki Audit 2026-06-11

## Samenvatting

49 bestanden gescand. De wiki is structureel gezond: alle relatieve links en wikilinks naar bestaande bestanden werken, er zijn geen lege notes en geen files zonder frontmatter-blok. Er zijn wel drie frontmatter-issues (twee auto-gegenereerde sessies missen `title:`), drie orphan audit-/sessie-bestanden en drie broken raw-session links die verwijzen naar gitignored bestanden.

---

## Broken links

### Relatieve markdown links

Alle relatieve links in `40-references/dutchquill/00-index.md` en `40-references/claude-code/00-index.md` en `plugins.md` zijn intact.

### Wikilinks

Alle wikilinks in `wiki/index.md` en `wiki/40-references/index.md` verwijzen naar bestaande bestanden.

### Links naar gitignored raw-sessiebestanden

De volgende links verwijzen naar `raw/`-bestanden die gitignored zijn en op deze machine niet bestaan. Ze zijn aangemaakt door de session-curator hook en zijn structureel verwacht — maar broken voor wie de repo clonet zonder lokale sessiedata.

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md:32` — link naar `../raw/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` bestaat niet
  - **Voorgestelde actie:** overweeg een disclaimer in het sessietemplate dat raw-links alleen lokaal werken, of verwijder de raw-link uit het gegenereerde format
  - **First seen:** 2026-06-11

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md:34` — link naar `../raw/2026-06-10-0011-session.md` bestaat niet
  - **Voorgestelde actie:** zie bovenstaande actie
  - **First seen:** 2026-06-11

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` — link naar `../raw/2026-06-10-0025-kan-je-me-de-vergelijking-benchmarks-gev.md` bestaat niet
  - **Voorgestelde actie:** zie bovenstaande actie
  - **First seen:** 2026-06-11

---

## Frontmatter issues

### Ontbrekend verplicht veld `title:` in sessie-bestanden

Twee auto-gegenereerde sessiebestanden hebben wel een `date:`, `type:`, `status:`, `tags:` en `category:`, maar missen het verplichte `title:`-veld.

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — ontbreekt: `title:`
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — session"` toe aan frontmatter, of fix het session-curator template zodat `title:` altijd gegenereerd wordt
  - **First seen:** 2026-06-11

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — ontbreekt: `title:`
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — kan-je-me-de-vergelijking-benchmarks-gev"` toe aan frontmatter, of fix het session-curator template
  - **First seen:** 2026-06-11

### Index/log-bestanden met afwijkend frontmatter-schema (soft)

De volgende bestanden zijn geen reference-pages maar staan wel in `40-references/`. Ze gebruiken terecht een ander schema (`created`/`updated` in plaats van `ingest-date`/`review-date`). Geen actie vereist, maar ter notitie:

- `wiki/40-references/log.md` — gebruikt `created`/`updated`-schema (ingest-log, geen externe bron)
- `wiki/40-references/index.md` — index-pagina, terecht alleen `title`, `category`, `status`, `tags`

### Template-bestand met lege tags (soft)

- `wiki/_templates/knowledge-note.md` — heeft `tags: []`. Dit is de bedoelde template-staat; geen actie vereist tenzij templates ook gevuld moeten worden.

### `wiki/index.md` mist `tags:`-veld (soft)

De hoofd-landingspagina heeft `title`, `category`, `status` en `updated`, maar geen `tags:`-veld. Per spec zijn voor index-landingspagina's alleen `title`, `category` en `status` vereist — dit is dus geen harde overtreding.

---

## Orphan notes

Bestanden zonder enkele backlink vanuit de rest van de wiki:

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` — geen enkel bestand linkt naar deze sessie
  - **Voorgestelde actie:** normaal voor sessies; overweeg een sessie-index in `30-sessions/` die alle processed-sessies opsomt
  - **First seen:** 2026-06-11

- [ ] `wiki/60-audits/lint/docs-drift-claudecode-2026-06-10.md` — geen enkel bestand linkt naar dit audit-rapport
  - **Voorgestelde actie:** normaal voor audit-rapporten; optioneel: voeg een `60-audits/index.md` toe als navigatiepunt
  - **First seen:** 2026-06-11

- [ ] `wiki/60-audits/lint/daily-audit-2026-06-09.md` — geen enkel bestand linkt naar dit audit-rapport
  - **Voorgestelde actie:** zie bovenstaande actie
  - **First seen:** 2026-06-11

---

## Lege notes

Geen lege notes gevonden. Alle bestanden hebben voldoende inhoud (meer dan 5 niet-lege regels buiten frontmatter).

---

## Actiepunten

### Prioriteit 1 — fix (klein, snel)

1. **Fix `title:` in twee sessiebestanden** — voeg het veld toe in `2026-06-10-session.md` en `2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md`, of pas het session-curator template aan zodat `title:` altijd gegenereerd wordt.

### Prioriteit 2 — structuur (aanbevolen)

2. **Beslissen over raw-session links** — de drie broken links naar `raw/`-bestanden zijn structureel door het session-curator template. Overweeg of de raw-link nuttig is in de committed versie, en pas het template aan als dat niet zo is.

### Prioriteit 3 — optioneel (soft)

3. **Sessie-index aanmaken** — een `wiki/30-sessions/index.md` die processed-sessies opsomt zou orphan-sessies oplossen en navigatie verbeteren.
4. **Audit-index aanmaken** — een `wiki/60-audits/index.md` of backlink vanuit `wiki/index.md` naar de audit-map zou audit-orphans oplossen.

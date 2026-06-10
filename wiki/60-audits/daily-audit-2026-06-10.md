---
audit-date: 2026-06-10
audit-mode: daily
findings-total: 13
findings-hard: 9
findings-soft: 4
---

# Wiki audit 2026-06-10 (daily)

## Samenvatting

- Files gescand: 32
- Hard findings: 9
- Soft findings: 4
- Geescaleerd vanuit vorige cadens: 9 (alle findings van 2026-06-09 staan nog open)

---

## Hard findings

### Broken wikilinks

- [ ] `wiki/index.md:34` — wikilink `[[10-projects/index]]` verwijst naar `wiki/10-projects/index.md`, die niet bestaat (map `10-projects/` bestaat niet)
  - **Voorgestelde actie:** maak `wiki/10-projects/index.md` aan of verwijder de link
  - **First seen:** 2026-06-09

- [ ] `wiki/index.md:43` — wikilink `[[20-knowledge/index]]` verwijst naar `wiki/20-knowledge/index.md`, die niet bestaat (map `20-knowledge/` bestaat niet)
  - **Voorgestelde actie:** maak `wiki/20-knowledge/index.md` aan of verwijder de link
  - **First seen:** 2026-06-09

- [ ] `wiki/index.md:61` — wikilink `[[40-references/index]]` verwijst naar `wiki/40-references/index.md`, die niet bestaat
  - **Voorgestelde actie:** maak `wiki/40-references/index.md` aan, of pas de link aan naar de bestaande `40-references/claude-code/00-index` en `40-references/dutchquill/00-index`
  - **First seen:** 2026-06-09

- [ ] `wiki/index.md:70` — wikilink `[[50-decisions/log]]` verwijst naar `wiki/50-decisions/log.md`, die niet bestaat (alleen `log.example.md` aanwezig)
  - **Voorgestelde actie:** kopieer `log.example.md` naar `log.md` (gitignored) of pas de link aan naar `50-decisions/log.example`
  - **First seen:** 2026-06-09

### Broken standaard markdown-links

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md:34` — link `../raw/2026-06-10-0011-session.md` verwijst naar een bestand dat niet bestaat (`30-sessions/raw/` is leeg)
  - **Voorgestelde actie:** verwijder de link of bevestig dat het raw-bestand gitignored is maar lokaal bestaat; als het ontbreekt, verwijder de referentie
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` — link `../raw/2026-06-10-0025-kan-je-me-de-vergelijking-benchmarks-gev.md` verwijst naar een bestand dat niet bestaat
  - **Voorgestelde actie:** zie hierboven
  - **First seen:** 2026-06-09

### Ontbrekende frontmatter-velden

- [ ] `wiki/index.md` — mist verplicht veld `created` (heeft `updated` maar geen `created`)
  - **Voorgestelde actie:** voeg `created: 2026-06-09` toe aan de frontmatter
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — mist verplichte velden `title`, `created`, `updated`
  - **Voorgestelde actie:** voeg ontbrekende velden toe; `title` kan `Sessie 2026-06-10` zijn, `created`/`updated` de datum `2026-06-10`
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — mist verplichte velden `title`, `created`, `updated`
  - **Voorgestelde actie:** voeg ontbrekende velden toe aan de frontmatter
  - **First seen:** 2026-06-09

---

## Soft findings

### Ontbrekende frontmatter-velden in references (structureel patroon)

- [ ] `wiki/40-references/claude-code/` (12 bestanden) en `wiki/40-references/dutchquill/` (4 bestanden) — alle reference-pagina's missen `created` en `updated`; deze velden zijn vervangen door `ingest-date` en `review-date`
  - **Voorgestelde actie:** accepteer dit patroon voor reference-pagina's (ingest-date vervangt created/updated) of voeg beide velden toe; update het frontmatter-template `_templates/reference-page.md` om dit expliciet te documenteren
  - **First seen:** 2026-06-10

### Orphan pages

- [ ] `wiki/40-references/claude-code/00-index.md` — geen enkel ander wiki-bestand linkt naar deze pagina
  - **Voorgestelde actie:** voeg een directe link toe vanuit `wiki/index.md` bento-card voor References, zodra `40-references/index.md` aangemaakt is of vervang die wikilink door een directe verwijzing
  - **First seen:** 2026-06-09

### Notes zonder tags

- [ ] `wiki/index.md` — `tags: []` (leeg)
  - **Voorgestelde actie:** voeg minimaal `tags: [index, wiki]` toe
  - **First seen:** 2026-06-10

### Templates met lege tags (placeholder-patroon)

- [ ] `wiki/_templates/knowledge-note.md` — `tags: []` in template-frontmatter
  - **Voorgestelde actie:** acceptabel als template-placeholder; overweeg `tags: [TODO]` als reminder voor invullers
  - **First seen:** 2026-06-10

---

## Escalatie-status

- Findings ouder dan 7d die naar weekly escaleren: 0
- Findings ouder dan 30d die naar monthly escaleren: 0

> Noot: 9 hard findings uit 2026-06-09 staan nog open. Bij de volgende weekly-audit (na 2026-06-16) escaleren deze automatisch als ze dan >7 dagen open zijn.

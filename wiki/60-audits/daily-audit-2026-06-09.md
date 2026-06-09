---
audit-date: 2026-06-09
audit-mode: daily
findings-total: 12
findings-hard: 9
findings-soft: 3
---

# Wiki audit 2026-06-09 (daily)

## Samenvatting

- Files gescand: 32
- Hard findings: 9
- Soft findings: 3
- Geescaleerd vanuit vorige cadens: 0

---

## Hard findings

### Broken wikilinks

- [ ] `wiki/index.md:34` — wikilink `[[10-projects/index]]` verwijst naar `wiki/10-projects/index.md`, die niet bestaat
  - **Voorgestelde actie:** maak `wiki/10-projects/index.md` aan of verwijder de link
  - **First seen:** 2026-06-09

- [ ] `wiki/index.md:43` — wikilink `[[20-knowledge/index]]` verwijst naar `wiki/20-knowledge/index.md`, die niet bestaat
  - **Voorgestelde actie:** maak `wiki/20-knowledge/index.md` aan of verwijder de link
  - **First seen:** 2026-06-09

- [ ] `wiki/index.md:61` — wikilink `[[40-references/index]]` verwijst naar `wiki/40-references/index.md`, die niet bestaat
  - **Voorgestelde actie:** maak `wiki/40-references/index.md` aan of verwijder de link en verwijs direct naar `40-references/claude-code/00-index.md` en `40-references/dutchquill/00-index.md`
  - **First seen:** 2026-06-09

- [ ] `wiki/index.md:70` — wikilink `[[50-decisions/log]]` verwijst naar `wiki/50-decisions/log.md`, die niet bestaat (alleen `log.example.md` aanwezig)
  - **Voorgestelde actie:** kopieer `log.example.md` naar `log.md` (gitignored) of pas de link aan naar `50-decisions/log.example`
  - **First seen:** 2026-06-09

### Ontbrekende frontmatter-velden

- [ ] `wiki/index.md` — mist verplicht veld `date` (of `created`); heeft alleen `updated`
  - **Voorgestelde actie:** voeg `created: 2026-06-09` toe aan de frontmatter
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — mist verplicht veld `title`
  - **Voorgestelde actie:** voeg een `title:` toe aan de frontmatter, bv. `title: Sessie 2026-06-10`
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — mist verplicht veld `title`
  - **Voorgestelde actie:** voeg een `title:` toe aan de frontmatter
  - **First seen:** 2026-06-09

### Orphan pages

- [ ] `wiki/40-references/claude-code/00-index.md` — geen enkel ander wiki-bestand linkt naar deze pagina
  - **Voorgestelde actie:** voeg een link toe vanuit `wiki/index.md` of maak `wiki/40-references/index.md` aan met verwijzingen naar de twee reference-indexen
  - **First seen:** 2026-06-09

- [ ] `wiki/40-references/log.md` — geen enkel ander wiki-bestand linkt naar deze pagina
  - **Voorgestelde actie:** voeg een verwijzing toe vanuit `wiki/40-references/claude-code/00-index.md` of `wiki/index.md`
  - **First seen:** 2026-06-09

---

## Soft findings

### Orphan pages (templates en voorbeeldbestanden)

- [ ] `wiki/50-decisions/log.example.md` — geen enkel wiki-bestand linkt naar dit bestand (index.md verwijst naar `log.md`, niet `log.example.md`)
  - **Voorgestelde actie:** acceptabel als voorbeeld-bestand; overweeg een opmerking in `index.md` dat `log.example.md` als template dient
  - **First seen:** 2026-06-09

- [ ] `wiki/_templates/knowledge-note.md` — geen backlink
  - **Voorgestelde actie:** `index.md` verwijst al naar `_templates/` als map; overweeg een expliciete wikilink of accepteer als onderliggende templatemap
  - **First seen:** 2026-06-09

- [ ] `wiki/_templates/project-readme.md` — geen backlink
  - **Voorgestelde actie:** zie hierboven
  - **First seen:** 2026-06-09

---

## Escalatie-status

- Findings ouder dan 7d die naar weekly escaleren: 0
- Findings ouder dan 30d die naar monthly escaleren: 0

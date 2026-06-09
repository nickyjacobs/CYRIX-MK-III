---
audit-date: 2026-06-09
audit-mode: daily
findings-total: 14
findings-hard: 10
findings-soft: 4
---

# Wiki audit 2026-06-09 (daily)

## Samenvatting

- Files gescand: 33
- Hard findings: 10
- Soft findings: 4
- Geescaleerd vanuit vorige cadens: 0

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

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md:34` — link naar `../raw/2026-06-10-0011-session.md` verwijst naar een bestand dat niet bestaat (`30-sessions/raw/` is leeg)
  - **Voorgestelde actie:** verwijder de link of herstel het raw-bestand in `wiki/30-sessions/raw/`
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` — link naar `../raw/2026-06-10-0025-kan-je-me-de-vergelijking-benchmarks-gev.md` verwijst naar een bestand dat niet bestaat
  - **Voorgestelde actie:** verwijder de link of herstel het raw-bestand in `wiki/30-sessions/raw/`
  - **First seen:** 2026-06-09

### Ontbrekende frontmatter-velden

- [ ] `wiki/index.md` — mist verplicht veld `title` of `date` (heeft `updated` maar geen `created`/`date`)
  - **Voorgestelde actie:** voeg `created: 2026-06-09` toe aan de frontmatter
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — mist verplicht veld `title`
  - **Voorgestelde actie:** voeg `title: Sessie 2026-06-10` toe aan de frontmatter
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — mist verplicht veld `title`
  - **Voorgestelde actie:** voeg een `title:` toe aan de frontmatter
  - **First seen:** 2026-06-09

### Orphan pages

- [ ] `wiki/40-references/claude-code/00-index.md` — geen enkel ander wiki-bestand linkt naar deze pagina
  - **Voorgestelde actie:** voeg een link toe vanuit `wiki/index.md` (via `[[40-references/index]]` zodra die aangemaakt is) of direct vanuit de bento-card voor References
  - **First seen:** 2026-06-09

---

## Soft findings

### Broken wikilink in template (placeholder)

- [ ] `wiki/50-decisions/log.example.md:23` — wikilink `[[30-sessions/YYYY-MM-DD-slug]]` is een templateplaatshouder, geen echte link
  - **Voorgestelde actie:** acceptabel als voorbeeld; overweeg een HTML-comment of code-block om aan te geven dat dit een placeholder is
  - **First seen:** 2026-06-09

### Orphan pages (templates en voorbeeldbestanden)

- [ ] `wiki/50-decisions/log.example.md` — geen enkel wiki-bestand linkt naar dit bestand (`index.md` verwijst naar `log.md`, niet `log.example.md`)
  - **Voorgestelde actie:** acceptabel als voorbeeld-bestand; overweeg een opmerking in `index.md` dat `log.example.md` als startpunt dient
  - **First seen:** 2026-06-09

- [ ] `wiki/_templates/knowledge-note.md` — geen directe backlink naar dit specifieke bestand (`index.md` verwijst naar de map `_templates/`, niet naar individuele templates)
  - **Voorgestelde actie:** acceptabel; `index.md` verwijst naar de map als geheel
  - **First seen:** 2026-06-09

- [ ] `wiki/_templates/project-readme.md` — geen directe backlink naar dit specifieke bestand
  - **Voorgestelde actie:** zie hierboven
  - **First seen:** 2026-06-09

---

## Escalatie-status

- Findings ouder dan 7d die naar weekly escaleren: 0
- Findings ouder dan 30d die naar monthly escaleren: 0

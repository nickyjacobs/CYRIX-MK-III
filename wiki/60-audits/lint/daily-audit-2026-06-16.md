---
title: "Daily wiki audit 2026-06-16"
date: 2026-06-16
type: audit
audit-mode: daily
findings-total: 7
findings-hard: 5
findings-soft: 2
---

# Daily wiki audit — 2026-06-16

## Samenvatting

- Files gescand: 50 (excl. 60-audits/)
- Hard findings: 5
- Soft findings: 2
- Geescaleerd vanuit vorige cadens: 0

---

## Hard findings

### Broken links

- [ ] `wiki/_templates/knowledge-note.md:36` — lege wikilink `[[ ]]` zonder doel
  - **Voorgestelde actie:** verwijder de lege wikilink of vervang door een echt voorbeeld zoals `[[related-note]]`
  - **First seen:** 2026-06-16

- [ ] `wiki/50-decisions/log.example.md:23` — wikilink `[[30-sessions/YYYY-MM-DD-slug]]` verwijst naar een niet-bestaand bestand
  - **Voorgestelde actie:** vervang door een commentaar-placeholder (`<!-- [[30-sessions/YYYY-MM-DD-slug]] -->`) of een bestaande sessie als voorbeeld
  - **First seen:** 2026-06-16

### Ontbrekende of foutieve frontmatter

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — verplicht veld `title` ontbreekt in frontmatter (sessions vereisen: `title`, `date`, `type`, `status`, `tags`, `category`)
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — session"` toe aan frontmatter
  - **First seen:** 2026-06-16

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — verplicht veld `title` ontbreekt in frontmatter
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — kan-je-me-de-vergelijking-benchmarks-gev"` toe aan frontmatter
  - **First seen:** 2026-06-16

- [ ] `wiki/30-sessions/processed/2026-06-10-1838-session.md` — ongeldige YAML in frontmatter: losse `0` op eigen regel tussen `tool-uses: 0` en `content-changes: 0` (ook herhaald in de body)
  - **Voorgestelde actie:** verwijder de losse `0`-regel uit zowel frontmatter als body
  - **First seen:** 2026-06-16

---

## Soft findings

### Afwijkend frontmatter-schema

- [ ] `wiki/40-references/log.md` — staat in `40-references/` maar gebruikt `created`/`updated` in plaats van `source-url`/`ingest-date`/`review-date` die voor deze categorie verplicht zijn
  - **Voorgestelde actie:** beschouw dit bestand als een uitzondering (het is een audit-trail, geen reference) en documenteer dit als zodanig, of verplaats naar een aparte `wiki/50-decisions/` of `wiki/60-audits/` locatie
  - **First seen:** 2026-06-16

### Orphan notes

- [ ] `wiki/30-sessions/processed/` — alle 7 sessiebestanden worden door geen enkele andere wiki-pagina via wikilink aangehaald (enkel generieke Browse-tekst in `index.md`)
  - **Voorgestelde actie:** dit is by-design gedrag voor sessies; geen actie vereist tenzij er een sessie is die een specifiek besluit of kennisitem oplevert dat ook vanuit `20-knowledge/` of `50-decisions/` moet worden gelinkt
  - **First seen:** 2026-06-16

---

## Aanbevelingen

1. **Fix de malformed frontmatter** in `2026-06-10-1838-session.md` (losse `0`) — dit kan tooling breken die YAML parst.
2. **Voeg `title` toe** aan de twee oudere sessiebestanden uit juni 2026 die de oudere sessie-writer gebruikten zonder title-veld.
3. **Ruim de broken templatelinks op** in `_templates/knowledge-note.md` en `50-decisions/log.example.md` zodat ze geen valse breaking-link alerts genereren bij toekomstige audits.

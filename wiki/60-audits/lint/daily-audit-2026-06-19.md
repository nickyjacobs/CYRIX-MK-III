---
title: Daily Wiki Audit 2026-06-19
date: 2026-06-19
type: audit
audit-mode: daily
findings-total: 9
findings-hard: 4
findings-soft: 5
---

# Daily Wiki Audit — 2026-06-19

## Samenvatting

- Files gescand: 48
- Hard findings: 4
- Soft findings: 5
- Broken links: 0
- Frontmatter-issues: 3
- Orphan notes: 4 (reele orphans)
- Lege notes: 0

---

## Hard findings

### Frontmatter issues

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — ontbreekt verplicht veld `title`
  - **Voorgestelde actie:** voeg `title: Sessie 2026-06-10 — vergelijking benchmarks` toe aan frontmatter
  - **First seen:** 2026-06-19

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — ontbreekt verplicht veld `title`
  - **Voorgestelde actie:** voeg `title: Sessie 2026-06-10` toe aan frontmatter
  - **First seen:** 2026-06-19

- [ ] `wiki/40-references/log.md` — verkeerde datumvelden: gebruikt `created`/`updated` maar categorie `40-references` vereist `ingest-date`/`review-date` (conform wiki-conventie en `_templates/reference-page.md`)
  - **Voorgestelde actie:** vervang `created`/`updated` door `ingest-date: 2026-06-09` en `review-date: <datum>` en voeg `source-url` toe indien van toepassing
  - **First seen:** 2026-06-19

### Orphan notes

- [ ] `wiki/40-references/claude-code/00-index.md` — niet gelinkt vanuit enige andere pagina. `wiki/40-references/index.md` linkt naar `claude-code/overview` (niet naar `00-index`)
  - **Voorgestelde actie:** update `wiki/40-references/index.md` om de wikilink te wijzigen van `[[40-references/claude-code/overview|Claude Code]]` naar `[[40-references/claude-code/00-index|Claude Code]]`, zodat de gebruiker op de inhoudsopgave-pagina uitkomt
  - **First seen:** 2026-06-19

---

## Soft findings

### Frontmatter issues

- [ ] `wiki/index.md` — ontbreekt veld `tags` (root-landingspagina; tags zijn optioneel voor index-pagina's maar wel de wiki-standaard)
  - **Voorgestelde actie:** voeg `tags: [index, wiki]` toe aan frontmatter
  - **First seen:** 2026-06-19

### Orphan notes (bereikbaar via collectie-pad, maar geen directe wikilink)

- [ ] `wiki/40-references/dutchquill/00-index.md` — niet gelinkt via wikilink of `[]()` vanuit `40-references/index.md`; collectie staat alleen als backtick-tekst vermeld (`dutchquill/`)
  - **Voorgestelde actie:** voeg een wikilink toe in `wiki/40-references/index.md`: `[[40-references/dutchquill/00-index|DutchQuill]]`
  - **First seen:** 2026-06-19

- [ ] `wiki/40-references/dutchquill/taal_gids.md`, `schrijfstijl.md`, `humanize_nl_gids.md` — bereikbaar via `dutchquill/00-index.md` (relatieve links in die index), maar `00-index.md` zelf is orphan (zie boven). Cascade-probleem.
  - **Voorgestelde actie:** opgelost zodra `dutchquill/00-index.md` gelinkt wordt (zie vinding hierboven)
  - **First seen:** 2026-06-19

### Sessies zonder backlinks (structureel, geen actie vereist)

- Alle 7 sessie-files in `wiki/30-sessions/processed/` zijn niet gelinkt vanuit andere pagina's. Dit is by design: sessies zijn auto-gegenereerde logs zonder cross-links. Geen actie nodig.

---

## Broken links

Geen gevonden. Alle wikilinks en relatieve `[]()` links in gescande bestanden verwijzen naar bestaande targets.

---

## Lege notes

Geen gevonden. Alle gescande bestanden hebben meer dan 50 woorden inhoud (laagste: 61 woorden in `00-context/goals.example.md`).

---

## Acties (geprioriteerd)

1. **[Hard]** Fix ontbrekend `title`-veld in 2 sessie-files (`2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md`, `2026-06-10-session.md`)
2. **[Hard]** Herstel frontmatter-conventie in `40-references/log.md`: vervang `created`/`updated` door `ingest-date`/`review-date`
3. **[Hard]** Herstel de wikilink in `40-references/index.md`: wijs naar `claude-code/00-index` in plaats van `claude-code/overview`
4. **[Soft]** Voeg wikilink naar `dutchquill/00-index` toe in `40-references/index.md`
5. **[Soft]** Voeg `tags`-veld toe aan `wiki/index.md`

---
title: CYRIX wiki — index
updated: 2026-09-10
category: index
status: active
---

# CYRIX wiki

Lazy-lookup catalogus. Begin hier, open maximaal 3 sub-pagina's per vraag.

<div class="bento-grid">

<div class="bento-card cat-context">

## 📋 Context
*Wie ben ik, wat doe ik, waar werk ik naartoe*

- [[00-context/me|Profiel]]
- [[00-context/work|Werk]]
- [[00-context/team|Team]]
- [[00-context/current-priorities|Huidige prioriteiten]]
- [[00-context/goals|Doelen en mijlpalen]]

> Bij eerste setup: kopieer elk `.example.md` naar `<naam>.md` en vul je eigen data in. De `.md` versies zijn gitignored, blijven dus lokaal. Tot die kopie bestaat wijzen bovenstaande links nergens heen.

</div>

<div class="bento-card cat-projects">

## 🚧 Projecten
*Actieve werkstromen*

Zie [[10-projects/index|Project-overzicht]] of browse `10-projects/`.

</div>

<div class="bento-card cat-knowledge">

## 🧠 Knowledge
*Gestructureerde kennis-notes (Zettelkasten-stijl)*

Zie [[20-knowledge/index|Knowledge-overzicht]] of browse `20-knowledge/`.

</div>

<div class="bento-card cat-sessions">

## 📝 Sessies
*Auto-gegenereerde sessie-logs (lokaal)*

De SessionEnd-hook schrijft bij elk sessie-einde een raw log naar `30-sessions/raw/` en een processed log naar `30-sessions/processed/`. Beide blijven lokaal. Met `/process-sessions` distilleer je die backlog naar knowledge, decisions en project-updates; de gecureerde logs komen in `30-sessions/` zelf.

</div>

<div class="bento-card cat-references">

## 📚 References
*Externe documentatie, ingestueerd via `/ingest`*

Zie [[40-references/index|References-overzicht]] of browse `40-references/`.

</div>

<div class="bento-card cat-decisions">

## ⚖️ Besluiten
*Append-only beslissingen-log met onderbouwing*

- [[50-decisions/log.example|Decisions log]] · *(echte `log.md` is gitignored, blijft lokaal)*

</div>

<div class="bento-card cat-audits">

## 🔍 Audits
*Wiki-audit-rapporten (daily, weekly, monthly)*

Browse `60-audits/`. Draai `@wiki-librarian daily` lokaal voor een scan van de volledige wiki; een cloud-routine ziet de gitignorede content niet. De findings-state staat in `60-audits/lint/_tracking.md`.

</div>

<div class="bento-card cat-archives">

## 📦 Archives
*Afgeronde projecten, oude notes, bewaard in plaats van verwijderd*

Browse `90-archives/`. Vervangen references gaan naar `90-archives/40-references/`, oude MEMORY-inzichten naar `90-archives/memory-archive.md`.

</div>

</div>

---

## Hoe je deze wiki gebruikt

1. Begin altijd hier — niet direct grep'en
2. Open max 3 sub-pagina's per vraag
3. Bij brede onderwerpen: grep fallback (`grep -r "term" wiki/`)
4. Schrijf niet handmatig, gebruik `/ingest` of `/process-sessions`
5. Verwijder nooit — verplaats naar `90-archives/`

## Frontmatter-conventie

Minimum per pagina: `title`, `tags`, `category`, `status`. De datum-velden zijn categorie-afhankelijk:

- `10-projects/`, `20-knowledge/`: `created` + `updated`
- `40-references/`: `ingest-date` + `review-date` (+ `source-url`)
- `30-sessions/`: `date`
- `index.md`-landingspagina's: geen datum-velden nodig

Templates in [`_templates/`](./_templates/).

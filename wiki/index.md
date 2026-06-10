---
title: CYRIX wiki — index
updated: 2026-06-09
category: index
status: active
---

# CYRIX wiki

Lazy-lookup catalogus. Begin hier, open maximaal 3 sub-pagina's per vraag.

<div class="bento-grid">

<div class="bento-card cat-context">

## 📋 Context
*Wie ben ik, wat doe ik, waar werk ik naartoe*

- [[00-context/me.example|Profiel]] · *(kopieer naar `me.md`)*
- [[00-context/work.example|Werk]]
- [[00-context/team.example|Team]]
- [[00-context/current-priorities.example|Huidige prioriteiten]]
- [[00-context/goals.example|Doelen en mijlpalen]]

> Bij eerste setup: kopieer elk `.example.md` naar `<naam>.md` en vul je eigen data in. De `.md` versies zijn gitignored, blijven dus lokaal.

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

Browse `30-sessions/` voor recente logs. Wordt aangevuld door `/einde-sessie`.

</div>

<div class="bento-card cat-references">

## 📚 References
*Externe documentatie, ingestueerd via `/ingest-docs`*

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

Browse `60-audits/`. Gegenereerd door `wiki-librarian` routine.

</div>

<div class="bento-card cat-archives">

## 📦 Archives
*Afgeronde projecten, oude notes — bewaard niet verwijderd*

Browse `90-archives/`.

</div>

</div>

---

## Hoe je deze wiki gebruikt

1. Begin altijd hier — niet direct grep'en
2. Open max 3 sub-pagina's per vraag
3. Bij brede onderwerpen: grep fallback (`grep -r "term" wiki/`)
4. Schrijf niet handmatig — gebruik `/ingest` of `/einde-sessie`
5. Verwijder nooit — verplaats naar `90-archives/`

## Frontmatter-conventie

Minimum per pagina: `title`, `tags`, `category`, `status`. De datum-velden zijn categorie-afhankelijk:

- `10-projects/`, `20-knowledge/`: `created` + `updated`
- `40-references/`: `ingest-date` + `review-date` (+ `source-url`)
- `30-sessions/`: `date`
- `index.md`-landingspagina's: geen datum-velden nodig

Templates in [`_templates/`](./_templates/).

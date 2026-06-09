---
title: References ingest log
created: 2026-06-09
updated: 2026-06-09
tags: [references, log, audit-trail]
category: 40-references
status: active
---

# References ingest log

Append-only log van alle `/ingest` en `/ingest-docs` aanroepen. Audit-trail voor wat wanneer en waarvandaan in de wiki terecht kwam.

## Format

```markdown
## YYYY-MM-DD — <source-slug>
**Bron:** <URL of pad>
**Pagina's:** <aantal>
**Pad:** wiki/40-references/<slug>/
**Trigger:** initial | re-ingest | partial-update
**Notities:** <korte beschrijving, eventuele afwijkingen>
```

---

## 2026-06-09 — claude-code (initial)
**Bron:** https://code.claude.com/docs/en/overview
**Pagina's:** 9 (agent-teams, cli-reference, hooks, mcp, memory, overview, settings, skills, sub-agents)
**Pad:** `wiki/40-references/claude-code/`
**Trigger:** initial (hergebruikt uit MK-II 2026-03-26 ingest)
**Notities:** Subpagina's stammen uit maart 2026. Mogelijke updates in docs sinds dan. Frontmatter toegevoegd op 2026-06-09. Re-ingest aanbevolen voor september 2026.

## 2026-06-09 — dutchquill (initial)
**Bron:** `~/Desktop/Agentic AI Workflows/DutchQuill AI/` (lokaal pad, MIT-licensed)
**Pagina's:** 4 (schrijfstijl, taal_gids, humanize_nl_gids, LICENSE)
**Pad:** `wiki/40-references/dutchquill/`
**Trigger:** initial
**Notities:** Selectie van 3 generieke gidsen + LICENSE. APA, academische stijl, AI-gebruik gids NIET overgenomen (te studie-specifiek). Re-ingest review-date: 2026-09-09.

## 2026-06-09 — claude-code (partial update)
**Bron:** WebFetch op https://code.claude.com/docs/en/{routines,output-styles,slash-commands,plugins}
**Pagina's:** 4 nieuw (routines, output-styles, slash-commands, plugins)
**Pad:** `wiki/40-references/claude-code/`
**Trigger:** partial-update — fill gaps van maart-ingest
**Notities:** Belangrijke vondst: custom commands en skills zijn gemerged. Routines zijn nu in research preview. Bestaande 9 pagina's blijven van maart 2026 — full refresh in september-cyclus.

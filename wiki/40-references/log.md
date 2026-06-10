---
title: References ingest log
created: 2026-06-09
updated: 2026-06-10
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

## 2026-06-10 — claude-code (re-ingest, top-3 drift)
**Bron:** WebFetch op https://code.claude.com/docs/en/{hooks,cli-reference,settings}
**Pagina's:** 3 bijgewerkt (hooks, cli-reference, settings)
**Pad:** `wiki/40-references/claude-code/`
**Trigger:** re-ingest — o.b.v. docs-drift rapport (PR #3, routine `cyrix-docs-drift-claudecode`)
**Notities:** Bestaande detail behouden, frontmatter ververst (ingest-date 2026-06-10, review-date 2026-09-10), cli-reference source-url gecorrigeerd (cli-usage werd cli-reference). Per pagina een "Update 2026-06-10 (docs-drift)" sectie met nieuwe events/commands/keys. Oude versies in git-history (geen aparte archive). De overige 39 nieuwe pagina's uit het drift-rapport zijn nog niet ge-ingest.

## 2026-06-10 — claude-code (partial update, HOOG-prioriteit drift-pagina's)
**Bron:** WebFetch op https://code.claude.com/docs/en/{commands,agent-view,permissions,env-vars,channels,channels-reference,advisor,permission-modes,model-config,debug-your-config}
**Pagina's:** 10 nieuw (commands, agent-view, permissions, env-vars, channels, channels-reference, advisor, permission-modes, model-config, debug-your-config)
**Pad:** `wiki/40-references/claude-code/`
**Trigger:** partial-update — HOOG-prioriteit nieuwe pagina's uit het docs-drift rapport (PR #3, routine `cyrix-docs-drift-claudecode`)
**Notities:** Gecureerde samenvattingen (overzicht + tabellen), geen volledige kopie. Frontmatter conform model `settings.md`/`hooks.md` (ingest-date 2026-06-10, review-date 2026-09-10). 00-index TOC bijgewerkt met de 10 pagina's. Resterende drift-pagina's (lagere prioriteit) nog open voor volgende ronde.

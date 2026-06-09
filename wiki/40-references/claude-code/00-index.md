---
title: Claude Code documentatie — index
source-url: https://code.claude.com/docs/en/overview
ingest-date: 2026-06-09
review-date: 2026-09-09
tags: [reference, claude-code, docs]
category: 40-references
status: active
ingested-from: MK-II references/claude-code/ (initial 2026-03-26)
re-ingest-trigger: monthly wiki-librarian bij stale review-date
---

# Claude Code documentatie

> Lokale samenvatting van [Claude Code official docs](https://code.claude.com/docs/en/overview). Per pagina een markdown-samenvatting met directe link naar de bron.
>
> **Re-ingest** wanneer review-date verstreken is — Claude Code evolueert snel.

## Pagina-index

| Onderwerp | Lokale samenvatting | Bron |
|---|---|---|
| Overview | [`overview.md`](./overview.md) | https://code.claude.com/docs/en/overview |
| CLI reference | [`cli-reference.md`](./cli-reference.md) | https://code.claude.com/docs/en/cli-usage |
| Skills | [`skills.md`](./skills.md) | https://code.claude.com/docs/en/skills |
| Sub-agents | [`sub-agents.md`](./sub-agents.md) | https://code.claude.com/docs/en/sub-agents |
| Agent teams | [`agent-teams.md`](./agent-teams.md) | https://code.claude.com/docs/en/agent-teams |
| Settings | [`settings.md`](./settings.md) | https://code.claude.com/docs/en/settings |
| Hooks | [`hooks.md`](./hooks.md) | https://code.claude.com/docs/en/hooks |
| Memory | [`memory.md`](./memory.md) | https://code.claude.com/docs/en/memory |
| MCP | [`mcp.md`](./mcp.md) | https://code.claude.com/docs/en/mcp |

## Ontbreekt in deze ingest

Bij re-ingest in september 2026: check op nieuwe pagina's. Op moment van ingest waren deze relevant maar niet in de set:

- **Routines** — https://code.claude.com/docs/en/routines (gebruikt voor `wiki-librarian` automation)
- **Output styles** — https://code.claude.com/docs/en/output-styles
- **Slash commands** — https://code.claude.com/docs/en/slash-commands
- **Plugins** — https://code.claude.com/docs/en/plugins

Toevoegen aan deze index zodra ingestrueerd via `/ingest-docs https://code.claude.com/docs/en/<topic>`.

## Hoe deze referentie gebruikt wordt

1. **Lazy lookup** vanaf `wiki/index.md` → deze 00-index → max 3 subpagina's
2. **Bij architectuur-vragen** over Claude Code: raadpleeg eerst de lokale samenvatting, val daarna terug op de bron
3. **`wiki-librarian` audits**: monthly check op review-date verstreken → re-ingest-suggestie

## Frontmatter status

⚠️ De ingegestueerde subpagina's (van MK-II 2026-03-26) hebben nog geen verplichte frontmatter. `wiki-librarian` daily audit zal dit flaggen. Wordt opgepakt bij eerste audit-cyclus of bij re-ingest in september.

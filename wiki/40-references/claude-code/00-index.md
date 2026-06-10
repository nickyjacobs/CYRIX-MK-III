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

| Onderwerp | Lokale samenvatting | Bron | Ingest |
|---|---|---|---|
| Overview | [`overview.md`](./overview.md) | https://code.claude.com/docs/en/overview | 2026-03-26 |
| CLI reference | [`cli-reference.md`](./cli-reference.md) | https://code.claude.com/docs/en/cli-usage | 2026-03-26 |
| Skills | [`skills.md`](./skills.md) | https://code.claude.com/docs/en/skills | 2026-03-26 |
| Sub-agents | [`sub-agents.md`](./sub-agents.md) | https://code.claude.com/docs/en/sub-agents | 2026-03-26 |
| Agent teams | [`agent-teams.md`](./agent-teams.md) | https://code.claude.com/docs/en/agent-teams | 2026-03-26 |
| Settings | [`settings.md`](./settings.md) | https://code.claude.com/docs/en/settings | 2026-03-26 |
| Hooks | [`hooks.md`](./hooks.md) | https://code.claude.com/docs/en/hooks | 2026-03-26 |
| Memory | [`memory.md`](./memory.md) | https://code.claude.com/docs/en/memory | 2026-03-26 |
| MCP | [`mcp.md`](./mcp.md) | https://code.claude.com/docs/en/mcp | 2026-03-26 |
| **Routines** | [`routines.md`](./routines.md) | https://code.claude.com/docs/en/routines | **2026-06-09** |
| **Output styles** | [`output-styles.md`](./output-styles.md) | https://code.claude.com/docs/en/output-styles | **2026-06-09** |
| **Slash commands** | [`slash-commands.md`](./slash-commands.md) | https://code.claude.com/docs/en/slash-commands | **2026-06-09** |
| **Plugins** | [`plugins.md`](./plugins.md) | https://code.claude.com/docs/en/plugins | **2026-06-09** |
| **Commands** | [`commands.md`](./commands.md) | https://code.claude.com/docs/en/commands | **2026-06-10** |
| **Agent view** | [`agent-view.md`](./agent-view.md) | https://code.claude.com/docs/en/agent-view | **2026-06-10** |
| **Permissions** | [`permissions.md`](./permissions.md) | https://code.claude.com/docs/en/permissions | **2026-06-10** |
| **Permission modes** | [`permission-modes.md`](./permission-modes.md) | https://code.claude.com/docs/en/permission-modes | **2026-06-10** |
| **Environment variables** | [`env-vars.md`](./env-vars.md) | https://code.claude.com/docs/en/env-vars | **2026-06-10** |
| **Model config** | [`model-config.md`](./model-config.md) | https://code.claude.com/docs/en/model-config | **2026-06-10** |
| **Advisor tool** | [`advisor.md`](./advisor.md) | https://code.claude.com/docs/en/advisor | **2026-06-10** |
| **Channels** | [`channels.md`](./channels.md) | https://code.claude.com/docs/en/channels | **2026-06-10** |
| **Channels reference** | [`channels-reference.md`](./channels-reference.md) | https://code.claude.com/docs/en/channels-reference | **2026-06-10** |
| **Debug your config** | [`debug-your-config.md`](./debug-your-config.md) | https://code.claude.com/docs/en/debug-your-config | **2026-06-10** |

## Belangrijke recente vondsten

- **Custom commands en skills zijn samengevoegd** — files in `.claude/commands/` en `.claude/skills/<naam>/SKILL.md` maken beide een slash-command. Nieuwe code: gebruik skills.
- **Routines** zijn nu in research preview en draaien in Anthropic-cloud (laptop kan uit). Drie trigger-types: schedule, API, GitHub.
- **Bundled skills** (`/run`, `/verify`, `/debug`, `/loop`, `/code-review`) zijn standaard beschikbaar.
- **Plugins** kunnen monitors, LSP servers, en `settings.json` met `agent`-default shippen.

## Nog te ingestren bij re-ingest

September 2026 review-cyclus zal de bestaande 9 maart-pagina's verversen en eventueel nieuwe topics toevoegen die sinds juni 2026 zijn ontstaan.

## Hoe deze referentie gebruikt wordt

1. **Lazy lookup** vanaf `wiki/index.md` → deze 00-index → max 3 subpagina's
2. **Bij architectuur-vragen** over Claude Code: raadpleeg eerst de lokale samenvatting, val daarna terug op de bron
3. **`wiki-librarian` audits**: monthly check op review-date verstreken → re-ingest-suggestie

## Frontmatter status

⚠️ De ingegestueerde subpagina's (van MK-II 2026-03-26) hebben nog geen verplichte frontmatter. `wiki-librarian` daily audit zal dit flaggen. Wordt opgepakt bij eerste audit-cyclus of bij re-ingest in september.

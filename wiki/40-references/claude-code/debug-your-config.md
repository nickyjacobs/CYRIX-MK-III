---
title: "Claude Code: Debug your config"
source-url: https://code.claude.com/docs/en/debug-your-config
ingest-date: 2026-06-10
review-date: 2026-09-10
tags: [reference, claude-code, debugging]
category: 40-references
status: active
---

# Debug your config

> Bron: https://code.claude.com/docs/en/debug-your-config

Als Claude een instructie negeert of een geconfigureerde feature niet verschijnt, is de oorzaak meestal dat het bestand niet laadde, vanaf een andere locatie laadde dan verwacht, of door een ander bestand werd overschreven. Deze gids laat zien hoe je inspecteert wat Claude Code daadwerkelijk laadde.

## Zien wat in context zit

`/context` toont alles in het context window per categorie (system prompt, memory files, skills, MCP-tools, messages). Draai dit eerst. Daarna per categorie:

| Command | Toont |
|---------|-------|
| `/memory` | Welke `CLAUDE.md` en rules-files laadden, plus auto-memory |
| `/skills` | Beschikbare skills (project, user, plugin) |
| `/agents` | Geconfigureerde subagents |
| `/hooks` | Actieve hook-configuraties |
| `/mcp` | Verbonden MCP-servers en status |
| `/permissions` | Resolved allow/deny-regels |
| `/doctor` | Config-diagnostics: invalid keys, schema-errors |
| `/debug [issue]` | Debug-logging aan, Claude diagnosticeert via log |
| `/status` | Actieve settings-bronnen, of managed settings gelden |

Subdirectory `CLAUDE.md`-files laden on-demand wanneer Claude een file in die directory leest met de Read-tool, niet bij sessie-start.

## Resolved settings checken

Settings mergen over managed, user, project, local. Managed wint altijd; daarna wint de dichtere scope (local > project > user). CLI-flags en env vars vormen een extra override-laag. `/doctor` valideert config-files (druk `f` om het rapport naar Claude te sturen). `/status` toont actieve bronnen.

## MCP-servers checken

`/mcp` toont elke server, connectie-status en of je 'm voor dit project goedkeurde. Veelvoorkomend: project-scoped servers in `.mcp.json` vereisen eenmalige approval; relatieve paden in `command`/`args` resolven tegen de launch-directory; een verbonden server met 0 tools: kies Reconnect of draai `claude --debug mcp`.

## Hooks checken

`/hooks` toont elke geregistreerde hook per event. Verschijnt 'ie niet, dan wordt 'ie niet gelezen (hooks horen onder de `"hooks"`-key in settings, niet in een los bestand). Vuurt 'ie niet, dan is de `matcher` meestal de boosdoener: één string met `|` (`"Edit|Write"`), case-sensitive, een array is een schema-error. `claude --debug hooks` toont evaluatie live.

## Schone config testen

- `claude --safe-mode` (v2.1.169+): sessie met alle customizations uit (CLAUDE.md, skills, plugins, hooks, MCP, custom commands/agents). Auth, model, built-in tools en permissies werken normaal. Managed settings gelden deels nog.
- Volledig schoon: `cd /tmp && CLAUDE_CONFIG_DIR=/tmp/claude-clean claude` vanuit een directory zonder `.claude`/`.mcp.json`/`CLAUDE.md`.

## Veelvoorkomende oorzaken (selectie)

| Symptoom | Oorzaak |
|----------|---------|
| Hook vuurt nooit | `matcher` is array i.p.v. string, of lowercase (`"bash"` i.p.v. `Bash`) |
| Globaal gezette permissions/hooks/env genegeerd | Toegevoegd aan `~/.claude.json` i.p.v. `~/.claude/settings.json` |
| `settings.json`-waarde genegeerd | Zelfde key in `settings.local.json` (overschrijft) |
| Skill niet in `/skills` | File op `.claude/skills/name.md` i.p.v. `.claude/skills/name/SKILL.md` |
| Skill verschijnt maar Claude roept niet aan | `disable-model-invocation: true`, of description matcht niet |
| MCP in `.mcp.json` laadt nooit | File onder `.claude/` of Claude Desktop-format; hoort in repo-root |
| MCP-server mist env vars | Vars in `settings.json` `env` propageren niet naar MCP-child; zet per-server `env` in `.mcp.json` |
| `Bash(rm *)` deny blokkeert `/bin/rm` niet | Prefix-regels matchen de literale string, niet de executable |

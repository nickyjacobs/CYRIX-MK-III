---
title: Claude Code — Plugins
source-url: https://code.claude.com/docs/en/plugins
ingest-date: 2026-06-09
review-date: 2026-09-09
tags: [reference, claude-code, plugins, distribution]
category: 40-references
status: active
---

# Claude Code — Plugins

> Bron: https://code.claude.com/docs/en/plugins

Plugins bundelen skills, agents, hooks, MCP servers, LSP servers en background monitors in één installeerbaar pakket. Onderscheidend van standalone `.claude/`-configuratie: plugins zijn ge-namespaced (`/plugin-name:skill`), versie-beheerd, en distribueerbaar via marketplaces.

## Wanneer plugin vs standalone

| Aanpak | Skill-namen | Beste voor |
|---|---|---|
| **Standalone** (`.claude/`) | `/hello` | Persoonlijk, project-specifiek, experimenten |
| **Plugin** | `/plugin-name:hello` | Team-sharing, distributie, versioning, multi-project |

Tip: start in `.claude/` voor snelle iteratie, converteer naar plugin als je deelt.

## Plugin structuur

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json          # manifest (name, description, version, author)
├── skills/<naam>/SKILL.md   # skills (model-invoked)
├── commands/                # legacy custom commands (flat .md files)
├── agents/                  # custom subagents
├── hooks/hooks.json         # event handlers
├── .mcp.json                # MCP server configs
├── .lsp.json                # LSP server configs
├── monitors/monitors.json   # background monitors
├── bin/                     # executables (toegevoegd aan PATH)
├── settings.json            # default settings als plugin actief is
└── README.md                # documentatie
```

**Belangrijk:** alleen `plugin.json` zit in `.claude-plugin/`. Andere directories op plugin-root.

## Manifest minimum

```json
{
  "name": "my-plugin",
  "description": "Wat het doet",
  "version": "1.0.0",
  "author": { "name": "Your Name" }
}
```

## Testen tijdens development

```bash
claude --plugin-dir ./my-plugin              # lokale directory
claude --plugin-dir ./my-plugin.zip          # zip archive (v2.1.128+)
claude --plugin-url https://.../plugin.zip   # remote URL
```

Meerdere plugins parallel: herhaal de flag.

Na changes: `/reload-plugins` om bij te werken zonder restart.

## Skills-directory plugins (auto-load)

Plaats een plugin in `~/.claude/skills/<naam>/` met manifest in `.claude-plugin/plugin.json` — wordt automatisch geladen als `<naam>@skills-dir`. Geen marketplace nodig.

Scaffolden: `claude plugin init my-tool`.

## Marketplaces

Twee publieke:

- **claude-plugins-official** — Anthropic-curated, automatisch beschikbaar
- **claude-community** — third-party submissions na review (`/plugin marketplace add anthropics/claude-plugins-community`)

Privé marketplaces via private GitHub repos kunnen.

Submission flows:
- claude.ai/settings/plugins/submit
- platform.claude.com/plugins/submit

Voor submission: lokaal `claude plugin validate` draaien.

## Settings.json in plugin

Plugin kan default settings shippen. Currently ondersteund:

- `agent` — activeer een plugin-agent als main thread (custom system prompt, tools, model)
- `subagentStatusLine` — status line voor sub-agents

## Convert .claude/ → plugin

1. Maak `my-plugin/.claude-plugin/plugin.json`
2. Kopieer `.claude/commands/`, `.claude/agents/`, `.claude/skills/` naar plugin-root
3. Hooks van `.claude/settings.json` → `my-plugin/hooks/hooks.json` (zelfde format)
4. Test met `--plugin-dir`

## CYRIX MK-III roadmap

**Fase 3** (maand 2+): CYRIX-skills publiceren als lokale plugin zodat externe workspaces (Pentest/TryHackMe/homelab) ze kunnen installeren. Dat realiseert het "shared skills"-doel uit het MK-III plan.

Voor nu: standalone `.claude/skills/` is goed genoeg.

## Gerelateerd

- [Skills](./skills.md) — basis voor plugin-functionaliteit
- [Sub-agents](./sub-agents.md) — agent configuratie
- [Hooks](./hooks.md) — event handling
- [MCP](./mcp.md) — external tool integration

---
title: "Claude Code: Commands"
source-url: https://code.claude.com/docs/en/commands
ingest-date: 2026-06-10
review-date: 2026-09-10
tags: [reference, claude-code, commands]
category: 40-references
status: active
---

# Commands

> Bron: https://code.claude.com/docs/en/commands

Commands sturen Claude Code aan vanuit een sessie. Type `/` om alle beschikbare commands te zien, of `/` plus letters om te filteren. Een command wordt alleen herkend aan het begin van je bericht. Tekst erachter wordt als argument doorgegeven.

Twee soorten zijn gemarkeerd: **Skill** (bundled skill, prompt aan Claude, kan automatisch geactiveerd worden) en **Workflow** (bundled dynamic workflow die werk over subagents uitwaaiert).

## Commands per workflow-fase

| Fase | Commands |
|------|----------|
| Eerste sessie in repo | `/init`, `/memory`, `/mcp`, `/agents`, `/permissions` |
| Tijdens een taak | `/plan`, `/model`, `/effort`, `/context`, `/compact`, `/btw` |
| Parallel werk | `/agents`, `/tasks`, `/background`, `/batch` |
| Voor je ship | `/diff`, `/code-review`, `/review`, `/security-review` |
| Tussen sessies | `/clear`, `/resume`, `/branch`, `/teleport`, `/remote-control` |
| Als iets misgaat | `/rewind`, `/doctor`, `/debug`, `/feedback` |

## Veelgebruikte commands

| Command | Doel |
|---------|------|
| `/add-dir <path>` | Werkdirectory toevoegen voor file-toegang |
| `/advisor [model\|off]` | Advisor-tool aan/uit (`opus`, `sonnet`, `fable`, of model-ID) |
| `/agents` | Subagent-configuraties beheren |
| `/background [prompt]` | Sessie detachen als background agent. Alias `/bg` |
| `/batch <instruction>` | **Skill.** Grootschalige wijziging over codebase, 5 tot 30 units in eigen worktree |
| `/branch [name]` | Conversatie forken op dit punt |
| `/btw <question>` | Side-vraag zonder de conversatie te vervuilen |
| `/cd <path>` | Sessie verplaatsen naar nieuwe werkdirectory (v2.1.169+) |
| `/clear [name]` | Nieuwe conversatie, lege context. Aliassen `/reset`, `/new` |
| `/code-review [...]` | **Skill.** Diff-review op bugs en cleanups. `--fix`, `--comment`, `ultra` |
| `/compact [instructions]` | Context opschonen via samenvatting |
| `/config` | Settings-interface. Alias `/settings` |
| `/context [all]` | Context-gebruik visualiseren |
| `/debug [description]` | **Skill.** Debug-logging aan en troubleshooten |
| `/deep-research <question>` | **Workflow.** Web-searches fan-out, sources cross-checken, geciteerd rapport |
| `/diff` | Interactieve diff-viewer |
| `/doctor` | Installatie en settings diagnosticeren |
| `/effort [level\|auto]` | Effort level: `low`, `medium`, `high`, `xhigh`, `max`, `ultracode` |
| `/fork <directive>` | Forked subagent die volledige conversatie erft (v2.1.161+) |
| `/goal [condition\|clear]` | Goal zetten: Claude werkt door tot conditie gehaald |
| `/hooks` | Hook-configuraties bekijken |
| `/init` | Project initialiseren met `CLAUDE.md` |
| `/mcp [...]` | MCP-servers en OAuth beheren |
| `/memory` | `CLAUDE.md` bewerken, auto-memory aan/uit |
| `/model [model]` | Model wisselen en als default opslaan |
| `/permissions` | Allow/ask/deny-regels beheren. Alias `/allowed-tools` |
| `/plan [description]` | Plan mode in vanaf de prompt |
| `/plugin [subcommand]` | Plugins beheren (`list`, `install`, `enable`, `disable`) |
| `/reload-skills` | Skills/commands opnieuw scannen (v2.1.152+) |
| `/resume [session]` | Conversatie hervatten. Alias `/continue` |
| `/rewind` | Conversatie en/of code terugdraaien. Aliassen `/checkpoint`, `/undo` |
| `/run` | **Skill.** App starten en bedienen (v2.1.145+) |
| `/sandbox` | Sandbox mode togglen |
| `/schedule [description]` | Routines aanmaken/beheren. Alias `/routines` |
| `/security-review` | Pending changes op security-kwetsbaarheden analyseren |
| `/simplify [target]` | **Skill.** Cleanup-only review met fixes (v2.1.154+) |
| `/skills` | Beschikbare skills tonen |
| `/status` | Settings (Status-tab): versie, model, account |
| `/usage` | Sessiekosten en plan-limieten. Aliassen `/cost`, `/stats` |
| `/verify` | **Skill.** Wijziging verifiëren door app te draaien (v2.1.145+) |
| `/workflows` | Workflow-voortgang volgen |

## MCP prompts

MCP-servers kunnen prompts blootstellen als commands met format `/mcp__<server>__<prompt>`. Dynamisch ontdekt van verbonden servers.

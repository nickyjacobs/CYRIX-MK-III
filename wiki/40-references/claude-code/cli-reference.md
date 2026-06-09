---
title: Claude Code — CLI Reference
source-url: https://code.claude.com/docs/en/cli-usage
ingest-date: 2026-03-26
review-date: 2026-09-09
tags: [reference, claude-code]
category: 40-references
status: active
---

# CLI Reference

> Bron: https://code.claude.com/docs/en/cli-usage

## Commands

| Command | Beschrijving | Voorbeeld |
|---------|-------------|-----------|
| `claude` | Start interactieve sessie | `claude` |
| `claude "query"` | Start sessie met initieel prompt | `claude "explain this project"` |
| `claude -p "query"` | Query via SDK, dan exit | `claude -p "explain this function"` |
| `cat file \| claude -p "query"` | Piped content verwerken | `cat logs.txt \| claude -p "explain"` |
| `claude -c` | Meest recente conversatie hervatten | `claude -c` |
| `claude -c -p "query"` | Hervatten via SDK | `claude -c -p "Check for type errors"` |
| `claude -r "<session>" "query"` | Sessie hervatten op ID of naam | `claude -r "auth-refactor" "Finish this PR"` |
| `claude update` | Update naar laatste versie | `claude update` |
| `claude auth login` | Inloggen (opties: `--email`, `--sso`, `--console`) | `claude auth login --console` |
| `claude auth logout` | Uitloggen | `claude auth logout` |
| `claude auth status` | Authenticatiestatus tonen | `claude auth status` |
| `claude agents` | Alle geconfigureerde subagents tonen | `claude agents` |
| `claude auto-mode defaults` | Built-in auto mode classifier rules tonen | `claude auto-mode defaults > rules.json` |
| `claude mcp` | MCP servers configureren | Zie MCP docs |
| `claude plugin` | Plugins beheren | `claude plugin install code-review@claude-plugins-official` |
| `claude remote-control` | Remote Control server starten | `claude remote-control --name "My Project"` |

## Belangrijkste flags

### Sessie & input

| Flag | Beschrijving |
|------|-------------|
| `--continue`, `-c` | Meest recente conversatie laden |
| `--resume`, `-r` | Specifieke sessie hervatten op ID of naam |
| `--name`, `-n` | Display naam voor sessie instellen |
| `--fork-session` | Nieuwe sessie-ID bij hervatten |
| `--from-pr` | Sessies gekoppeld aan een PR hervatten |
| `--print`, `-p` | Print modus (geen interactief) |
| `--add-dir` | Extra working directories toevoegen |

### Model & effort

| Flag | Beschrijving |
|------|-------------|
| `--model` | Model instellen (`sonnet`, `opus`, of full ID) |
| `--effort` | Effort level: `low`, `medium`, `high`, `max` (Opus only) |
| `--fallback-model` | Fallback model bij overload (print mode) |

### Permissies

| Flag | Beschrijving |
|------|-------------|
| `--permission-mode` | Permissie modus (`default`, `plan`, `acceptEdits`, `auto`) |
| `--enable-auto-mode` | Auto mode unlocken in Shift+Tab cyclus |
| `--dangerously-skip-permissions` | Permissie prompts overslaan (voorzichtig!) |
| `--allowedTools` | Tools die zonder prompt mogen draaien |
| `--disallowedTools` | Tools die niet beschikbaar zijn |
| `--tools` | Restricteren welke built-in tools beschikbaar zijn |

### System prompt

| Flag | Gedrag |
|------|--------|
| `--system-prompt` | Vervangt volledig default prompt |
| `--system-prompt-file` | Vervangt met bestandsinhoud |
| `--append-system-prompt` | Voegt toe aan default prompt |
| `--append-system-prompt-file` | Voegt bestandsinhoud toe |

### Agent & subagents

| Flag | Beschrijving |
|------|-------------|
| `--agent` | Subagent specificeren voor de sessie |
| `--agents` | Custom subagents dynamisch definieren via JSON |
| `--teammate-mode` | Agent team display: `auto`, `in-process`, `tmux` |

### Output & format

| Flag | Beschrijving |
|------|-------------|
| `--output-format` | Output format: `text`, `json`, `stream-json` |
| `--input-format` | Input format: `text`, `stream-json` |
| `--json-schema` | Gevalideerde JSON output matching een schema |
| `--verbose` | Verbose logging |

### Overig

| Flag | Beschrijving |
|------|-------------|
| `--bare` | Minimale modus (skip hooks, skills, plugins, MCP, etc.) |
| `--mcp-config` | MCP servers laden uit JSON bestanden |
| `--strict-mcp-config` | Alleen MCP servers uit --mcp-config gebruiken |
| `--chrome` / `--no-chrome` | Chrome browser integratie aan/uit |
| `--worktree`, `-w` | Start in een geisoleerde git worktree |
| `--remote` | Web sessie op claude.ai aanmaken |
| `--remote-control`, `--rc` | Interactieve sessie met Remote Control |
| `--teleport` | Web sessie hervatten in lokale terminal |
| `--max-turns` | Limiet aantal agentic turns (print mode) |
| `--max-budget-usd` | Maximum budget voor API calls (print mode) |
| `--debug` | Debug modus met optionele categorie filtering |
| `--version`, `-v` | Versienummer tonen |

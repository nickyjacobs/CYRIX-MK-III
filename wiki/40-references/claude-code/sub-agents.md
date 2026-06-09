---
title: Claude Code — Sub-agents
source-url: https://code.claude.com/docs/en/sub-agents
ingest-date: 2026-03-26
review-date: 2026-09-09
tags: [reference, claude-code]
category: 40-references
status: active
---

# Subagents

> Bron: https://code.claude.com/docs/en/sub-agents

Subagents zijn gespecialiseerde AI assistenten die specifieke taken afhandelen. Elke subagent draait in eigen context window met custom system prompt, specifieke tool access en onafhankelijke permissies.

## Built-in subagents

| Agent | Model | Tools | Doel |
|-------|-------|-------|------|
| **Explore** | Haiku (snel) | Read-only | File discovery, code search, codebase exploratie |
| **Plan** | Inherit | Read-only | Codebase research voor planning |
| **General-purpose** | Inherit | Alle tools | Complexe multi-step taken |
| **Bash** | Inherit | Terminal | Commands in aparte context |
| **Claude Code Guide** | Haiku | - | Vragen over Claude Code features |
| **statusline-setup** | Sonnet | - | Statusline configuratie |

## Locaties en scope

| Locatie | Scope | Prioriteit |
|---------|-------|-----------|
| `--agents` CLI flag | Huidige sessie | 1 (hoogst) |
| `.claude/agents/` | Huidig project | 2 |
| `~/.claude/agents/` | Al je projecten | 3 |
| Plugin `agents/` directory | Waar plugin enabled is | 4 (laagst) |

## Subagent bestand

```markdown
---
name: code-reviewer
description: Reviews code for quality and best practices
tools: Read, Glob, Grep
model: sonnet
permissionMode: default
maxTurns: 10
---

Je bent een code reviewer. Analyseer code en geef specifieke,
actionable feedback over kwaliteit, security en best practices.
```

## Frontmatter velden

| Veld | Verplicht | Beschrijving |
|------|-----------|-------------|
| `name` | Ja | Unieke identifier (lowercase, hyphens) |
| `description` | Ja | Wanneer Claude moet delegeren naar deze subagent |
| `tools` | Nee | Beschikbare tools (inherit all als weggelaten) |
| `disallowedTools` | Nee | Tools om te denyen |
| `model` | Nee | `sonnet`, `opus`, `haiku`, full ID, of `inherit` |
| `permissionMode` | Nee | `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, `plan` |
| `maxTurns` | Nee | Maximum agentic turns |
| `skills` | Nee | Skills om vooraf in context te laden |
| `mcpServers` | Nee | MCP servers beschikbaar voor deze subagent |
| `hooks` | Nee | Lifecycle hooks scoped aan deze subagent |
| `memory` | Nee | Persistent memory scope: `user`, `project`, `local` |
| `background` | Nee | `true` = altijd als background task draaien |
| `effort` | Nee | Effort level: `low`, `medium`, `high`, `max` |
| `isolation` | Nee | `worktree` = draai in tijdelijke git worktree |
| `initialPrompt` | Nee | Auto-submitted als eerste user turn bij `--agent` |

## Model resolutie volgorde

1. `CLAUDE_CODE_SUBAGENT_MODEL` env var
2. Per-invocatie `model` parameter
3. Subagent definitie's `model` frontmatter
4. Main conversation's model

## Subagents aanroepen

### Automatisch
Claude delegeert automatisch op basis van de `description`.

### Natural language
```
Use the test-runner subagent to fix failing tests
```

### @-mention
```
@"code-reviewer (agent)" look at the auth changes
```

### Session-wide (hele sessie als subagent)
```bash
claude --agent code-reviewer
```

Of via settings:
```json
{ "agent": "code-reviewer" }
```

## Foreground vs background

- **Foreground**: blokkeert main conversatie, permissie prompts worden doorgestuurd
- **Background**: draait concurrent, permissies worden vooraf gevraagd, auto-deny voor niet-goedgekeurde tools

Tip: druk **Ctrl+B** om een draaiende taak naar de achtergrond te verplaatsen.

## MCP servers scopen aan subagent

```yaml
---
name: browser-tester
mcpServers:
  - playwright:
      type: stdio
      command: npx
      args: ["-y", "@playwright/mcp@latest"]
  - github  # referentie naar al geconfigureerde server
---
```

## Persistent memory

```yaml
---
name: code-reviewer
memory: user
---
```

| Scope | Locatie | Gebruik |
|-------|---------|---------|
| `user` | `~/.claude/agent-memory/<name>/` | Kennis over alle projecten |
| `project` | `.claude/agent-memory/<name>/` | Projectspecifiek, deelbaar via VCS |
| `local` | `.claude/agent-memory-local/<name>/` | Projectspecifiek, niet in VCS |

## Skills preloaden in subagents

```yaml
---
name: api-developer
skills:
  - api-conventions
  - error-handling-patterns
---

Implementeer API endpoints volgens de preloaded skills.
```

## CLI-defined subagents

```bash
claude --agents '{
  "code-reviewer": {
    "description": "Expert code reviewer",
    "prompt": "You are a senior code reviewer.",
    "tools": ["Read", "Grep", "Glob", "Bash"],
    "model": "sonnet"
  }
}'
```

## Subagents disablen

Via settings deny rules:
```json
{
  "permissions": {
    "deny": ["Agent(Explore)", "Agent(my-custom-agent)"]
  }
}
```

Of via CLI:
```bash
claude --disallowedTools "Agent(Explore)"
```

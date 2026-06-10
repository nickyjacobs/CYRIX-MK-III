---
title: "Claude Code: Hooks"
source-url: https://code.claude.com/docs/en/hooks
ingest-date: 2026-06-10
review-date: 2026-09-10
tags: [reference, claude-code, hooks]
category: 40-references
status: active
---

# Hooks

> Bron: https://code.claude.com/docs/en/hooks

Hooks zijn user-defined shell commands, HTTP endpoints, LLM prompts of agents die automatisch uitvoeren op specifieke momenten in Claude Code's lifecycle.

## Locaties

| Locatie | Scope |
|---------|-------|
| `~/.claude/settings.json` | Alle projecten |
| `.claude/settings.json` | Project (gedeeld) |
| `.claude/settings.local.json` | Project (lokaal) |
| Managed policy settings | Organisatie-breed |
| Plugin `hooks/hooks.json` | Waar plugin enabled is |
| Skill/agent frontmatter | Terwijl component actief is |

## Hook events

### Session lifecycle

| Event | Wanneer | Kan blokkeren? |
|-------|---------|---------------|
| `SessionStart` | Sessie begint of hervat | Nee |
| `SessionEnd` | Sessie eindigt | Nee |
| `UserPromptSubmit` | Prompt wordt ingediend | Ja |
| `Stop` | Claude stopt met antwoorden | Ja |
| `StopFailure` | Turn eindigt door API error | Nee |

### Tool lifecycle

| Event | Wanneer | Kan blokkeren? |
|-------|---------|---------------|
| `PreToolUse` | Voor tool call uitvoert | Ja |
| `PermissionRequest` | Permissie dialog verschijnt | Ja |
| `PostToolUse` | Na succesvolle tool call | Nee (kan context toevoegen) |
| `PostToolUseFailure` | Na gefaalde tool call | Nee |

### Agent lifecycle

| Event | Wanneer | Kan blokkeren? |
|-------|---------|---------------|
| `SubagentStart` | Subagent wordt gespawned | Nee (kan context injecteren) |
| `SubagentStop` | Subagent is klaar | Ja |
| `TeammateIdle` | Teammate wordt idle | Ja |
| `TaskCompleted` | Taak wordt voltooid gemarkeerd | Ja |

### Overig

| Event | Wanneer | Kan blokkeren? |
|-------|---------|---------------|
| `Notification` | Notificatie wordt verzonden | Nee |
| `ConfigChange` | Config bestand wijzigt | Ja |
| `CwdChanged` | Working directory wijzigt | Nee |
| `FileChanged` | Watched file wijzigt | Nee |
| `PreCompact` / `PostCompact` | Voor/na context compaction | Nee |
| `WorktreeCreate` / `WorktreeRemove` | Worktree aangemaakt/verwijderd | Create: Ja |
| `InstructionsLoaded` | CLAUDE.md of rules bestand geladen | Nee |
| `Elicitation` / `ElicitationResult` | MCP server vraagt user input | Ja |

## Configuratie structuur

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/block-rm.sh"
          }
        ]
      }
    ]
  }
}
```

## Hook handler types

### Command hook

```json
{
  "type": "command",
  "command": "path/to/script.sh",
  "async": false,
  "shell": "bash",
  "timeout": 30
}
```

### HTTP hook

```json
{
  "type": "http",
  "url": "http://localhost:8080/hooks/pre-tool-use",
  "headers": { "Authorization": "Bearer $MY_TOKEN" },
  "allowedEnvVars": ["MY_TOKEN"],
  "timeout": 30
}
```

### Prompt hook

```json
{
  "type": "prompt",
  "prompt": "Should this command be allowed? $ARGUMENTS",
  "model": "claude-opus-4-1",
  "timeout": 30
}
```

### Agent hook

```json
{
  "type": "agent",
  "prompt": "Verify that the build passes. $ARGUMENTS",
  "model": "claude-opus-4-1",
  "timeout": 60
}
```

## Common fields (alle types)

| Veld | Verplicht | Beschrijving |
|------|-----------|-------------|
| `type` | Ja | `command`, `http`, `prompt`, `agent` |
| `timeout` | Nee | Seconden (defaults: 600/30/60) |
| `statusMessage` | Nee | Custom spinner bericht |
| `once` | Nee | `true` = draai eenmalig per sessie (skills only) |

## Exit codes

| Exit code | Betekenis |
|-----------|-----------|
| `0` | Succes, stdout wordt geparsed voor JSON |
| `2` | Blokkerende error, stderr naar Claude |
| Overig | Niet-blokkerende error, doorgaan |

## Matcher patronen

Regex string die filtert wanneer hooks vuren:

| Event | Match op | Voorbeeld |
|-------|----------|-----------|
| `PreToolUse` etc. | Tool naam | `Bash`, `Edit\|Write`, `mcp__.*` |
| `SessionStart` | Start type | `startup`, `resume`, `clear` |
| `SubagentStart/Stop` | Agent type | `Explore`, `Plan`, custom namen |
| `ConfigChange` | Config source | `user_settings`, `project_settings` |
| `FileChanged` | Bestandsnaam | `.envrc`, `.env` |

## Environment variables in hooks

| Variabele | Beschrijving |
|-----------|-------------|
| `$CLAUDE_PROJECT_DIR` | Project root |
| `${CLAUDE_PLUGIN_ROOT}` | Plugin installatiemap |
| `${CLAUDE_PLUGIN_DATA}` | Plugin data map |
| `$CLAUDE_ENV_FILE` | Bestand voor env var persistentie (SessionStart, CwdChanged, FileChanged) |

## Voorbeeld: destructieve commands blokkeren

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          { "type": "command", "command": ".claude/hooks/block-rm.sh" }
        ]
      }
    ]
  }
}
```

```bash
#!/bin/bash
COMMAND=$(jq -r '.tool_input.command')
if echo "$COMMAND" | grep -q 'rm -rf'; then
  jq -n '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: "Destructive command blocked"
    }
  }'
else
  exit 0
fi
```

## Voorbeeld: auto-format na file edit

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          { "type": "command", "command": "./scripts/run-linter.sh" }
        ]
      }
    ]
  }
}
```

## Update 2026-06-10 (docs-drift)

Nieuw of gewijzigd ten opzichte van de maart-ingest:

- **Extra events:** `Setup`, `UserPromptExpansion`, `PostToolBatch`, `PermissionDenied`, `SubagentStart`, `TaskCreated`, `MessageDisplay` (de volledige lijst telt nu circa 28 events).
- **Extra hook-type:** `mcp_tool` (roept een tool op een verbonden MCP-server aan), naast command, http, prompt en agent.
- **Async hooks:** `"async": true` draait op de achtergrond zonder te blokkeren; `"asyncRewake": true` wekt Claude bij exit 2.
- **`disableAllHooks`-setting** en een read-only **`/hooks`-menu** om alle geconfigureerde hooks te inspecteren.
- **Exec-form vs shell-form:** met `args` een directe spawn (geen shell, veilig voor spaties); zonder `args` via `sh -c`.
- **`sessionTitle`** in SessionStart-output voor auto-naming; `additionalContext` injecteert tot 10k tekens context.

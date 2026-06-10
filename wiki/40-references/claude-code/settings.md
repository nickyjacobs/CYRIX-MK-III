---
title: "Claude Code: Settings"
source-url: https://code.claude.com/docs/en/settings
ingest-date: 2026-06-10
review-date: 2026-09-10
tags: [reference, claude-code, settings]
category: 40-references
status: active
---

# Settings

> Bron: https://code.claude.com/docs/en/settings

## Configuration scopes

| Scope | Locatie | Wie | Gedeeld? |
|-------|---------|-----|----------|
| **Managed** | Server/plist/registry/managed-settings.json | Alle users op machine | Ja (IT) |
| **User** | `~/.claude/` | Jij, alle projecten | Nee |
| **Project** | `.claude/` in repository | Alle collaborators | Ja (git) |
| **Local** | `.claude/settings.local.json` | Jij, alleen dit project | Nee (gitignored) |

### Prioriteit (hoog naar laag)

1. Managed (kan niet overschreven worden)
2. Command line arguments
3. Local
4. Project
5. User

## Settings bestanden

| Feature | User | Project | Local |
|---------|------|---------|-------|
| **Settings** | `~/.claude/settings.json` | `.claude/settings.json` | `.claude/settings.local.json` |
| **Subagents** | `~/.claude/agents/` | `.claude/agents/` | - |
| **MCP servers** | `~/.claude.json` | `.mcp.json` | `~/.claude.json` (per-project) |
| **Plugins** | `~/.claude/settings.json` | `.claude/settings.json` | `.claude/settings.local.json` |
| **CLAUDE.md** | `~/.claude/CLAUDE.md` | `CLAUDE.md` of `.claude/CLAUDE.md` | - |

## Voorbeeld settings.json

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "allow": [
      "Bash(npm run lint)",
      "Bash(npm run test *)",
      "Read(~/.zshrc)"
    ],
    "deny": [
      "Bash(curl *)",
      "Read(./.env)",
      "Read(./.env.*)"
    ]
  },
  "env": {
    "CLAUDE_CODE_ENABLE_TELEMETRY": "1"
  }
}
```

## Belangrijkste settings

### Basis

| Key | Beschrijving |
|-----|-------------|
| `model` | Default model overschrijven |
| `availableModels` | Welke modellen selecteerbaar zijn |
| `effortLevel` | Effort level: `low`, `medium`, `high` |
| `agent` | Main thread als named subagent draaien |
| `outputStyle` | Output stijl aanpassen |

### Permissies

| Key | Beschrijving |
|-----|-------------|
| `permissions.allow` | Tools die zonder prompt mogen draaien |
| `permissions.deny` | Tools die geblokkeerd zijn |
| `autoMode` | Auto mode classifier configureren |
| `disableAutoMode` | `"disable"` om auto mode te blokkeren |

### Hooks & automatisering

| Key | Beschrijving |
|-----|-------------|
| `hooks` | Custom commands bij lifecycle events |
| `disableAllHooks` | Alle hooks uitschakelen |
| `statusLine` | Custom status line configureren |

### MCP

| Key | Beschrijving |
|-----|-------------|
| `enableAllProjectMcpServers` | Alle project MCP servers auto-goedkeuren |
| `enabledMcpjsonServers` | Specifieke MCP servers goedkeuren |
| `disabledMcpjsonServers` | Specifieke MCP servers afwijzen |

### Sessie & opslag

| Key | Beschrijving |
|-----|-------------|
| `cleanupPeriodDays` | Inactieve sessies verwijderen (default: 30 dagen) |
| `autoMemoryDirectory` | Custom directory voor auto memory |

### Git & attributie

| Key | Beschrijving |
|-----|-------------|
| `attribution` | Attributie voor commits en PRs customizen |
| `includeGitInstructions` | Built-in git instructies in/uitschakelen |

### Auth

| Key | Beschrijving |
|-----|-------------|
| `forceLoginMethod` | `claudeai` of `console` |
| `forceLoginOrgUUID` | Organisatie UUID auto-selecteren |
| `apiKeyHelper` | Custom script voor API key generatie |

### Overig

| Key | Beschrijving |
|-----|-------------|
| `env` | Environment variables voor elke sessie |
| `companyAnnouncements` | Bericht bij startup |
| `respectGitignore` | Of `@` file picker .gitignore respecteert |
| `defaultShell` | Default shell: `bash` of `powershell` |
| `teammateMode` | Agent team display: `auto`, `in-process`, `tmux` |

## Permission rule syntax

Regels gebruiken tool naam + optioneel patroon:

```
Bash(npm run lint)      # Exact match
Bash(npm run test *)    # Wildcard
Read(~/.zshrc)          # Specifiek bestand
Read(./.env.*)          # Glob patroon
Agent(Explore)          # Specifieke subagent
Skill(commit)           # Specifieke skill
Skill(review-pr *)      # Skill met prefix match
```

## Update 2026-06-10 (docs-drift)

Nieuw of gewijzigd ten opzichte van de maart-ingest:

- **`includeCoAuthoredBy` is deprecated**, gebruik `attribution` (relevant voor de no-Co-Authored-By commit-policy).
- **Managed (admin) keys:** `policyHelper` (v2.1.136+, dynamische managed settings), `parentSettingsBehavior` (v2.1.133+), `requiredMinimumVersion`/`requiredMaximumVersion`, `allowedMcpServers`/`deniedMcpServers`, `strictKnownMarketplaces`.
- **Nieuw:** `disableRemoteControl` (v2.1.128+), `disableAgentView`, `autoMemoryEnabled`, `autoUpdatesChannel` (`stable`/`latest`), `minimumVersion`.
- **Skills:** `skillOverrides` (`on`/`name-only`/`user-invocable-only`/`off`), `disableBundledSkills`, `disableWorkflows`, `maxSkillDescriptionChars`.
- Precedentie bevestigd: Managed > CLI-args > Local > Project > User. Permission-rules mergen over scopes in plaats van overschrijven.

# MCP Servers (Model Context Protocol)

> Bron: https://code.claude.com/docs/en/mcp

MCP is een open standaard voor het verbinden van AI tools met externe databronnen. Met MCP kan Claude Code design docs lezen, tickets updaten, data ophalen uit Slack, of custom tooling gebruiken.

## Configuratie locaties

| Scope | Bestand | Wie |
|-------|---------|-----|
| Project | `.mcp.json` (project root) | Team (via git) |
| User | `~/.claude.json` | Jij, alle projecten |
| Managed | `managed-mcp.json` (systeemmap) | Organisatie |
| Subagent | `mcpServers` frontmatter | Per subagent |
| CLI | `--mcp-config ./mcp.json` | Per sessie |

## .mcp.json formaat

```json
{
  "mcpServers": {
    "server-naam": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem"],
      "env": {
        "KEY": "value"
      }
    }
  }
}
```

## Transport types

| Type | Beschrijving |
|------|-------------|
| `stdio` | Lokaal process via stdin/stdout |
| `sse` | Server-Sent Events (HTTP) |
| `http` | HTTP streaming |
| `ws` | WebSocket |

## MCP server configureren

### Via CLI

```bash
claude mcp add <naam> -- <command> [args...]
claude mcp add github -- npx -y @modelcontextprotocol/server-github
```

### Via .mcp.json (handmatig)

```json
{
  "mcpServers": {
    "github": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "<token>"
      }
    }
  }
}
```

## MCP beheer commands

| Command | Beschrijving |
|---------|-------------|
| `claude mcp add <naam>` | Server toevoegen |
| `claude mcp remove <naam>` | Server verwijderen |
| `claude mcp list` | Alle servers tonen |

### Scopes bij add

```bash
claude mcp add --scope user <naam> -- <command>     # User scope
claude mcp add --scope project <naam> -- <command>   # Project scope
```

## MCP tools in permissies

MCP tools volgen het patroon `mcp__<server>__<tool>`:

```json
{
  "permissions": {
    "allow": ["mcp__github__create_pull_request"],
    "deny": ["mcp__filesystem__write_file"]
  }
}
```

## MCP servers scopen aan subagents

```yaml
---
name: browser-tester
mcpServers:
  - playwright:
      type: stdio
      command: npx
      args: ["-y", "@playwright/mcp@latest"]
  - github  # referentie naar bestaande server
---
```

Inline servers worden geconnect bij subagent start en gedisconnect bij finish.

## Settings voor MCP

| Setting | Beschrijving |
|---------|-------------|
| `enableAllProjectMcpServers` | Alle project MCP servers auto-goedkeuren |
| `enabledMcpjsonServers` | Lijst van goedgekeurde servers |
| `disabledMcpjsonServers` | Lijst van afgewezen servers |
| `allowedMcpServers` | (Managed) Allowlist van servers |
| `deniedMcpServers` | (Managed) Denylist van servers |
| `allowManagedMcpServersOnly` | (Managed) Alleen admin-defined servers |

## Tips

- Gebruik `--strict-mcp-config` om alleen servers uit `--mcp-config` te laden
- MCP tools beschrijvingen nemen context space in; definieer servers inline in subagent `mcpServers` als je ze uit de main conversation wilt houden
- Test MCP servers met `claude mcp list` om connectiviteit te verifieren

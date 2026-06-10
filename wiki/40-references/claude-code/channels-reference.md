---
title: "Claude Code: Channels reference"
source-url: https://code.claude.com/docs/en/channels-reference
ingest-date: 2026-06-10
review-date: 2026-09-10
tags: [reference, claude-code, channels]
category: 40-references
status: active
---

# Channels reference

> Bron: https://code.claude.com/docs/en/channels-reference

Bouw een MCP-server die webhooks, alerts en chat-berichten in een Claude Code sessie pusht. Deze pagina beschrijft het channel-contract: capability-declaratie, notification-events, reply-tools, sender-gating en permission relay.

Research preview, vereist Claude Code v2.1.80+.

## Architectuur

Een channel is een MCP-server die op dezelfde machine als Claude Code draait. Claude Code spawnt 'm als subprocess over stdio. Eenrichting (alerts/webhooks doorzetten) of tweerichting (chat-bridge met reply-tool).

Vereisten: `@modelcontextprotocol/sdk` en een Node-compatibel runtime (Bun, Node, Deno). De server moet:

1. De `claude/channel`-capability declareren zodat Claude Code een notification-listener registreert.
2. `notifications/claude/channel`-events emitten.
3. Verbinden over stdio-transport.

## Server options (constructor)

| Veld | Type | Beschrijving |
|------|------|-------------|
| `capabilities.experimental['claude/channel']` | object | Verplicht, altijd `{}`. Registreert de listener |
| `capabilities.experimental['claude/channel/permission']` | object | Optioneel, `{}`. Channel kan permission-relay ontvangen |
| `capabilities.tools` | object | Alleen tweerichting, `{}`. Standaard MCP-tool capability |
| `instructions` | string | Aanbevolen. Komt in Claude's system-prompt: wat te verwachten, of te antwoorden, welke tool |

## Notification format

Emit `notifications/claude/channel` met:

| Veld | Type | Beschrijving |
|------|------|-------------|
| `content` | string | Event-body, wordt de body van de `<channel>`-tag |
| `meta` | Record<string,string> | Optioneel. Elke key wordt een attribuut op de tag (alleen letters/cijfers/underscores; hyphens worden gedropt) |

Het event komt binnen als `<channel source="..." ...>`. `source` wordt automatisch gezet vanuit de servernaam. Notifications worden niet ge-acked; events worden stil gedropt als de sessie de channel niet geladen heeft of org-policy het blokkeert.

## Reply-tool (tweerichting)

Registreer een standaard MCP-tool die Claude kan aanroepen om terug te sturen. Drie componenten: `tools: {}` in capabilities, tool-handlers (`ListToolsRequestSchema` + `CallToolRequestSchema`) die schema en send-logica definiëren, en een `instructions`-string die Claude vertelt wanneer/hoe te bellen (bv. `chat_id` doorgeven).

## Sender-gating

Een ongegate channel is een prompt-injection vector. Check de sender tegen een allowlist vóór `mcp.notification()`. Gate op sender-identiteit (`message.from.id`), niet op room/chat-ID, anders kan iedereen in een allowlisted groep injecten.

## Permission relay

Vereist v2.1.81+. Declareer `claude/channel/permission: {}`. Bij een permission-prompt:

1. Claude Code genereert een request-ID en notificeert je server (`notifications/claude/channel/permission_request`).
2. Server stuurt prompt + ID naar de chat-app.
3. Remote user antwoordt met yes/no + ID.
4. Inbound handler parset naar een verdict (`notifications/claude/channel/permission`, `behavior: 'allow'|'deny'`).

Request-velden: `request_id` (5 lowercase letters, zonder `l`), `tool_name`, `description`, `input_preview` (JSON, ~200 chars). De lokale terminal-dialog blijft open; het eerste antwoord (lokaal of remote) wint. Declareer de capability alleen als je channel de sender authenticeert.

## Packaging en testen

Wrap als plugin en publiceer naar een marketplace; installeren met `/plugin install`, inschakelen per sessie met `--channels plugin:<name>@<marketplace>`. Tijdens de preview moet elke channel op de allowlist staan; bypass per-entry met `--dangerously-load-development-channels server:<name>` of `plugin:<name>@<marketplace>`. Deze flag skipt alleen de allowlist, de `channelsEnabled` org-policy blijft gelden.

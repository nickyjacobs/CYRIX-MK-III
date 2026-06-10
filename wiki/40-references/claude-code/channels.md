---
title: "Claude Code: Channels"
source-url: https://code.claude.com/docs/en/channels
ingest-date: 2026-06-10
review-date: 2026-09-10
tags: [reference, claude-code, channels]
category: 40-references
status: active
---

# Channels

> Bron: https://code.claude.com/docs/en/channels

Een channel is een MCP-server die events in je draaiende Claude Code sessie pusht, zodat Claude kan reageren op dingen die gebeuren terwijl je niet aan de terminal zit. Channels kunnen tweerichting zijn (chat-bridge): Claude leest het event en antwoordt terug via dezelfde channel.

Research preview, vereist Claude Code v2.1.80+. Anthropic-auth via claude.ai of Console API-key vereist, niet op Bedrock/Vertex/Foundry. Team en Enterprise moeten channels expliciet inschakelen.

## Hoe het werkt

- Events komen alleen binnen terwijl de sessie open is. Voor always-on: draai Claude in een background-proces of persistente terminal.
- Je installeert een channel als plugin en configureert met eigen credentials.
- Inkomend bericht zie je in de terminal als `<channel source="...">` event; het reply-bericht verschijnt op het andere platform, niet in de terminal.

## Ondersteunde channels (research preview)

Telegram, Discord, iMessage. Elk een plugin die [Bun](https://bun.sh) vereist. `fakechat` is een localhost-demo zonder auth.

Algemene flow (Telegram/Discord):

```
/plugin install telegram@claude-plugins-official
/reload-plugins
/telegram:configure <token>
claude --channels plugin:telegram@claude-plugins-official
/telegram:access pair <code>
/telegram:access policy allowlist
```

iMessage leest de Messages-database direct (`~/Library/Messages/chat.db`, Full Disk Access nodig) en stuurt via AppleScript; alleen macOS, geen token. Texten naar jezelf omzeilt access-control.

## Security

Elke channel houdt een sender-allowlist bij: alleen toegevoegde ID's mogen pushen, de rest wordt stil gedropt. Telegram/Discord bootstrappen via pairing-code; iMessage via eigen handles plus `/imessage:access allow <handle>`. In `.mcp.json` staan is niet genoeg, een server moet ook in `--channels` benoemd worden.

## Enterprise controls

| Setting | Doel |
|---------|------|
| `channelsEnabled` | Master switch (managed setting). Op claude.ai Team/Enterprise standaard geblokkeerd; Console standaard toegestaan |
| `allowedChannelPlugins` | Welke plugins mogen registreren. Vervangt de Anthropic-allowlist. Vereist `channelsEnabled: true` |

Pro/Max zonder organisatie slaan deze checks over; opt-in per sessie met `--channels`.

## Vergelijking

| Feature | Wat |
|---------|-----|
| Claude Code on the web | Taken in verse cloud-sandbox |
| Claude in Slack | Web-sessie vanuit `@Claude`-mention |
| Standaard MCP-server | Claude bevraagt het tijdens een taak, niets gepusht |
| Remote Control | Lokale sessie aansturen vanaf claude.ai/mobile |
| **Channels** | Pusht events van niet-Claude-bronnen in je draaiende lokale sessie |

Eigen channel bouwen: zie de Channels reference. Testen tijdens preview: `--dangerously-load-development-channels`.

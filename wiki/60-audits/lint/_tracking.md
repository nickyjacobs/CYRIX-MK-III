---
title: Wiki-audit tracking
type: audit-tracking
category: 60-audits
status: active
tags: [audit, tracking, wiki-librarian]
beheerd-door: wiki-librarian
---

# Wiki-audit tracking

State-bestand van de `wiki-librarian` agent. Bewaart per finding wanneer die voor het eerst
gezien is, zodat het escalatiemechanisme tussen cadansen werkt en cloud-routines hun state
tussen runs behouden.

## Escalatie

| Situatie | Gevolg |
|---|---|
| Meer dan 7 dagen open in daily | Hard finding in de eerstvolgende weekly |
| Meer dan 30 dagen open in weekly | Hard finding in de eerstvolgende monthly |

## Conventie

Eén regel per finding, met `first-seen` in ISO-formaat. Bij oplossing verhuist de regel naar
"Opgelost", die blijft staan als audit-trail. Verwijder niets.

## Open findings

| Finding | Pagina | first-seen | Cadans | Status |
|---|---|---|---|---|
| Alle 23 claude-code-references hebben verlopen review-date | `wiki/40-references/claude-code/*.md` | 2026-09-10 | weekly | open |
| `slash-commands.md` bron-URL bestaat niet meer, gemerged in `commands.md` | `wiki/40-references/claude-code/slash-commands.md` | 2026-09-10 | weekly | open |
| `00-index.md` linkt CLI reference naar niet-bestaande URL `/cli-usage` | `wiki/40-references/claude-code/00-index.md` | 2026-09-10 | weekly | open |
| Content-drift: modellen-tabel verouderd/verwijderd op bron | `wiki/40-references/claude-code/overview.md` | 2026-09-10 | weekly | open |
| Content-drift: frontmatter-velden en bundled-skills-lijst verouderd | `wiki/40-references/claude-code/skills.md` | 2026-09-10 | weekly | open |
| Content-drift: built-in agents-tabel en frontmatter-velden verouderd | `wiki/40-references/claude-code/sub-agents.md` | 2026-09-10 | weekly | open |
| Content-drift: TeamCreate/TeamDelete-tools bestaan niet meer, nieuw TaskCreated-hook-event | `wiki/40-references/claude-code/agent-teams.md` | 2026-09-10 | weekly | open |
| Content-drift: config-scopes, transport-types (SSE deprecated) en CLI-commando's verouderd | `wiki/40-references/claude-code/mcp.md` | 2026-09-10 | weekly | open |
| Content-drift: auto memory type-taxonomie, AGENTS.md, CLAUDE.local.md ontbreken | `wiki/40-references/claude-code/memory.md` | 2026-09-10 | weekly | open |
| Nieuwe HOOG-prioriteit pagina's nog niet geingest (hooks-guide, scheduled-tasks, settings-reference, workflows, agents, cross-session-messaging, tools-reference) | `wiki/40-references/claude-code/` | 2026-09-10 | weekly | open |
| `agent-teams.md` vermeldt niet dat agent teams standaard uitgeschakeld en experimenteel zijn (vereist `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`), en alleen interactief werken | `wiki/40-references/claude-code/agent-teams.md` | 2026-10-19 | weekly | open |
| Plugins-documentatie op de bron volledig geherstructureerd onder `/docs/en/plugins/*`, inclusief nieuw Mods-concept (`plugins/mods/*`); Sept-vondst "plugins-reference" bestaat niet meer als los pad | `wiki/40-references/claude-code/plugins.md` | 2026-10-19 | weekly | open |
| Nieuwe HOOG-prioriteit pagina's nog niet geingest (features-overview, plugins/mods/*, cloud-environments, claude-directory) | `wiki/40-references/claude-code/` | 2026-10-19 | weekly | open |
| Content-drift: nieuwe frontmatter-velden (autoCompactWindow, isolation, initialPrompt, omitClaudeMd, memory) en env-vars op sub-agents.md | `wiki/40-references/claude-code/sub-agents.md` | 2026-10-19 | weekly | open |
| Content-drift: ws-transport, managedMcpServers, credential-blanking in url/headers, nieuwe env-vars op mcp.md | `wiki/40-references/claude-code/mcp.md` | 2026-10-19 | weekly | open |
| Content-drift: `/doctor prompt-audit`, `claudeMdExcludes`, `pluginConfigs`-mechanisme voor AGENTS.md-keuze, autoMemoryDirectory op memory.md | `wiki/40-references/claude-code/memory.md` | 2026-10-19 | weekly | open |
| Content-drift: `/simplify` nu bevestigd bundled, `/skill-doctor`, `allowManagedPermissionRulesOnly`, `strictPluginOnlyCustomization` op skills.md | `wiki/40-references/claude-code/skills.md` | 2026-10-19 | weekly | open |

## Opgelost

| Finding | Pagina | first-seen | opgelost-op |
|---|---|---|---|

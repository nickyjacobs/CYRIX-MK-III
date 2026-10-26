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
| Nieuw mods-subsysteem (10 pagina's onder plugins/mods/*) nog niet geingest, HOOG gezien bestaande plugin-authoring-skill | `wiki/40-references/claude-code/` | 2026-10-26 | weekly | open |
| Pagina `claude-directory.md` nog niet geingest, HOOG | `wiki/40-references/claude-code/` | 2026-10-26 | weekly | open |
| Pagina's security-guidance.md en claude-security.md nog niet geingest, MIDDEN | `wiki/40-references/claude-code/` | 2026-10-26 | weekly | open |
| Code Review-sectie uitgegroeid tot 6 pagina's (setup/customize/pull-requests/costs/troubleshooting), MIDDEN | `wiki/40-references/claude-code/` | 2026-10-26 | weekly | open |
| `plugins.md` bron-URL staat niet meer los in de docs-index, verhuisd naar `/plugins/overview` | `wiki/40-references/claude-code/plugins.md` | 2026-10-26 | weekly | open |
| Content-drift: cli-reference.md mist groot aantal nieuwe commando's (gateway, install, import, kill, purge, self-hosted-runner, mcp login/logout/serve, auto-mode config/reset, plugins, daemon run/logs) en tientallen flags | `wiki/40-references/claude-code/cli-reference.md` | 2026-10-26 | weekly | open |
| Content-drift: settings.md is herstructureerd naar scopes/precedence, key-tabel verhuisd naar settings-reference.md, nieuwe sectie over cloud-sessions | `wiki/40-references/claude-code/settings.md` | 2026-10-26 | weekly | open |
| Content-drift: hooks.md mist DirectoryAdded/PreModelSwitch/PostModelSwitch-events en nieuwe velden (if, onFailure, retry, admin-controls, limieten) | `wiki/40-references/claude-code/hooks.md` | 2026-10-26 | weekly | open |
| Content-drift: routines.md gebruikt verouderde framing (Routines ipv Scheduled tasks), mist Issue-trigger, filter-operators, artifact-publiceergedrag, concrete usage-limieten | `wiki/40-references/claude-code/routines.md` | 2026-10-26 | weekly | open |
| Content-drift: output-styles.md mist de Concise-stijl en heeft onjuiste informatie over wanneer een stijlwissel ingaat | `wiki/40-references/claude-code/output-styles.md` | 2026-10-26 | weekly | open |
| Content-drift: commands.md/slash-commands.md mist groot aantal bundled skills/workflows, waarvan meerdere al actief gebruikt worden in deze workspace | `wiki/40-references/claude-code/commands.md` | 2026-10-26 | weekly | open |

## Opgelost

| Finding | Pagina | first-seen | opgelost-op |
|---|---|---|---|

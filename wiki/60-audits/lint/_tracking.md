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
| HOOG: persoonlijke content (echte naam eigenaar, gezondheidsproject) in committable references | `wiki/40-references/ninja-possiblecooker-mc1001eu.md` | 2026-11-01 | maandelijks | open |
| HOOG: README documenteert niet-bestaande Stop-hook met foutieve drempelwaarde | `README.md` | 2026-11-01 | maandelijks | open |
| MIDDEN: README zegt security-reviewer wordt door post-edit hook aangeroepen, hook gebruikt enkel validate.py | `README.md` | 2026-11-01 | maandelijks | open |
| MIDDEN: scripts/anonymize.py ontbreekt in architectuurdiagram scripts-lijst | `README.md` | 2026-11-01 | maandelijks | open |
| MIDDEN: HASS_URL/HASS_TOKEN zonder corresponderende .mcp.json-server of documentatie | `.env.example` | 2026-11-01 | maandelijks | open |
| MIDDEN: setup.sh kopieert MEMORY.example.md nooit naar MEMORY.md | `scripts/setup.sh` | 2026-11-01 | maandelijks | open |
| MIDDEN: hardgecodeerd repo-pad nickyjacobs/CYRIX-MK-III in voorbeeldcommando's i.p.v. placeholder | `docs/routines.md` | 2026-11-01 | maandelijks | open |
| LAAG: orphan page, niet gelinkt vanuit references-index | `wiki/40-references/ninja-possiblecooker-mc1001eu.md` | 2026-11-01 | maandelijks | open |
| LAAG: frontmatter mist tags/category (en bij 1 bestand title) t.o.v. wiki/index.md-conventie | `wiki/60-audits/lint/daily-audit-2026-06-09.md`, `wiki/60-audits/lint/docs-drift-claudecode-2026-06-10.md` | 2026-11-01 | maandelijks | open |
| LAAG: assets/cyrix-logo.png referentie in README zonder dat het bestand bestaat | `README.md` | 2026-11-01 | maandelijks | open |
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

## Opgelost

| Finding | Pagina | first-seen | opgelost-op |
|---|---|---|---|

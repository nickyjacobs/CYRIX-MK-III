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
| HOOG: persoonlijke content (voornaam eigenaar, keukenapparaat, gezondheid-project), regressie na 03bacc8 | `wiki/40-references/ninja-possiblecooker-mc1001eu.md` | 2026-10-01 | monthly | open |
| HOOG: voornaam eigenaar + letterlijk thuismap-pad in ingest-log | `wiki/40-references/log.md` | 2026-10-01 | monthly | open |
| HOOG: letterlijk thuismap-pad, niet gedetecteerd door validate.py (mist `~/`-pattern) | `docs/archief/verificatie-fase1.md`, `docs/archief/verificatie-fase2.md` | 2026-10-01 | monthly | open |
| MIDDEN: Agents-tabel claimt post-edit-hook-trigger voor security-reviewer, maar hook roept alleen validate.py aan | `README.md` | 2026-10-01 | monthly | open |
| MIDDEN: architectuurdiagram scripts/-regel mist `anonymize.py` | `README.md` | 2026-10-01 | monthly | open |
| MIDDEN: setup.sh verwijst naar niet-bestaand `docs/verificatie-fase1.md` (echte pad: `docs/archief/`) | `scripts/setup.sh` | 2026-10-01 | monthly | open |
| MIDDEN: verwijzing naar niet-bestaand `wiki/60-audits/audit-2026-09-10-compleet.md` | `docs/archief/README.md` | 2026-10-01 | monthly | open |
| MIDDEN: hardcoded `nickyjacobs/CYRIX-MK-III` i.p.v. placeholder in copy-paste-commando's | `docs/routines.md` | 2026-10-01 | monthly | open |
| MIDDEN: persoonlijke cert-notitie, inconsistent met "niet-persoonlijk"-conventie van 40-references | `wiki/40-references/cpts-tips-brm.md` | 2026-10-01 | monthly | open |
| LAAG: `session-name.sh` auto-naming hook niet gedocumenteerd | `README.md` | 2026-10-01 | monthly | open |
| LAAG: HASS_URL/HASS_TOKEN genoemd zonder bijbehorende integratie | `.env.example`, `README.md`, `scripts/setup.sh` | 2026-10-01 | monthly | open |

## Opgelost

| Finding | Pagina | first-seen | opgelost-op |
|---|---|---|---|

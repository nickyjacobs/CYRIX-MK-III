---
title: Docs-drift rapport — Claude Code references
audit-date: 2026-06-15
auditor: cyrix-docs-drift-claudecode (routine)
scope: wiki/40-references/claude-code/
vorig-rapport: wiki/60-audits/lint/docs-drift-claudecode-2026-06-10.md
status: actief
---

# Docs-drift rapport: Claude Code references (2026-06-15)

> Live docs geraadpleegd via WebFetch op `code.claude.com/docs/en/`. Vergeleken met 24 lokale reference-bestanden in `wiki/40-references/claude-code/`.
> Vorige check: 2026-06-10 — zie `docs-drift-claudecode-2026-06-10.md` voor het volledige baseline-rapport.

## Samenvatting

| Categorie | Aantal |
|---|---|
| KRITIEK — Agent SDK billing-wijziging per 2026-06-15 | ✓ direct actie vereist |
| NIEUW — pagina's nu in llms.txt, niet in Juni-10-rapport én niet lokaal | 57 pagina's |
| GEWIJZIGD — verdere drift t.o.v. de Juni-10-patches | 3 references |
| Openstaand backlog uit Juni-10-rapport | Actie A/B/C/D deels ongedaan |
| Totaal live pagina's (volledig llms.txt crawl) | **146** |
| Totaal lokale references | **24** |

**Hoogste urgentie**: de Agent SDK billing-wijziging raakt `claude -p` (print mode), dat in CYRIX-routines wordt gebruikt. Lees sectie 1 direct.

---

## 1. KRITIEK — Agent SDK billing-wijziging (ingaat 2026-06-15)

**Bron**: `/en/agent-sdk/overview` — melding bovenaan de pagina:

> "Starting June 15, 2026, Agent SDK and `claude -p` usage on subscription plans will draw from a new monthly Agent SDK credit, separate from your interactive usage limits."

**Impact op CYRIX MK-III:**

- CYRIX-routines die `claude -p` gebruiken (headless/print mode) consumeren voortaan een **apart maandelijks Agent SDK credit**, los van je interactief plan-gebruik.
- Als het Agent SDK credit op is, falen `-p` calls — inclusief geautomatiseerde docs-drift en wiki-librarian routines die print mode gebruiken.
- Controleer via [claude.ai/settings/usage](https://claude.ai/settings/usage) hoeveel Agent SDK credits beschikbaar zijn.

**Aanbeveling**: controleer vandaag het Agent SDK credit verbruik. Pas eventueel routines aan die intensief print mode gebruiken als het limiet krap is.

---

## 2. NIEUW — pagina's in llms.txt maar niet in Juni-10-rapport

Het Juni-10-rapport telde 39 NIEUW-pagina's. De volledige llms.txt crawl toont **146 pagina's**, waarvan 24 lokaal gedekt. Hieronder de pagina's die het Juni-10-rapport had gemist, per relevantiecategorie.

### 2a. Prioriteit HOOG — direct bruikbaar voor CYRIX

| Pagina | URL | Reden |
|---|---|---|
| Agent SDK — 27 sub-pagina's | `/en/agent-sdk/*` | Juni-10 noemde alleen `/overview`; nu volledig ecosysteem beschikbaar: quickstart, sessions, hooks, subagents, structured outputs, MCP, permissions, plugins, custom-tools, observability, streaming, tool-search, hosting, secure-deployment, migration-guide, todo-tracking, session-storage, file-checkpointing |
| Checkpointing | `/en/checkpointing` | File-level rollback van bewerkingen; relevant voor CYRIX hooks |
| Manage sessions | `/en/sessions` | Sessie-beheer, transcript-toegang, archivering |
| Dynamic workflows | `/en/workflows` | Orchestreer subagents op schaal via dynamische workflows |
| Tools reference | `/en/tools-reference` | Volledige referentie van alle built-in tools (Read, Write, Edit, Bash, etc.) |
| Status line | `/en/statusline` | Customize de Claude Code status line — CYRIX heeft hiervoor al een skill |
| Weekly changelog | `/en/whats-new/2026-w13` t/m `2026-w22` | Wekelijkse release-notes maart–mei 2026; bevat feature-details voor versie-tracking |
| Changelog | `/en/changelog` | Geconsolideerde changelog pagina |
| Sandbox environments | `/en/sandbox-environments` | Overzicht sandboxopties voor veilig uitvoeren van code |
| Sandboxed Bash tool | `/en/sandboxing` | Configuratie van sandbox-Bash |
| Computer use | `/en/computer-use` | `--chrome` computer use vanuit CLI |
| How Claude Code works | `/en/how-claude-code-works` | Intern model van Claude Code agent loop |

### 2b. Prioriteit MIDDEL — integraties en extensies

| Pagina | URL |
|---|---|
| Discover plugins / marketplaces | `/en/discover-plugins` |
| Plugin dependencies | `/en/plugin-dependencies` |
| Plugin hints | `/en/plugin-hints` |
| Plugin marketplaces | `/en/plugin-marketplaces` |
| Plugins reference | `/en/plugins-reference` |
| Keep Claude working toward a goal | `/en/goal` |
| Keybindings | `/en/keybindings` |
| Fullscreen rendering | `/en/fullscreen` |
| Deep links (launch sessions from links) | `/en/deep-links` |
| Dev containers | `/en/devcontainer` |
| Prompt caching | `/en/prompt-caching` |
| Prompt library | `/en/prompt-library` |
| Platforms and integrations | `/en/platforms` |
| Fast mode | `/en/fast-mode` |
| Run agents in parallel | `/en/agents` |
| GitHub Enterprise Server | `/en/github-enterprise-server` |
| Auto mode config | `/en/auto-mode-config` |
| LLM gateway | `/en/llm-gateway` |
| Glossary | `/en/glossary` |

### 2c. Prioriteit LAAG — organisatie / enterprise / provider-specifiek

| Pagina | URL |
|---|---|
| Admin setup | `/en/admin-setup` |
| Analytics | `/en/analytics` |
| Authentication | `/en/authentication` |
| Champion kit | `/en/champion-kit` |
| Communications kit | `/en/communications-kit` |
| Costs | `/en/costs` |
| Data usage | `/en/data-usage` |
| Error reference | `/en/errors` |
| Legal and compliance | `/en/legal-and-compliance` |
| Managed MCP | `/en/managed-mcp` |
| Microsoft Foundry | `/en/microsoft-foundry` |
| Amazon Bedrock | `/en/amazon-bedrock` |
| Claude Platform on AWS | `/en/claude-platform-on-aws` |
| Google Vertex AI | `/en/google-vertex-ai` |
| Monitoring usage | `/en/monitoring-usage` |
| Network config | `/en/network-config` |
| Security | `/en/security` |
| Security guidance | `/en/security-guidance` |
| Server-managed settings | `/en/server-managed-settings` |
| Terminal config | `/en/terminal-config` |
| Troubleshoot install | `/en/troubleshoot-install` |
| Ultraplan | `/en/ultraplan` |
| Voice dictation | `/en/voice-dictation` |
| Zero data retention | `/en/zero-data-retention` |

---

## 3. GEWIJZIGD — verdere drift t.o.v. Juni-10-patches

### 3a. `hooks.md` — aanvullende wijzigingen na Juni-10-patch ★★

Het Juni-10-rapport vlagde hooks als "kritiek re-ingest". De file is op Juni-10 gepatcht met een Update-sectie, maar de live docs tonen nog verder drifted features die niet in de patch zitten:

| Nieuw in live docs, niet in Juni-10-patch | Detail |
|---|---|
| `CLAUDE_CODE_REMOTE` env var | Beschikbaar in web environments |
| `CLAUDE_EFFORT` env var | Huidig effort level beschikbaar in hooks |
| `terminalSequence` output veld | OSC escape sequences (v2.1.141+) |
| `if` condition-filter | Hooks op permission-rule-syntax verfijnen |
| `${user_config.*}` substitutie | Plugin hooks kunnen user config uitlezen |
| `reloadSkills` SessionStart output | Trigger skill-discovery in dezelfde sessie |
| Shell form vs exec form (`args`) | Met `args`: directe spawn, veiliger; zonder: via `sh -c` |

**Aanbeveling**: alsnog volledige re-ingest van hooks (Actie A uit Juni-10-rapport, nog open).

### 3b. `memory.md` — AGENTS.md bridge nu productie-ready ★★

Het Juni-10-rapport identificeerde dit als MIDDEL drift. Status na controle: identiek aan de Juni-10-bevindingen — d.w.z. **geen extra drift maar ook geen actie genomen**. Nog steeds aanbevolen voor re-ingest:

- `CLAUDE.local.md` scope ontbreekt in lokale reference
- `AGENTS.md` bridge via `@AGENTS.md` import of symlink ontbreekt
- Linux/Windows managed-policy paden ontbreken
- `claudeMd` settings key ontbreekt
- 25KB MEMORY.md limiet (was alleen regellimiet) ontbreekt
- Troubleshoot-sectie ontbreekt

### 3c. `routines.md` — beta-header en connectors-onderscheid ★

Lokaal ingested op 2026-06-09. Aanvullend op het Juni-10-rapport:

- Beta header `anthropic-beta: experimental-cc-routine-2026-04-01` vereist voor API `/fire` endpoint — nu prominent gedocumenteerd met breaking-change-waarschuwing
- Onderscheid `claude mcp add` (lokale servers, beschikbaar in CLI) vs. claude.ai connectors (beschikbaar in routines) nu expliciet gedocumenteerd in sectie "Connectors"
- `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD` env var voor web-sessions gedocumenteerd

---

## 4. Openstaand backlog uit Juni-10-rapport

Onderstaande acties uit het Juni-10-rapport zijn nog niet uitgevoerd:

| Actie | Wat | Status |
|---|---|---|
| **Actie A** | Re-ingest `hooks.md` | Open — gepatcht maar niet volledig |
| **Actie A** | Re-ingest `cli-reference.md` | Open — gepatcht maar source-URL mismatch nog aanwezig |
| **Actie B** | Re-ingest `settings.md` | Open — nog op maart-niveau |
| **Actie B** | Re-ingest `memory.md` | Open |
| **Actie B** | Re-ingest `mcp.md` (SSE deprecated, scope-namen gewijzigd) | Open |
| **Actie C** | Gerichte update `skills.md` | Open |
| **Actie C** | Gerichte update `sub-agents.md` | Open |
| **Actie C** | Gerichte update `overview.md` | Open |
| **Actie D** | Ingestren middel-prioriteit: `/en/context-window`, `/en/worktrees`, `/en/interactive-mode`, `/en/headless`, `/en/large-codebases`, `/en/desktop-scheduled-tasks`, `/en/remote-control`, `/en/hooks-guide` | Open |

---

## 5. Review-date status

| Reference | Huidige review-date | Oordeel |
|---|---|---|
| Refs gepatcht op 2026-06-10 (cli-reference, settings, hooks, commands, agent-view, permissions, permission-modes, env-vars, model-config, advisor, channels, channels-reference, debug-your-config) | 2026-09-10 | Geen update nodig: review-date is al ±D+3 maanden |
| Refs gepatcht op 2026-06-09 (routines, output-styles, slash-commands, plugins) | 2026-09-09 | Geen update nodig |
| Refs op maart-niveau (memory, mcp, sub-agents, agent-teams, skills, overview) | 2026-09-09 | Geen update: GEWIJZIGD — review-date-update niet van toepassing |

Alle bestaande review-dates zijn al correct ingesteld. Geen frontmatter-wijzigingen doorgevoerd in dit rapport.

---

## 6. Nieuwe versie-markers (t.o.v. Juni-10-rapport)

Het Juni-10-rapport registreerde v2.1.170 als meest recente release. Huidige live docs tonen:

| Versie | Feature |
|---|---|
| v2.1.141 | `terminalSequence` in hook output (nieuw t.o.v. Juni-10) |
| v2.1.170 | `fable` model alias (al in Juni-10-rapport) |

Geen nieuwe versie ≥ v2.1.171 geconstateerd in de docs op 2026-06-15.

---

## 7. Aanbevelingen (geprioriteerd)

### Direct (vandaag)
1. **Controleer Agent SDK credit** via claude.ai/settings/usage. Stel alert in als CYRIX-routines intensief `claude -p` gebruiken.

### Deze week
2. **Re-ingest `hooks.md`** — meeste drift, raakt dagelijks CYRIX-gebruik.
3. **Re-ingest `memory.md`** — `CLAUDE.local.md` en `AGENTS.md` bridge zijn al in productie-gebruik.
4. **Ingest `/en/agent-sdk/overview`** + kernsub-pagina's (quickstart, sessions, hooks, subagents) — Agent SDK is nu een eerste-klas feature met aparte billing.

### Volgende review-cyclus (september)
5. Re-ingest `settings.md`, `mcp.md`, `cli-reference.md` (Actie A/B compleet maken).
6. Gerichte update `skills.md`, `sub-agents.md`, `overview.md` (Actie C).
7. Ingest middel-prioriteit nieuwe pagina's: context-window, worktrees, desktop-scheduled-tasks, hooks-guide, large-codebases.
8. Overweeg `/en/whats-new/` indexeren als changelog-tracker voor toekomstige drift-checks.

---

*Rapport gegenereerd door cyrix-docs-drift-claudecode routine op 2026-06-15.*
*Live docs bereikbaar op code.claude.com — geen network-access-issues geconstateerd.*
*Volledig llms.txt geraadpleegd via `https://code.claude.com/docs/llms.txt`.*

---
title: Docs-drift audit Claude Code references
date: 2026-09-21
type: audit
category: 60-audits
status: open
tags: [audit, claude-code, docs-drift, lint]
---

# Docs-drift audit: Claude Code references (2026-09-21)

Vergelijking van `wiki/40-references/claude-code/` met de actuele documentatie-index op
`https://code.claude.com/docs/llms.txt`. Deze audit herhaalt de opzet van
`docs-drift-claudecode-2026-09-10.md`. Er is sinds die audit **geen re-ingest uitgevoerd**:
alle destijds gevonden drift is nog aanwezig, en is bij een onafhankelijke herhaling van de
controle vandaag opnieuw bevestigd. Twee details zijn dit keer scherper vastgesteld dan vorige
keer (zie sectie 4, `sub-agents.md`).

## 1. Verlopen review-dates

Alle 23 pagina's in `wiki/40-references/claude-code/` hebben een `review-date` van
`2026-09-09` of `2026-09-10`. Vandaag is `2026-09-21`, dus elke referentie staat inmiddels
11 tot 12 dagen over de vervaldatum.

- [ ] Alle 23 referenties in `wiki/40-references/claude-code/` opnieuw ingesten via `/ingest` en nieuwe review-dates zetten. Bestandspad: `wiki/40-references/claude-code/*.md` + `00-index.md`.

## 2. Verdwenen of hernoemde bronnen

- [ ] **`slash-commands.md`** verwijst naar `https://code.claude.com/docs/en/slash-commands`. Deze URL bestaat niet meer in de actuele docs-index; de inhoud is opgegaan in `https://code.claude.com/docs/en/commands`, wat wij al apart hebben als `commands.md`. Nog steeds niet opgelost. Bestandspad: `wiki/40-references/claude-code/slash-commands.md`.
- [ ] **`00-index.md`** vermeldt voor "CLI reference" de bron-URL `https://code.claude.com/docs/en/cli-usage`. Die URL bestaat niet in de actuele index; de juiste URL is `https://code.claude.com/docs/en/cli-reference`, wat wel al klopt in de frontmatter van `cli-reference.md` zelf. De indextabel is dus intern inconsistent. Nog steeds niet opgelost. Bestandspad: `wiki/40-references/claude-code/00-index.md`, regel 24.

## 3. Nieuwe pagina's (nog niet geingest)

De docs-index bevat inmiddels ruim 190 pagina's. Onderstaande selectie blijft beperkt tot wat
relevant is voor een persoonlijke-assistent-workspace met hooks, skills, subagents en routines.
De prioritering komt overeen met de vorige audit.

### Prioriteit HOOG

| Pagina | Bron | Waarom |
|---|---|---|
| Automate actions with hooks | `/docs/en/hooks-guide` | Conceptuele gids naast onze bestaande `hooks.md` (alleen reference). CYRIX draait op een SessionEnd-hook, dus direct van toepassing. |
| Run prompts on a schedule | `/docs/en/scheduled-tasks` | Beschrijft `/loop` en het schedulen van prompts binnen een sessie. `/loop` wordt in deze repo actief gebruikt. |
| All settings | `/docs/en/settings-reference` | Volledige settings-key-referentie. Wij hebben alleen `settings.md` (bestanden en precedence), niet de key-voor-key reference. |
| Orchestrate subagents at scale with dynamic workflows | `/docs/en/workflows` | Dynamic workflows ontbreken volledig, terwijl agent-teams en sub-agents al gedekt zijn. |
| Run agents in parallel | `/docs/en/agents` | Overkoepelende pagina over parallel agent-gebruik. |
| Message your other Claude Code sessions | `/docs/en/cross-session-messaging` | Genoemd als lichter alternatief in `agent-teams.md`, maar zonder eigen referentie bij ons. |
| Tools reference | `/docs/en/tools-reference` | Herhaaldelijk aangehaald vanuit andere pagina's (Task tool availability), ontbreekt bij ons. |

### Prioriteit MIDDEN

| Pagina | Bron | Waarom |
|---|---|---|
| Explore the .claude directory | `/docs/en/claude-directory` | Beschrijft de volledige `.claude/`-mapstructuur die CYRIX zelf gebruikt (rules, skills, agents). |
| Run parallel sessions with worktrees | `/docs/en/worktrees` | Relevant voor de `isolation: worktree`-optie die al in `sub-agents.md` staat. |
| Example settings files | `/docs/en/settings-example` | Companion bij `settings-reference.md`. |
| Plugins reference | `/docs/en/plugins-reference` | Companion bij bestaande `plugins.md`. |
| Share session output as artifacts | `/docs/en/artifacts` | Sessie-output delen, relevant voor gegenereerde rapporten. |
| Keep Claude working toward a goal | `/docs/en/goal` | Automatiserings-gerelateerd. |
| Catch security issues as Claude writes code | `/docs/en/security-guidance` | Relevant gezien `.claude/rules/security-context.md` in deze repo. |
| Speed up responses with fast mode | `/docs/en/fast-mode` | Fast mode wordt elders al genoemd (system-config), ontbreekt als referentie. |

### Prioriteit LAAG

Interface- en niche-pagina's zonder directe relevantie: `interactive-mode.md`, `statusline.md`,
`keybindings.md`, `accessibility.md`, `voice-dictation.md`, `terminal-config.md`,
`fullscreen.md`, `glossary.md`, `deep-links.md`, `checkpointing.md`, `context-window.md`,
`prompt-caching.md`, `errors.md`, `headless.md`, `sandboxing.md`, `sandbox-environments.md`.

Niet relevant zolang CYRIX single-user en niet org-beheerd is: de volledige
Administration-sectie (setup, deployment, gateways, self-hosted environments,
Bedrock/Vertex/Foundry, analytics), GitHub Actions/GitLab CI/CD-pagina's, en de volledige
Agent SDK-sectie. De wekelijkse `whats-new/*`-pagina's zijn changelog-snapshots.

- [ ] Bovenstaande HOOG- en MIDDEN-pagina's beoordelen voor `/ingest`, prioriteit HOOG eerst. Bestandspad (doel): `wiki/40-references/claude-code/`.

## 4. Inhoudelijke wijzigingen op bestaande referenties

Zes referenties gecontroleerd: de zes met de oudste `ingest-date` (2026-03-26), zoals
voorgeschreven. De bevindingen komen inhoudelijk overeen met de audit van 2026-09-10; waar dit
keer een scherper of aanvullend detail is vastgesteld, staat dat apart vermeld.

### `overview.md`

- [ ] De modellen-tabel (opus/sonnet/haiku met model-ID's `claude-opus-4-6`, `claude-sonnet-4-6`, `claude-haiku-4-5`) staat niet meer op de Overview-pagina. Bij re-ingest verwijderen of vervangen door een verwijzing naar `model-config.md`.
- [ ] Nieuwe installatiemethodes ontbreken: WinGet (`winget install Anthropic.ClaudeCode`), Linux package managers (apt/dnf/apk), apart Windows CMD-commando. Homebrew heeft nu twee casks (`claude-code` stable, `claude-code@latest`).
- [ ] "Wat je ermee kunt doen" is herschreven met nieuwe verwijzingen: Agent SDK, GitHub Code Review, `claude --teleport`, de `/desktop`-handoff, en Dispatch (taken vanaf telefoon naar Desktop-sessie). AGENTS.md en dynamic workflows worden nu ook genoemd vanaf deze pagina.
- Bestandspad: `wiki/40-references/claude-code/overview.md`.

### `skills.md`

- [ ] Nieuwe frontmatter-velden ontbreken: `when_to_use`, `arguments` (`$name`-substitutie), `disallowed-tools`, `paths` (path-scoped auto-activatie), `background` (alleen met `context: fork`), `metadata`, `license`, `compatibility`.
- [ ] Nieuwe string-substituties: `$name`, `${CLAUDE_EFFORT}`, `${CLAUDE_PROJECT_DIR}`, `${CLAUDE_PLUGIN_ROOT}`, `${CLAUDE_PLUGIN_DATA}`.
- [ ] Bundled-skills-lijst klopt niet meer: huidige lijst is `/run`, `/verify`, `/run-skill-generator`, `/doctor`, `/debug`, `/code-review` (alias `/review`), `/batch`, `/loop`, `/claude-api`, `/workflow-authoring`. `/simplify` staat niet in de officiele bundled-lijst. Settings `disableBundledSkills` en `skillOverrides` ontbreken bij ons.
- [ ] Skill-locaties uitgebreid met: nested `<subdir>/.claude/skills/`, `--add-dir`-scope, en synced skills vanuit het claude.ai-account.
- Bestandspad: `wiki/40-references/claude-code/skills.md`.

### `sub-agents.md`

- [ ] Built-in subagents-tabel klopt niet meer: een apart "Bash"-built-in bestaat niet meer, vervangen door een generieke `claude`-catch-all agent (ook default voor gedispatchte background-sessies). Het Explore-model is niet langer vast "Haiku", maar erft van de main-conversatie (capped op Opus bij de Claude API).
- [ ] Nieuwe frontmatter-velden ontbreken: `color`, `experimental` (bv. `cacheTtl`), en **`omitClaudeMd`** (start subagent zonder user/project/local CLAUDE.md-bestanden). Dit laatste veld stond niet in de vorige audit en is een aanvullende bevinding. `permissionMode` ondersteunt nu ook `auto` en `manual` (alias voor `default`). `model` ondersteunt ook de alias `fable`.
- [ ] **Scope/prioriteitstabel is niet alleen verouderd maar ontbreekt een rij**: de huidige documentatie heeft `Managed settings` als hoogste prioriteit (1), gevolgd door `--agents` CLI (2), `.claude/agents/` (3), `~/.claude/agents/` (4), plugin `agents/` (5, laagst). Onze tabel begint pas bij `--agents` als hoogste en kent geen managed-scope-rij. Dit is een aanvulling ten opzichte van de audit van 2026-09-10, die deze tabel niet expliciet noemde.
- Bestandspad: `wiki/40-references/claude-code/sub-agents.md`.

### `agent-teams.md`

- [ ] Setup-mechanisme is veranderd: de `TeamCreate`/`TeamDelete`-tools bestaan niet meer (sinds v2.1.178). Spawnen van een teammate vereist geen losse setup-stap meer; cleanup gebeurt automatisch bij sessie-einde.
- [ ] Nieuw hook-event: naast `TeammateIdle` en `TaskCompleted` bestaat nu ook `TaskCreated` (draait bij het aanmaken van een taak, exit 2 blokkeert aanmaak + feedback). Onze referentie noemt dit event niet.
- [ ] Nieuwe functionaliteit ontbreekt volledig: teammates kunnen nu gespawned worden vanuit een bestaande subagent-definitie ("Use subagent definitions for teammates"), met eigen regels voor welke velden (tools, model, body, skills, mcpServers) worden toegepast.
- [ ] Model-resolutie-volgorde voor teammates is uitgebreid: spawn-prompt-naam > subagent-definitie's `model` > `CLAUDE_CODE_SUBAGENT_MODEL` > lead's model. `teammateDefaultModel` is verwijderd.
- Bestandspad: `wiki/40-references/claude-code/agent-teams.md`.

### `mcp.md`

- [ ] Config-locaties-tabel klopt niet meer: de huidige docs onderscheiden **Local** (nieuw, privé per project, opgeslagen in `~/.claude.json`), Project (`.mcp.json`, gedeeld via git), en User (`~/.claude.json`, alle projecten). Onze tabel mist de Local-scope en heeft in plaats daarvan Managed/Subagent/CLI als aparte rijen.
- [ ] Transport-types: **SSE is nu expliciet deprecated**, HTTP is de aanbevolen primaire transport voor remote servers. Onze referentie noemt SSE nog zonder deprecation-waarschuwing.
- [ ] Nieuwe CLI-commando's ontbreken: `claude mcp get <naam>`, `claude mcp add-json`, `claude mcp add-from-claude-desktop`, `claude mcp login/logout`, `claude mcp serve`, `claude mcp reset-project-choices`.
- [ ] Nieuwe settings-keys: `disabledMcpServers`/`enabledMcpServers` (naast onze `enabledMcpjsonServers`/`disabledMcpjsonServers`, dit zijn kennelijk twee parallelle sets), `disableClaudeAiConnectors`, `allowAllClaudeAiMcps`. Nieuwe env-vars: `MCP_TIMEOUT`, `MCP_TOOL_TIMEOUT`, `CLAUDE_CODE_MCP_TOOL_IDLE_TIMEOUT`, `MAX_MCP_OUTPUT_TOKENS` (default 25.000), `CLAUDE_CODE_MCP_AUTO_BACKGROUND_MS`.
- Bestandspad: `wiki/40-references/claude-code/mcp.md`.

### `memory.md`

- [ ] Auto memory heeft nu een expliciete `type`-taxonomie in de frontmatter van elk memory-bestand: `user`, `feedback`, `project`, `reference`. Topic-bestanden worden voortaan met dat type geprefixt (bv. `user_role.md`, `feedback_testing.md`). Dit staat niet in onze referentie.
- [ ] MEMORY.md-leeslimiet is preciezer: eerste 200 regels **of** 25KB, wat eerder bereikt wordt. Onze referentie noemt alleen "eerste 200 regels".
- [ ] Nieuw: `modified`-frontmatter-veld (ISO 8601-timestamp) dat Claude Code zelf bijhoudt per memory-bestand. CLAUDE.md kent een maximale grootte van 4 MiB.
- [ ] Nieuwe functionaliteit ontbreekt volledig: **`AGENTS.md`-ondersteuning** als eigen instructiebron (los van CLAUDE.md, met een `agents-md`-plugin-config-optie `claude-md-or-agents-md` / `claude-md-and-agents-md` / `claude-md` / `managed-only`), het `/import`-commando, en de interactieve `/init`-flow via `CLAUDE_CODE_NEW_INIT=1`.
- [ ] `CLAUDE.local.md` als aparte locatie-rij (persoonlijke, project-specifieke, gitignored voorkeuren) ontbreekt volledig in onze locatietabel, terwijl dit bestandstype in deze repo zelf al gebruikt wordt.
- Bestandspad: `wiki/40-references/claude-code/memory.md`.

## Conclusie en vervolgacties

Geen van de bevindingen uit de audit van 2026-09-10 is opgepakt. De referentieset blijft
functioneel bruikbaar voor de kernconcepten, maar mist dezelfde workspace-relevante pagina's
(hooks-guide, scheduled-tasks, settings-reference, workflows, agents, cross-session-messaging,
tools-reference) en bevat dezelfde verouderde details in de zes oudste bestanden. Twee
aanvullende details zijn dit keer vastgesteld: het `omitClaudeMd`-veld en de volledige
scope/prioriteitstabel (met `Managed settings` als hoogste laag) in `sub-agents.md`.

Voorgestelde volgorde, ongewijzigd ten opzichte van vorige audit:

1. `slash-commands.md` afhandelen (superseded-markering of samenvoegen met `commands.md`).
2. `00-index.md` CLI-reference-link corrigeren.
3. Her-ingest van de zes gecontroleerde pagina's, met de concrete wijzigingen hierboven als checklist.
4. Nieuwe HOOG-prioriteit pagina's ingesten.
5. Overige referenties (advisor, agent-view, channels, cli-reference, commands, debug, env-vars, hooks, model-config, output-styles, permissions, permission-modes, plugins, routines, settings) blijven ongecontroleerd op inhoudelijke drift; alleen hun review-date is verlopen.

Deze reference-pagina's zijn niet gewijzigd door deze audit. Re-ingest gebeurt lokaal via
`/ingest`.

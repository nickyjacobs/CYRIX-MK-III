---
title: Docs-drift audit Claude Code references
date: 2026-09-10
type: audit
category: 60-audits
status: open
tags: [audit, claude-code, docs-drift, lint]
---

# Docs-drift audit: Claude Code references (2026-09-10)

Vergelijking van `wiki/40-references/claude-code/` met de actuele documentatie-index op
`https://code.claude.com/docs/llms.txt`. Er is drift op alle vier de gecontroleerde
categorieen: verlopen review-dates, een verdwenen bron-URL, een foute link in de index,
inhoudelijke wijzigingen op de zes oudste referenties, en een lange lijst nieuwe pagina's
die nog niet geingest zijn.

## 1. Verlopen review-dates

Alle 23 pagina's in `wiki/40-references/claude-code/` hebben een `review-date` van
`2026-09-09` of `2026-09-10`. Vandaag is `2026-09-10`, dus elke referentie is verlopen of
verloopt vandaag. Dit is geen individuele fout per pagina, maar een verzameleffect van de
initiele ingest-golf in juni 2026 die allemaal dezelfde review-cyclus kreeg.

- [ ] Alle 23 referenties in `wiki/40-references/claude-code/` opnieuw ingesten via `/ingest` en nieuwe review-dates zetten. Bestandspad: `wiki/40-references/claude-code/*.md` + `00-index.md`.

Individuele bestanden (voor de zekerheid, geen actie nodig per regel, alleen bij de
her-ingest te verversen):

`00-index.md`, `advisor.md`, `agent-teams.md`, `agent-view.md`, `channels-reference.md`,
`channels.md`, `cli-reference.md`, `commands.md`, `debug-your-config.md`, `env-vars.md`,
`hooks.md`, `mcp.md`, `memory.md`, `model-config.md`, `output-styles.md`, `overview.md`,
`permission-modes.md`, `permissions.md`, `plugins.md`, `routines.md`, `settings.md`,
`skills.md`, `slash-commands.md`, `sub-agents.md`.

## 2. Verdwenen of hernoemde bronnen

- [ ] **`slash-commands.md`** verwijst naar `https://code.claude.com/docs/en/slash-commands`. Deze URL staat niet meer in de actuele docs-index. De inhoud is opgegaan in `https://code.claude.com/docs/en/commands` ("Commands"), wat wij al apart hebben als `commands.md` (ingest 2026-06-10, nog actueel qua structuur). Voorgestelde actie: `slash-commands.md` markeren als `status: superseded` met verwijzing naar `commands.md`, of de resterende unieke inhoud (de "CYRIX MK-III gebruik"-sectie) overzetten naar `commands.md` en `slash-commands.md` archiveren. Bestandspad: `wiki/40-references/claude-code/slash-commands.md`.
- [ ] **`00-index.md`** vermeldt voor "CLI reference" de bron-URL `https://code.claude.com/docs/en/cli-usage`. Die URL bestaat niet in de actuele index; de huidige URL is `https://code.claude.com/docs/en/cli-reference`, wat ook al klopt met de frontmatter van `cli-reference.md` zelf (`source-url: https://code.claude.com/docs/en/cli-reference`). De tabel in de index is dus intern inconsistent met het bestand waar hij naar linkt. Bestandspad: `wiki/40-references/claude-code/00-index.md`, regel 24.

## 3. Nieuwe pagina's (nog niet geingest)

De docs-index bevat 166 pagina's; onderstaande selectie is beperkt tot wat relevant is voor
een persoonlijke-assistent-workspace met hooks, skills, subagents en routines. Enterprise-,
gateway-, zelf-hosting- en Agent SDK-secties zijn hieronder alleen groepsgewijs genoemd.

### Prioriteit HOOG

| Pagina | Bron | Waarom |
|---|---|---|
| Automate actions with hooks | `/docs/en/hooks-guide` | Conceptuele gids naast onze bestaande `hooks.md` (die alleen de reference is). CYRIX draait al op een SessionEnd-hook, dus dit is direct van toepassing. |
| Run prompts on a schedule | `/docs/en/scheduled-tasks` | Beschrijft `/loop` en het schedulen van prompts binnen een sessie. `/loop` wordt in deze repo actief gebruikt en staat nog niet gedocumenteerd. |
| All settings | `/docs/en/settings-reference` | Volledige settings-key-referentie. Wij hebben alleen `settings.md` (bestanden en precedence), niet de key-voor-key reference die nodig is bij hook- en permissie-configuratie. |
| Orchestrate subagents at scale with dynamic workflows | `/docs/en/workflows` | Dynamic workflows (de Workflow-tool) ontbreken volledig in onze references, terwijl agent-teams en sub-agents al wel gedekt zijn. |
| Run agents in parallel | `/docs/en/agents` | Overkoepelende pagina over parallel agent-gebruik, voorafgaand aan sub-agents/agent-teams in de docs-navigatie. |
| Message your other Claude Code sessions | `/docs/en/cross-session-messaging` | Cross-session messaging wordt genoemd in de bijgewerkte `agent-teams.md` als lichter alternatief, maar heeft geen eigen referentie bij ons. |
| Tools reference | `/docs/en/tools-reference` | Wordt herhaaldelijk aangehaald vanuit andere pagina's (Task tool availability, subagent tool-gebruik) en ontbreekt bij ons. |

### Prioriteit MIDDEN

| Pagina | Bron |
|---|---|
| Manage sessions | `/docs/en/sessions` |
| Use Claude Code on the web | `/docs/en/claude-code-on-the-web` |
| Desktop scheduled tasks | `/docs/en/desktop-scheduled-tasks` |
| Run parallel sessions with worktrees | `/docs/en/worktrees` |
| Plugins reference | `/docs/en/plugins-reference` |
| Discover and install prebuilt plugins | `/docs/en/discover-plugins` |
| Error reference | `/docs/en/errors` |
| Troubleshooting | `/docs/en/troubleshooting` |
| Claude Code changelog | `/docs/en/changelog` |
| Keep Claude working toward a goal | `/docs/en/goal` |
| Share session output as artifacts | `/docs/en/artifacts` |
| Code Review | `/docs/en/code-review` |
| Connect to MCP servers (quickstart) | `/docs/en/mcp-quickstart` |
| Checkpointing | `/docs/en/checkpointing` |
| Speed up responses with fast mode | `/docs/en/fast-mode` |
| Run Claude Code programmatically | `/docs/en/headless` |
| Continue local sessions with Remote Control | `/docs/en/remote-control` |

### Prioriteit LAAG

Interface-aanpassingen zonder directe relevantie voor deze workspace: `interactive-mode.md`,
`statusline.md`, `keybindings.md`, `accessibility.md`, `voice-dictation.md`,
`terminal-config.md`, `fullscreen.md`, `glossary.md`, `deep-links.md`.

Niet relevant zolang CYRIX single-user en niet org-beheerd is: de volledige
Administration-sectie (setup, deployment, gateways, self-hosted environments, Bedrock/Vertex/
Foundry, analytics), GitHub Actions/GitLab CI/CD-pagina's, en de volledige Agent SDK-sectie
(die is voor het bouwen van eigen agent-toepassingen, niet voor het gebruik van Claude Code
zelf). De wekelijkse `whats-new/*`-pagina's zijn changelog-snapshots; `changelog.md` (zie
MIDDEN) dekt die informatie samengevat.

- [ ] Bovenstaande HOOG- en MIDDEN-pagina's beoordelen voor `/ingest`, prioriteit HOOG eerst. Bestandspad (doel): `wiki/40-references/claude-code/`.

## 4. Inhoudelijke wijzigingen op bestaande referenties

Zes referenties zijn gecontroleerd: de zes met de oudste `ingest-date` (2026-03-26), zoals
voorgeschreven. Per pagina de concrete verschillen met de huidige bron.

### `overview.md`

- [ ] De modellen-tabel (opus/sonnet/haiku met model-ID's `claude-opus-4-6`,
  `claude-sonnet-4-6`, `claude-haiku-4-5`) staat niet meer op de Overview-pagina en is
  bovendien verouderd; de huidige modelgeneratie ligt hoger. Bij re-ingest verwijderen of
  vervangen door een verwijzing naar `model-config.md`.
- [ ] Nieuwe installatiemethodes: WinGet (`winget install Anthropic.ClaudeCode`), Linux
  package managers (apt/dnf/apk), en een apart Windows CMD-installatiecommando. Homebrew
  heeft nu twee casks (`claude-code` stable, `claude-code@latest`).
- [ ] "Wat je ermee kunt doen" is herschreven met nieuwe verwijzingen: Agent SDK, GitHub Code
  Review, `claude --teleport`, de `/desktop`-handoff, en Dispatch (taken vanaf telefoon naar
  Desktop-sessie).
- Bestandspad: `wiki/40-references/claude-code/overview.md`.

### `skills.md`

- [ ] Nieuwe frontmatter-velden ontbreken in onze referentie: `when_to_use`, `arguments`
  (genaamde argumenten met `$name`-substitutie), `disallowed-tools`, `paths`
  (path-scoped auto-activatie), `background` (alleen met `context: fork`, vereist v2.1.218+),
  `metadata`, `license`, `compatibility`.
- [ ] Nieuwe string-substituties: `$name`, `${CLAUDE_EFFORT}`, `${CLAUDE_PROJECT_DIR}`
  (vereist v2.1.196+), `${CLAUDE_PLUGIN_ROOT}`, `${CLAUDE_PLUGIN_DATA}`. Escaping met `\$`.
- [ ] Bundled-skills-lijst klopt niet meer: huidige lijst is `/run`, `/verify`,
  `/run-skill-generator`, `/doctor`, `/debug`, `/code-review`, `/batch`, `/loop`,
  `/claude-api`, `/workflow-authoring`. `/simplify` staat niet in de officiele bundled-lijst
  (mogelijk apart uitgerold). Settings `disableBundledSkills` en `skillOverrides` ontbreken
  bij ons.
- [ ] Skill-locaties uitgebreid met: nested `<subdir>/.claude/skills/`, `--add-dir`-scope, en
  synced skills vanuit het claude.ai-account (Cowork/cloud-sessies).
- Bestandspad: `wiki/40-references/claude-code/skills.md`.

### `sub-agents.md`

- [ ] Built-in subagents-tabel klopt niet meer: een apart "Bash"-built-in bestaat niet meer
  in de huidige docs, vervangen door een generieke "claude"-catch-all agent (ook default voor
  background-sessies). Het Explore-model is niet langer vast "Haiku", maar "erft van main
  (capped op Opus bij de Claude API)".
- [ ] Nieuwe frontmatter-velden: `color` (weergavekleur), `experimental.cacheTtl`.
  `permissionMode` ondersteunt nu ook `auto` en `manual` (alias voor `default`). `model`
  ondersteunt ook de alias `fable`.
- [ ] Nieuwe env-vars: `CLAUDE_CODE_DISABLE_EXPLORE_PLAN_AGENTS=1` (v2.1.198+) en
  `CLAUDE_AGENT_SDK_DISABLE_BUILTIN_AGENTS=1`. `maxTurns` vereist expliciet v2.1.246+ en
  retourneert partial output waarna Claude kan hervatten.
- Bestandspad: `wiki/40-references/claude-code/sub-agents.md`.

### `agent-teams.md`

- [ ] Setup-mechanisme is veranderd: de `TeamCreate`/`TeamDelete`-tools die eerder nodig
  waren om een team te starten/op te ruimen **bestaan niet meer** (sinds v2.1.178).
  Spawnen van een teammate vereist nu geen losse setup-stap meer; cleanup gebeurt automatisch
  bij sessie-einde.
- [ ] Nieuw hook-event: naast `TeammateIdle` en `TaskCompleted` bestaat nu ook
  **`TaskCreated`** (draait bij het aanmaken van een taak, exit 2 blokkeert aanmaak +
  feedback). Onze referentie noemt dit event niet.
- [ ] Display-mode default is gewijzigd naar `"in-process"` (was `"auto"` voor v2.1.179).
  Er is een nieuwe expliciete modus `"iterm2"` (v2.1.186+) naast in-process/tmux/auto.
- [ ] Nieuwe functionaliteit ontbreekt volledig bij ons: teammates kunnen nu gespawned worden
  vanuit een bestaande subagent-definitie ("Use subagent definitions for teammates"), met
  eigen regels voor welke velden (tools, model, body, skills, mcpServers) worden toegepast.
- [ ] Model-resolutie-volgorde voor teammates is uitgebreid en gewijzigd (spawn-prompt >
  subagent-definitie > `CLAUDE_CODE_SUBAGENT_MODEL` > lead's model), plus een nieuwe
  `CLAUDE_CODE_SUBAGENT_MODEL_FORCE=1` (v2.1.257+). `teammateDefaultModel` is verwijderd
  (v2.1.234). Nieuwe setting `subagentPromptCacheTtl` voor cache-TTL van in-process
  teammates.
- Bestandspad: `wiki/40-references/claude-code/agent-teams.md`.

### `mcp.md`

- [ ] Config-locaties-tabel klopt niet meer: de huidige docs onderscheiden **Local** (nieuw,
  privé per project, opgeslagen in `~/.claude.json`), Project, en User. Onze tabel mist de
  Local-scope volledig en heeft in plaats daarvan Managed/Subagent/CLI als aparte rijen
  (die wel elders kloppen, maar niet in deze tabel-vorm terugkomen). Scope-hierarchie is nu
  expliciet: Local > Project > User > Plugins > Claude.ai Connectors.
- [ ] Transport-types uitgebreid: **SSE is nu expliciet deprecated** (gebruik HTTP), en er is
  een nieuw type **SDK** (in-process, voor plugins en de desktop-app). Onze referentie noemt
  SSE nog zonder deprecation-waarschuwing en kent geen SDK-transport.
- [ ] Nieuwe CLI-commando's ontbreken bij ons: `claude mcp get <naam>`,
  `claude mcp add-json`, `claude mcp add-from-claude-desktop`, `claude mcp login/logout`,
  `claude mcp serve`, `claude mcp reset-project-choices`.
- [ ] Nieuwe settings-keys: `disabledMcpServers`, `enabledMcpServers` (opt-in, bv.
  `computer-use`), `disableClaudeAiConnectors`, `allowAllClaudeAiMcps`.
- [ ] Nieuwe details: env-var expansion (`${VAR}` / `${VAR:-default}`) in `.mcp.json`,
  `headersHelper` voor dynamische auth-headers, en `MAX_MCP_OUTPUT_TOKENS` (default 25.000)
  als tool-output-limiet.
- Bestandspad: `wiki/40-references/claude-code/mcp.md`.

### `memory.md`

- [ ] Auto memory heeft nu een expliciete `type`-taxonomie in de frontmatter van elk
  memory-bestand: `user`, `feedback`, `project`, `reference`. Dit staat niet in onze
  referentie.
- [ ] MEMORY.md-leeslimiet is preciezer gedefinieerd: eerste 200 regels **of** 25KB, wat
  eerder bereikt wordt. Onze referentie noemt alleen "eerste 200 regels".
- [ ] Nieuw: `modified`-frontmatter-veld (ISO 8601-timestamp, vereist v2.1.214+) dat Claude
  Code zelf bijhoudt per memory-bestand. CLAUDE.md kent een maximale grootte van 4 MiB
  (grotere bestanden worden overgeslagen).
- [ ] Nieuwe functionaliteit ontbreekt volledig: `AGENTS.md`-ondersteuning (via `@AGENTS.md`
  import of symlink), het `/import`-commando (v2.1.213+, importeert configuratie van andere
  coding agents inclusief MCP-servers, commands, subagents en skills), en de interactieve
  `/init`-flow via `CLAUDE_CODE_NEW_INIT=1`.
- [ ] `CLAUDE.local.md` als aparte locatie-rij (persoonlijke, project-specifieke, gitignored
  voorkeuren) ontbreekt volledig in onze locatietabel, terwijl dit bestandstype in deze repo
  zelf al gebruikt wordt (zie `CLAUDE.local.md` in de root, genoemd in `CLAUDE.md`).
- [ ] Nieuwe settings: `claudeMd`-key in `managed-settings.json` (inline managed CLAUDE.md),
  `paths`-budget voor rule-glob-expansie (max 1000 patronen / 4MiB), en symlink-ondersteuning
  in `.claude/rules/`.
- Bestandspad: `wiki/40-references/claude-code/memory.md`.

## Conclusie en vervolgacties

De referentieset is functioneel nog bruikbaar voor de kernconcepten, maar mist inmiddels een
aantal directe workspace-relevante pagina's (hooks-guide, scheduled-tasks, settings-reference,
workflows, agents, cross-session-messaging, tools-reference) en bevat op detailniveau
verouderde informatie in de zes oudste bestanden, vooral rond agent-teams (nieuw hook-event,
gewijzigd setup-mechanisme) en mcp (nieuwe scope, deprecated transport, nieuwe CLI-commando's).
Alle 23 referenties zijn qua review-date verlopen of verlopen vandaag.

Voorgestelde volgorde:

1. `slash-commands.md` afhandelen (superseded-markering of samenvoegen met `commands.md`).
2. `00-index.md` CLI-reference-link corrigeren.
3. Her-ingest van de zes gecontroleerde pagina's, met de concrete wijzigingen hierboven als
   checklist.
4. Nieuwe HOOG-prioriteit pagina's ingesten.
5. Overige referenties (advisor, agent-view, channels, cli-reference, commands, debug,
   env-vars, hooks, model-config, output-styles, permissions, permission-modes, plugins,
   routines, settings) zijn niet individueel gecontroleerd op inhoudelijke drift in deze
   audit-cyclus; alleen hun review-date is verlopen. Volgende cyclus: deze meenemen in de
   "oudste ingest-date eerst"-selectie.

Deze reference-pagina's zijn niet gewijzigd door deze audit. Re-ingest gebeurt lokaal via
`/ingest`.

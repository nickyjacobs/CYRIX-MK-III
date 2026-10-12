---
title: Docs-drift audit Claude Code references
date: 2026-10-12
type: audit
category: 60-audits
status: open
tags: [audit, claude-code, docs-drift, lint]
---

# Docs-drift audit: Claude Code references (2026-10-12)

Vergelijking van `wiki/40-references/claude-code/` met de actuele documentatie-index op
`https://code.claude.com/docs/llms.txt`. Dit is de tweede cyclus van deze audit (vorige:
`docs-drift-claudecode-2026-09-10.md`). Er is sinds toen niets lokaal her-geïngest, dus elke
vorige finding staat nog open. Deze cyclus komt daar nieuwe drift bovenop: een herstructurering
van de plugins-documentatie en meerdere geheel nieuwe productgebieden (mods, auto mode,
sandboxing, Projects) die nog niet in onze references staan.

## 1. Verlopen review-dates

Alle 24 pagina's in `wiki/40-references/claude-code/` hebben een `review-date` van
`2026-09-09` of `2026-09-10`. Vandaag is `2026-10-12`, dus elke referentie is meer dan een maand
verlopen. Ongewijzigd ten opzichte van vorige cyclus.

- [ ] Alle 24 referenties in `wiki/40-references/claude-code/` opnieuw ingesten via `/ingest` en nieuwe review-dates zetten. Bestandspad: `wiki/40-references/claude-code/*.md` + `00-index.md`.

## 2. Verdwenen of hernoemde bronnen

- [ ] **`slash-commands.md`** verwijst naar `https://code.claude.com/docs/en/slash-commands`. Deze URL staat niet meer in de actuele docs-index. De inhoud is opgegaan in `https://code.claude.com/docs/en/commands` ("Commands"), wat wij al apart hebben als `commands.md`. Ongewijzigd ten opzichte van vorige cyclus. Bestandspad: `wiki/40-references/claude-code/slash-commands.md`.
- [ ] **`00-index.md`** vermeldt voor "CLI reference" de bron-URL `https://code.claude.com/docs/en/cli-usage`. Die URL bestaat niet; de juiste URL is `https://code.claude.com/docs/en/cli-reference`, wat al wel klopt in de frontmatter van `cli-reference.md` zelf. Ongewijzigd ten opzichte van vorige cyclus. Bestandspad: `wiki/40-references/claude-code/00-index.md`, regel 24.
- [ ] **Nieuw deze cyclus: `plugins.md`** verwijst naar `https://code.claude.com/docs/en/plugins`. Die URL bestaat nog en geeft nog steeds content terug, maar is herstructureerd tot een korte hub-pagina ("Plugins overview") die doorlinkt naar tientallen subpagina's onder `/docs/en/plugins/*`: `overview`, `install`, `anthropic-marketplaces`, `code-intelligence`, `security`, `create`, `components`, `dependencies`, `publish`, `measure`, `cli-hints`, `create-marketplace`, `host-marketplace`, `relevance`, `org`, `troubleshooting`, `loading`, `manifest-reference`, `marketplace-reference`, `cli-reference`, plus een volledige nieuwe `mods/`-sectie (zie sectie 3). Onze `plugins.md` dekt alleen het oude vlakke overzicht en mist deze hele structuur. Voorgestelde actie: bij her-ingest `plugins.md` vervangen door minimaal `plugins/overview.md` + `plugins/components.md` + `plugins/mods/overview.md`, en overweeg de rest als losse referenties indien relevant. Bestandspad: `wiki/40-references/claude-code/plugins.md`.

## 3. Nieuwe pagina's (nog niet geïngest)

De docs-index bevat nu ongeveer 200 pagina's (exclusief vertalingen en de wekelijkse
`whats-new/*`-snapshots). Onderstaande selectie is beperkt tot wat relevant is voor een
persoonlijke-assistent-workspace met hooks, skills, subagents en routines.

### Prioriteit HOOG

| Pagina | Bron | Waarom |
|---|---|---|
| Automate actions with hooks | `/docs/en/hooks-guide` | Nog open van vorige cyclus. CYRIX draait al op een SessionEnd-hook. |
| Run prompts on a schedule | `/docs/en/scheduled-tasks` | Nog open van vorige cyclus. Dit is letterlijk het mechanisme waarmee deze audit-sessie zelf draait (routine `cyrix-docs-drift-claudecode`). |
| All settings | `/docs/en/settings-reference` | Nog open van vorige cyclus. |
| Orchestrate subagents at scale with dynamic workflows | `/docs/en/workflows` | Nog open van vorige cyclus. De Workflow-tool is beschikbaar in deze sessie. |
| Run agents in parallel | `/docs/en/agents` | Nog open van vorige cyclus. |
| Message your other Claude Code sessions | `/docs/en/cross-session-messaging` | Nog open van vorige cyclus. SendMessage is beschikbaar in deze sessie. |
| Tools reference | `/docs/en/tools-reference` | Nog open van vorige cyclus. |
| **Nieuw: Mods overview, Create a mod, Mods reference, React to events with a mod, Use the mods API** | `/docs/en/plugins/mods/overview`, `/create`, `/reference`, `/events`, `/api` | Geheel nieuw productgebied sinds de vorige cyclus: een mod is een plugin met een hooks-module in JavaScript die ook panes en commando's kan tekenen. De `plugin-authoring`-skill in deze sessie verwijst hier al naar, maar wij hebben geen enkele referentie over mods. |
| **Nieuw: Configure auto mode, Auto mode classifier request charges** | `/docs/en/auto-mode-config`, `/docs/en/auto-mode-classifier-billing` | Deze sessie draait zelf met "Auto Mode Active". Dit mechanisme (classifier die permissie-prompts elimineert) staat nergens in onze references. |
| **Nieuw: Let Claude coordinate ongoing work with Projects** | `/docs/en/claude-projects` | Nieuwe functie om langlopend werk over meerdere parallelle sessies te coördineren. Relevant voor een workspace die al met routines en subagents werkt. |
| **Nieuw: Extend Claude Code (overview van CLAUDE.md/skills/hooks/rules samen)** | `/docs/en/features-overview` | Overkoepelende pagina die uitlegt wanneer je CLAUDE.md, een rule, een skill of een hook gebruikt. Wordt al vanuit de bijgewerkte `memory.md`-bron aangehaald en ontbreekt bij ons volledig. |

### Prioriteit MIDDEN

| Pagina | Bron |
|---|---|
| Manage sessions | `/docs/en/sessions` |
| Use Claude Code in the cloud | `/docs/en/claude-code-on-the-web` |
| Continue local sessions with Remote Control | `/docs/en/remote-control` |
| Desktop scheduled tasks | `/docs/en/desktop-scheduled-tasks` |
| Run parallel sessions with worktrees | `/docs/en/worktrees` |
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
| **Nieuw:** Configure the sandboxed Bash tool | `/docs/en/sandboxing` |
| **Nieuw:** Choose a sandbox environment | `/docs/en/sandbox-environments` |
| **Nieuw:** Configure cloud environments | `/docs/en/cloud-environments` |
| **Nieuw:** How Claude Code uses prompt caching | `/docs/en/prompt-caching` |
| **Nieuw:** Explore the `.claude` directory | `/docs/en/claude-directory` |
| **Nieuw:** Explore the context window | `/docs/en/context-window` |
| **Nieuw:** Find bugs with ultrareview | `/docs/en/ultrareview` |

### Prioriteit LAAG

Ongewijzigd ten opzichte van vorige cyclus: interface-aanpassingen (`interactive-mode`,
`statusline`, `keybindings`, `accessibility`, `voice-dictation`, `terminal-config`,
`fullscreen`, `glossary`, `deep-links`), de volledige Administration-sectie, GitHub
Actions/GitLab CI/CD, en de volledige Agent SDK-sectie. Nieuw laag-prioriteit sinds deze
cyclus: `mobile.md`, `vs-code.md`, `jetbrains.md`, `chrome.md`, `computer-use.md`,
`claude-tag.md`, `how-claude-code-works.md`, `platforms.md`, `prompt-library.md`,
`large-codebases.md`, `troubleshoot-install.md`, `quickstart.md` (basis, geen directe
workspace-relevantie).

- [ ] Bovenstaande HOOG- en MIDDEN-pagina's beoordelen voor `/ingest`, prioriteit HOOG eerst, met bijzondere aandacht voor de mods- en auto mode-pagina's omdat deze sessie beide functies al actief gebruikt. Bestandspad (doel): `wiki/40-references/claude-code/`.

## 4. Inhoudelijke wijzigingen op bestaande referenties

Zes referenties gecontroleerd, de zes met de oudste `ingest-date` (2026-03-26, ongewijzigd ten
opzichte van vorige cyclus omdat nog niets her-geïngest is).

### `overview.md`

- [ ] Modellen-tabel ontbreekt nu volledig op de bronpagina (was al verouderd, nu weggehaald). Bij re-ingest verwijderen en vervangen door verwijzing naar `model-config.md`.
- [ ] Installatie: WinGet (`winget install Anthropic.ClaudeCode`), Linux package managers (apt/dnf/apk), apart Windows CMD-commando, en twee Homebrew-casks (`claude-code` stable vs `claude-code@latest`) ontbreken nog steeds.
- [ ] "Wat je ermee kunt doen" is herschreven als accordion met nieuwe concrete verwijzingen: `/schedule`-commando om Routines te maken, `claude --teleport` (vereist claude.ai-abonnement), `/desktop`-handoff, Dispatch (taak vanaf telefoon naar Desktop-sessie), en expliciete AGENTS.md-ondersteuning onder "Customize".
- [ ] Surfaces-tabel: Channels-rij noemt nu ook "mijn eigen webhooks" naast Telegram/Discord/iMessage. "Taak lokaal starten, doorgaan op mobiel" gebruikt nu `claude --cloud` als CLI-commando.
- Bestandspad: `wiki/40-references/claude-code/overview.md`.

### `skills.md`

- [ ] Frontmatter-velden nog steeds niet bijgewerkt: `when_to_use` (telt mee in een cap van 1.536 tekens samen met `description`), `arguments`, `disallowed-tools`, `paths`, `background` (default `true`, vereist `context: fork` en v2.1.218+), `metadata`, `license`, `compatibility`.
- [ ] Nieuw detail: buiten Claude Code (claude.ai-uploads, Skills API, `package_skill.py`) zijn alleen `name`, `description`, `license`, `compatibility`, `metadata` en `allowed-tools` toegestaan; andere velden geven daar een harde fout.
- [ ] Bundled-skills-lijst klopt nog steeds niet: actuele lijst is `/doctor` (incl. `/doctor prompt-audit`, v2.1.283+), `/code-review` (alias `/review`), `/batch`, `/debug`, `/loop`, `/claude-api` (subcommando's: migrate, upgrade, managed-agents-onboard, prompt-audit, cost-optimize, build-eval, hillclimb, preserved-thinking-migration), `/verify`, `/run`, `/run-skill-generator`, `/simplify`, `/workflow-authoring` (alleen bij dynamic workflows aan). Onze lijst mist `/doctor`, `/code-review`, `/verify`, `/run`, `/run-skill-generator`, `/workflow-authoring`.
- [ ] Skill-locaties uitgebreid met: Nested `<subdir>/.claude/skills/`, `--add-dir`-scope, claude.ai-account-skills (Cowork/cloud/signed-in terminal), plus paden `~/.claude/skills/synced/` (reserveerde naam), `~/.claude/skills/.trash/`, `.claude/skills/run-<name>/` en `.claude/settings.local.json` voor `skillOverrides`. Personal-skills laden expliciet niet in Cowork/cloud-sessies, dat stond nog niet bij ons.
- Bestandspad: `wiki/40-references/claude-code/skills.md`.

### `sub-agents.md`

- [ ] Built-in subagents-tabel klopt nog steeds niet: "Bash" bestaat niet meer, vervangen door catch-all agent "claude". Explore's model is niet langer vast Haiku, maar volgt het model van de main conversation (met een uitzondering voor Fable als main-model).
- [ ] Nieuwe frontmatter-velden nog steeds niet toegevoegd: `omitClaudeMd` (v2.1.271+), `color` (red/blue/green/yellow/purple/orange/pink/cyan), `experimental.cacheTtl` (`5m` of `1h`, v2.1.248+). `effort` ondersteunt nu ook `xhigh`.
- [ ] Nieuwe env-vars ontbreken nog steeds, met twee extra die vorige cyclus niet genoemd zijn: `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=1`, `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH` (default 3, v2.1.219+), `CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS` (default 20, v2.1.217+), `CLAUDE_CODE_FORK_SUBAGENT` (pre-v2.1.232), `CLAUDE_CODE_EFFORT_LEVEL`, `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE`.
- [ ] Nieuwe CLI-flags ontbreken: `--append-subagent-system-prompt` (v2.1.205+) en `--append-subagent-system-prompt-file` (v2.1.261+).
- Bestandspad: `wiki/40-references/claude-code/sub-agents.md`.

### `agent-teams.md`

- [ ] `TeamCreate`/`TeamDelete`-tools bestaan nog steeds niet (ongewijzigd). `TaskCreated`-hook-event nog steeds niet gedocumenteerd bij ons (ongewijzigd).
- [ ] Nieuw deze cyclus: "Use subagent definitions for teammates" ontbreekt volledig. Je kan een teammate spawnen vanuit een bestaande subagent-definitie, met precieze regels per veld (`tools`, `model`, `disallowedTools`, `effort`, body, `skills`, `mcpServers`) die verschillen per display-modus.
- [ ] Model-resolutie-volgorde voor teammates is verder uitgebreid: spawn-prompt > subagent-definitie's `model` > `CLAUDE_CODE_SUBAGENT_MODEL` (tenzij `inherit`) > lead's model, met een mod's `agent.spawn`-hook die boven de eerste bron gaat, en `CLAUDE_CODE_SUBAGENT_MODEL_FORCE=1` (v2.1.257+) die alles overschrijft. Plus `availableModels`-allowlist-substitutieregels specifiek voor teammates.
- [ ] Nieuw: regels voor berichten tussen agents (`SendMessage`) in combinatie met auto mode: de classifier behandelt een doorgegeven goedkeuringsclaim van een andere agent als onbetrouwbare input, nooit als toestemming van jou, en controleert elk bericht voor aflevering.
- [ ] Nieuw: `subagentPromptCacheTtl`-setting voor de cache-TTL van in-process teammates (default 5 minuten, instelbaar naar 1 uur). Relevant voor sessies die via Routines draaien.
- Bestandspad: `wiki/40-references/claude-code/agent-teams.md`.

### `memory.md`

- [ ] AGENTS.md-ondersteuning is nu volledig uitgewerkt met een `/config`-instelling "Project instructions" met vier waarden: `claude-md-or-agents-md` (default), `claude-md-and-agents-md`, `claude-md`, `managed-only`. Ontbreekt nog volledig bij ons.
- [ ] `CLAUDE.local.md` als officiële locatie-rij ("Local instructions", gitignored, project-specifiek) ontbreekt nog steeds in onze locatietabel.
- [ ] Nieuw deze cyclus: `/doctor prompt-audit` (v2.1.283+) controleert CLAUDE.md, CLAUDE.local.md, AGENTS.md, rules, skills, commands, subagents en output styles op verouderde of tegenstrijdige content, en stelt edits voor zonder zelf te schrijven.
- [ ] `/import`-commando (v2.1.213+) en de interactieve `/init`-flow via `CLAUDE_CODE_NEW_INIT=1` nog steeds niet gedocumenteerd.
- [ ] MEMORY.md-leeslimiet blijft "eerste 200 regels of 25KB, wat eerder komt" (ongewijzigd, nog steeds onjuist bij ons als alleen "200 regels").
- [ ] Nieuw: `.claude/rules/` ondersteunt nu symlinks naar gedeelde regelsets, met een goedkeuringsdialoog zoals bij externe imports; een rule-symlink naar een netwerkpad (UNC-share, `/net`, `/Network`) laadt niet. Volledig nieuw onderwerp, niet in onze referentie.
- [ ] Nieuw: `paths`-budget voor brace-expansion in rules is nu exact gespecificeerd: 1.000 geëxpandeerde patronen en 4 MiB per rule.
- Bestandspad: `wiki/40-references/claude-code/memory.md`.

### `mcp.md`

- [ ] Scope-tabel klopt nog steeds niet: actuele scopes zijn **Local** (default, niet gedeeld, in `~/.claude.json`), **Project** (`.mcp.json`, gedeeld via git) en **User** (alle projecten, ook in `~/.claude.json`). Onze tabel mist de Local-scope nog steeds.
- [ ] SSE blijft deprecated (ongewijzigd), met een nieuw detail: Claude Code probeert sinds v2.1.265 eerst HTTP en valt automatisch terug op SSE.
- [ ] SDK-transport bevestigd (ongewijzigd): alleen registreerbaar door een SDK-host-app (Agent SDK, desktop app), niet handmatig configureerbaar.
- [ ] Nieuw detail: WebSocket (`ws`) is alleen via JSON-config te zetten, `claude mcp add --transport` accepteert geen `ws`.
- [ ] Nieuwe CLI- en in-sessie-commando's ontbreken nog steeds: `claude mcp add-json`, `add-from-claude-desktop`, `get`, `login`/`logout`, `reset-project-choices`, `serve`, plus in-sessie `/mcp`, `/mcp reconnect all` (v2.1.284+) en `/plugin`.
- [ ] Nieuwe settings-keys: `disabledMcpServers`, `enabledMcpServers` (ongewijzigd van vorige cyclus), plus dit keer ook `disableClaudeAiConnectors`, `allowAllClaudeAiMcps`, `deniedMcpServers`, `managedMcpServers`, `skipDangerousModePermissionPrompt`, die niet in het vorige rapport stonden.
- Bestandspad: `wiki/40-references/claude-code/mcp.md`.

## Conclusie en vervolgacties

Geen enkele finding uit de vorige cyclus is opgelost: er is nog niet lokaal her-geïngest. Deze
cyclus komt daar bovenop twee duidelijke signalen bij dat de achterstand groeit in plaats van
krimpt. Ten eerste is `plugins.md` niet alleen verouderd maar structureel achterhaald: de bron is
opgesplitst in een hub-pagina plus tientallen subpagina's, met een volledig nieuwe mods-sectie.
Ten tweede bestaan er nu meerdere productgebieden (mods, auto mode, Projects, sandboxing) die deze
sessie zelf al gebruikt of waarvan sporen in de eigen tooling zichtbaar zijn, maar die nergens in
de references staan.

Voorgestelde volgorde, ongewijzigd qua eerste twee punten, met twee toevoegingen:

1. `slash-commands.md` afhandelen (superseded-markering of samenvoegen met `commands.md`).
2. `00-index.md` CLI-reference-link corrigeren.
3. `plugins.md` her-ingesten als hub-pagina plus kernonderdelen (components, security, mods/overview).
4. Her-ingest van de zes gecontroleerde pagina's, met de concrete wijzigingen hierboven als checklist.
5. Nieuwe HOOG-prioriteit pagina's ingesten, in het bijzonder mods en auto mode gezien het directe gebruik in deze sessie.
6. Overige referenties blijven ongecontroleerd op inhoudelijke drift deze cyclus; volgende cyclus "oudste ingest-date eerst" blijft dezelfde zes aanwijzen totdat er her-geïngest is.

Deze reference-pagina's zijn niet gewijzigd door deze audit. Re-ingest gebeurt lokaal via
`/ingest`.

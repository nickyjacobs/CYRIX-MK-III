---
title: Docs-drift audit Claude Code references
date: 2026-10-19
type: audit
category: 60-audits
status: open
tags: [audit, claude-code, docs-drift, lint]
---

# Docs-drift audit: Claude Code references (2026-10-19)

Vergelijking van `wiki/40-references/claude-code/` met de actuele documentatie-index op
`https://code.claude.com/docs/llms.txt`, als vervolg op de audit van 2026-09-10. Alle bevindingen
uit die vorige audit staan nog open: er heeft geen her-ingest plaatsgevonden (alle review-dates
staan nog op 2026-09-09/2026-09-10). Deze audit voegt nieuwe bevindingen toe die sinds september
aan het licht komen, met name op `agent-teams.md`, de plugins-structuur, en detailniveau op
`sub-agents.md`, `mcp.md`, `memory.md` en `skills.md`.

## 1. Verlopen review-dates

Alle 24 pagina's in `wiki/40-references/claude-code/` hebben nog steeds een `review-date` van
`2026-09-09` of `2026-09-10`. Vandaag is `2026-10-19`, dus elke referentie staat al circa vijf
weken op verlopen. Geen wijziging ten opzichte van de vorige audit, buiten het feit dat de
achterstand groter wordt.

- [ ] Alle 24 referenties opnieuw ingesten via `/ingest`. Bestandspad: `wiki/40-references/claude-code/*.md` + `00-index.md`. (Staat al open sinds 2026-09-10, zie tracking.)

## 2. Verdwenen of hernoemde bronnen

Beide Sept-bevindingen staan nog open, ongewijzigd bevestigd:

- [ ] **`slash-commands.md`** verwijst naar `https://code.claude.com/docs/en/slash-commands`. Deze URL bestaat nog steeds niet in de actuele docs-index; de inhoud blijft opgegaan in `commands.md`. Bestandspad: `wiki/40-references/claude-code/slash-commands.md`.
- [ ] **`00-index.md`** vermeldt voor "CLI reference" nog steeds de foute bron-URL `https://code.claude.com/docs/en/cli-usage` in plaats van `cli-reference`. Bestandspad: `wiki/40-references/claude-code/00-index.md`, regel 24.

Nieuwe bevinding in deze categorie:

- [ ] **Plugins-documentatie is volledig geherstructureerd** sinds de Sept-audit. Wat in september nog een losse pagina `/docs/en/plugins-reference` leek (MIDDEN-prioriteit, nog niet geingest), is nu een hele subsectie onder `/docs/en/plugins/` met eigen paden: `plugins/manifest-reference`, `plugins/marketplace-reference`, `plugins/cli-reference`, plus een geheel nieuw concept **Mods** (`plugins/mods/overview`, `mods/create`, `mods/reference`, `mods/interface`, `mods/events`, `mods/api`, `mods/test`, `mods/troubleshoot`, `mods/admin`, `mods/gallery`). Mods zijn aanpassingen aan Claude's eigen interface/gedrag (panelen, statuslines, hooks op tool-calls), direct relevant omdat deze repo de `plugin-authoring`-skill gebruikt voor dat werk. Onze `plugins.md` dekt dit nog niet. Bestandspad: `wiki/40-references/claude-code/plugins.md`.

## 3. Nieuwe pagina's (nog niet geingest)

Sept-audit had al een lijst HOOG/MIDDEN/LAAG-pagina's die nog niet geingest zijn (hooks-guide,
scheduled-tasks, settings-reference, workflows, agents, cross-session-messaging,
tools-reference, sessions, claude-code-on-the-web, desktop-scheduled-tasks, worktrees,
discover-plugins, errors, troubleshooting, changelog, goal, artifacts, code-review,
mcp-quickstart, checkpointing, fast-mode, headless, remote-control, en een LAAG-groep
interface-pagina's). Die selectie blijft onveranderd open, zie tracking. Deze audit voegt
pagina's toe die in september niet benoemd waren.

### Prioriteit HOOG (nieuw gevonden)

| Pagina | Bron | Waarom |
|---|---|---|
| Extend Claude Code | `/docs/en/features-overview` | Overkoepelend overzicht van hooks, skills, subagents en wanneer je welk mechanisme gebruikt. Rechtstreeks relevant voor hoe deze repo is opgebouwd. |
| Mods overview + subpagina's | `/docs/en/plugins/mods/*` | Nieuw concept: aanpassingen aan Claude's eigen interface en tool-call-gedrag. Matcht de bestaande `plugin-authoring`-skill in deze repo. |
| Configure cloud environments | `/docs/en/cloud-environments` | Deze sessie draait zelf in een cloud-container; de pagina beschrijft precies dat soort omgeving (netwerkbeleid, secrets, setup-script). |
| Explore the .claude directory | `/docs/en/claude-directory` | Referentie voor de mapstructuur die hooks, skills, rules en agents gebruiken; nuttig als structuurdocument naast onze losse pagina's. |

### Prioriteit MIDDEN (nieuw gevonden)

| Pagina | Bron | Waarom |
|---|---|---|
| Let Claude coordinate ongoing work with Projects | `/docs/en/claude-projects` | Nieuw coordinatiemechanisme voor langlopend werk over sessies heen, relevant naast routines en agent-teams. |
| Get started with Claude Code in the cloud | `/docs/en/web-quickstart` | Beschrijft de surface waarop deze sessie zelf draait. |
| Auto mode classifier request charges | `/docs/en/auto-mode-classifier-billing` | Deze sessie draait met Auto Mode actief; kosten-/gedragsdetails zijn relevant voor de eigenaar. |
| Configure the sandboxed Bash tool / Choose a sandbox environment | `/docs/en/sandboxing`, `/docs/en/sandbox-environments` | Security-relevant, sluit aan op `security-context.md`. |
| Catch security issues as Claude writes code / Scan your codebase | `/docs/en/security-guidance`, `/docs/en/claude-security` | Rechtstreeks relevant voor de security-professional-context van deze workspace. |
| How Claude Code works | `/docs/en/how-claude-code-works` | Conceptuele basis, nuttig naast Overview. |
| How Claude Code uses prompt caching | `/docs/en/prompt-caching` | Wordt al impliciet aangehaald in de huidige `agent-teams`-bron (cache-TTL voor teammates); ontbreekt als eigen referentie. |
| Review locally with /code-review / Find bugs with ultrareview | `/docs/en/code-review-local`, `/docs/en/ultrareview` | Nieuwe bundled-review-workflows. |
| Explore the context window | `/docs/en/context-window` | Beschrijft wat compactie overleeft; relevant voor lange CYRIX-sessies. |

### Prioriteit LAAG (nieuw gevonden, groepsgewijs)

Generieke onboarding- en platform-pagina's zonder directe meerwaarde voor deze workspace:
`quickstart`, `best-practices`, `common-workflows`, `prompt-library`, `platforms`, `mobile`,
`chrome`, `computer-use`, `vs-code`, `jetbrains`, `slack`, `claude-tag`, de volledige
Desktop-sectie (`desktop-quickstart`, `desktop`, `desktop-linux`, `desktop-wsl`,
`desktop-ios-simulator`), `settings-example`, `large-codebases`, `troubleshoot-install`, de
Code-Review-subpagina's (`code-review-setup`, `code-review-customize`,
`code-review-pull-requests`, `code-review-costs`, `code-review-troubleshooting`,
`github-enterprise-server`), de self-hosted-environments-subpagina's, en de overige
plugins-subpagina's (`install`, `anthropic-marketplaces`, `code-intelligence`,
`plugins/security`, `create`, `components`, `dependencies`, `plugin-evals`, `publish`,
`measure`, `cli-hints`, `create-marketplace`, `host-marketplace`, `relevance`, `org`,
`loading`, `plugins/troubleshooting`).

- [ ] HOOG- en MIDDEN-pagina's hierboven beoordelen voor `/ingest`. Bestandspad (doel): `wiki/40-references/claude-code/`.

## 4. Inhoudelijke wijzigingen op bestaande referenties

Dit keer de resterende zes van de "oudste ingest-date"-rotatie: `cli-reference.md`,
`settings.md`, `hooks.md` (ingest 2026-06-10, nog niet gecontroleerd) zijn deze cyclus
**niet** gefetcht; in plaats daarvan is gecontroleerd of er sinds september nieuwe drift is
opgetreden op de zes pagina's die de Sept-audit al behandelde, omdat die het langst onbehandeld
blijven zonder vervolgcontrole. Volgende cyclus: `cli-reference.md`, `settings.md`, `hooks.md`
oppakken als de drie oudste nog-niet-gecontroleerde pagina's.

### `overview.md`

Sept-bevindingen (modellen-tabel weg, nieuwe installatiemethodes, herschreven "wat je kunt
doen") blijven bevestigd en ongewijzigd. Geen noemenswaardige nieuwe drift boven op wat al
bekend was, behalve een verwijzing naar **Claude Projects** (zie sectie 3, nieuwe pagina) als
mechanisme voor "laat Claude parallelle sessies coordineren".

### `skills.md`

Sept-bevindingen (frontmatter-velden, string-substituties, bundled-skills-lijst,
skill-locaties) blijven bevestigd. Nieuwe details sinds september:

- [ ] `/simplify` is in de huidige bron nu **expliciet bevestigd als bundled skill** (september was dit nog onzeker, "mogelijk apart uitgerold"). Daarnaast wordt `/skill-doctor` genoemd als bundled skill die context-kosten en gebruik per skill rapporteert, nog niet in onze referentie.
- [ ] Nieuwe settings-keys ontbreken nog: `allowManagedPermissionRulesOnly` (v2.1.282+, negeert `allowed-tools` in project/personal skills) en `strictPluginOnlyCustomization`.
- [ ] Permission-rule-syntax `Skill(name)` / `Skill(name *)` (bijv. `Skill(deploy *)` om te weigeren) staat niet in onze referentie.
- Bestandspad: `wiki/40-references/claude-code/skills.md`.

### `sub-agents.md`

Sept-bevindingen (built-in-tabel, frontmatter `color`/`experimental.cacheTtl`, permissionMode,
model-alias `fable`, env-vars) blijven bevestigd. Substantiële nieuwe velden en variabelen die
in september niet genoemd zijn:

- [ ] Nieuwe frontmatter-velden: `autoCompactWindow` (100.000-1.000.000 tokens, v2.1.296+),
  `isolation: worktree` (tijdelijke git worktree per subagent), `initialPrompt` (eerste
  gebruikersbeurt als de subagent de hoofdsessie wordt), `omitClaudeMd` (v2.1.271+, laadt geen
  CLAUDE.md), `memory` (`user`/`project`/`local`, persistent subagent-geheugen).
- [ ] Nieuwe env-vars ontbreken: `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH` (standaard 3 sinds
  v2.1.219), `CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS` (standaard 20, v2.1.217+),
  `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS`, `CLAUDE_CODE_EFFORT_LEVEL`,
  `CLAUDE_CODE_AUTO_COMPACT_WINDOW`.
- [ ] permissionMode-lijst is uitgebreider dan Sept vastlegde: naast `default`/`manual` ook
  `acceptEdits`, `auto` (achtergrondclassifier), `dontAsk`, `bypassPermissions`, `plan`. Als het
  hoofdgesprek in `bypassPermissions`/`acceptEdits`/`auto` draait, wordt de subagent-instelling
  genegeerd.
- [ ] Modelkeuze-volgorde preciezer: per-aanroep-parameter (v2.1.292+) > frontmatter `model` >
  `CLAUDE_CODE_SUBAGENT_MODEL` > hoofdgesprekmodel.
- Bestandspad: `wiki/40-references/claude-code/sub-agents.md`.

### `agent-teams.md`

Sept-bevindingen (TeamCreate/TeamDelete verdwenen, nieuw hook-event, display-mode default,
subagent-definities voor teammates, model-resolutie, `subagentPromptCacheTtl`) blijven
bevestigd. Belangrijke nieuwe bevinding die in september ontbrak:

- [ ] **Agent teams staan standaard uit en zijn experimenteel.** De bron vermeldt expliciet dat
  de env-var `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` vereist is in `settings.json` of de
  omgeving; zonder die variabele spawnt Claude geen teammates en worden geen team-directories
  aangemaakt. Onze referentie noemt deze opt-in-vereiste niet en wekt de indruk dat agent teams
  standaard beschikbaar zijn.
- [ ] Teammates spawnen vereist een **interactieve sessie**: in non-interactive mode (`-p`,
  inclusief Agent SDK-sessies) spawnt Claude nooit teammates, zelfs met de variabele aan.
- [ ] Limitations-sectie ontbreekt volledig bij ons: geen sessie-resumptie voor in-process
  teammates na `/resume`/`/rewind`, geen nested teams, geen achtergrond-subagents vanuit een
  in-process teammate, split-panes werken niet in VS Code's terminal, Windows Terminal of
  Ghostty, en maximaal één team per sessie.
- [ ] In **auto mode** (zoals deze sessie draait) controleert de classifier berichten tussen
  agents: een doorgegeven goedkeuringsclaim van een andere agent wordt behandeld als onvertrouwde
  input, nooit als bevestiging van de gebruiker. Relevant gezien de `Auto Mode Active`-context
  van deze sessie.
- Bestandspad: `wiki/40-references/claude-code/agent-teams.md`.

### `mcp.md`

Sept-bevindingen (Local-scope, SSE deprecated + SDK-transport, nieuwe CLI-commando's,
settings-keys, env-var-expansion, `MAX_MCP_OUTPUT_TOKENS`) blijven bevestigd. Nieuwe details:

- [ ] Transporttype **`ws`** (remote WebSocket, push-events) ontbreekt volledig; alleen te
  configureren via `add-json` of `.mcp.json`, niet via `--transport`.
- [ ] **`managedMcpServers`** (v2.1.259+): door de organisatie aangeleverde server-configuratie
  krijgt nu de hoogste prioriteit, boven Local/Project/User.
- [ ] Veiligheidsdetail die ontbreekt en relevant is voor de security-rules van deze repo:
  credential-achtige omgevingsvariabelen (`ANTHROPIC_API_KEY`, `ANTHROPIC_AUTH_TOKEN`,
  `AWS_BEARER_TOKEN_BEDROCK`, `HTTPS_PROXY`, `NPM_TOKEN`) worden **leeg ingevuld** bij expansie
  in `url`/`headers` van `.mcp.json`, specifiek om credential-lekken naar een project-MCP-server
  te voorkomen.
- [ ] Nieuwe env-vars ontbreken: `MCP_TIMEOUT`, `MCP_TOOL_TIMEOUT`,
  `CLAUDE_CODE_MCP_TOOL_IDLE_TIMEOUT`, `CLAUDE_CODE_MCP_AUTO_BACKGROUND_MS`,
  `MCP_DISCOVERY_CACHE`, `MCP_SDK_GENERATION`, `MCP_PROTOCOL_NEGOTIATION`,
  `ENABLE_CLAUDEAI_MCP_SERVERS`, `MCP_CLIENT_SECRET`.
- Bestandspad: `wiki/40-references/claude-code/mcp.md`.

### `memory.md`

Sept-bevindingen (type-taxonomie, leeslimiet, `modified`-veld, AGENTS.md, `/import`,
`CLAUDE.local.md`, `claudeMd`-key, `paths`-budget, symlinks) blijven bevestigd. Nieuwe details:

- [ ] **`/doctor prompt-audit`** (v2.1.283+): audit-commando dat CLAUDE.md, CLAUDE.local.md,
  AGENTS.md, rules, skills, commands, subagents en output styles controleert op verouderde of
  tegenstrijdige instructies, met een rapport en voorgestelde edits (niets wordt automatisch
  gewijzigd). Draait via de bundled `/claude-api`-skill.
- [ ] **`claudeMdExcludes`**-setting: sluit specifieke CLAUDE.md-paden uit via glob-patronen,
  relevant voor monorepo's maar ontbreekt als concept bij ons.
- [ ] Mechanisme om te kiezen welke instructiebestanden laden: `pluginConfigs` onder
  `cc-plugin-agents-md@builtin`, met waarden `claude-md-or-agents-md` (standaard),
  `claude-md-and-agents-md`, `claude-md`, `managed-only`. Ook instelbaar via `/config`.
- [ ] Auto memory staat **standaard uit** in self-hosted environments (buiten Claude
  Tag-sessies), een detail dat relevant is bij het inschatten van CYRIX's eigen
  memory-gedrag afhankelijk van de omgeving.
- [ ] `autoMemoryDirectory`-setting en `CLAUDE_CODE_PROJECT_DIR_NAME`-env-var voor het
  aanpassen van de memory-opslaglocatie ontbreken.
- Bestandspad: `wiki/40-references/claude-code/memory.md`.

## Conclusie en vervolgacties

De belangrijkste nieuwe bevinding van deze cyclus is dat `agent-teams.md` een onjuist beeld
geeft: de functie is experimenteel en standaard uitgeschakeld, iets wat niet in onze referentie
staat. Daarnaast is de plugins-documentatie zo sterk geherstructureerd (met het nieuwe
Mods-concept) dat `plugins.md` een volledige her-ingest nodig heeft in plaats van alleen een
review-date-update. De zes al in september gecontroleerde pagina's blijven op detailniveau
verder achterlopen: vooral `sub-agents.md` en `mcp.md` hebben sinds september meerdere nieuwe
velden en omgevingsvariabelen gekregen.

Voorgestelde volgorde, boven op de bestaande Sept-vervolgacties:

1. `agent-teams.md` met voorrang her-ingesten vanwege de misleidende "standaard aan"-indruk.
2. `plugins.md` her-ingesten en uitbreiden met de nieuwe Mods-subsectie.
3. De vier nieuwe HOOG-pagina's (`features-overview`, `plugins/mods/*`, `cloud-environments`,
   `claude-directory`) beoordelen voor ingest.
4. Bij de volgende cyclus: `cli-reference.md`, `settings.md`, `hooks.md` als eerstvolgende
   "oudste ingest-date"-batch controleren op inhoudelijke drift (nog niet gedaan in deze of de
   vorige audit).

Deze reference-pagina's zijn niet gewijzigd door deze audit. Her-ingest gebeurt lokaal via
`/ingest`.

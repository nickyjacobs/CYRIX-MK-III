---
title: Docs-drift audit — Claude Code references
date: 2026-10-05
type: audit
category: 60-audits
status: open
tags: [audit, claude-code, docs-drift, lint]
---

# Docs-drift audit — Claude Code references (2026-10-05)

> Vergelijking van `wiki/40-references/claude-code/` met de actuele index op
> https://code.claude.com/docs/llms.txt en een steekproef van zes brondocumenten.
> Deze audit wijzigt geen referencepagina's. Re-ingest gebeurt handmatig via `/ingest`.

## Samenvatting

- Alle 24 lokale pagina's (inclusief `00-index.md`) hebben een review-date van 2026-09-09
  of 2026-09-10. Die is verlopen ten opzichte van vandaag.
- De zes oudste references (ingest-date 2026-03-26: overview, skills, sub-agents,
  agent-teams, mcp, memory) zijn vergeleken met hun huidige bronpagina. Alle zes bevatten
  concrete inhoudelijke drift, memory.md het meest.
- `slash-commands.md` en de `/cli-usage`-link in `00-index.md` zijn bevestigd dode of
  omgeleide bronnen. Dit was al bekend uit de tracking van 2026-09-10 en is dit keer
  geverifieerd.
- Nieuw gevonden sinds de vorige ronde: `plugins.md` is een losse pagina terwijl de bron nu
  een hele `plugins/`-sectie met tientallen subpagina's is, en `routines.md` bevat een
  achterhaalde beschrijving van de usage-limits (daily cap in plaats van hourly limits).
- De meeste findings uit `_tracking.md` (first-seen 2026-09-10) staan nog open; dit rapport
  bevestigt ze opnieuw in plaats van ze te dupliceren. Twee nieuwe findings zijn toegevoegd
  met first-seen 2026-10-05.

## A. Nieuwe pagina's (nog niet geïngest)

Selectie uit de volledige llms.txt-index (circa 220 pagina's), gefilterd op relevantie voor
een persoonlijke-assistent-workspace met hooks, skills, subagents en routines. Prioriteit is
HOOG/MIDDEN/LAAG voor dat gebruiksprofiel, niet voor enterprise- of SDK-gebruik.

### HOOG

- [ ] `agents.md` — "Run agents in parallel". Overzichtspagina boven sub-agents.md, legt
  parallelle agent-patronen uit die CYRIX via de `Agent`-tool al gebruikt.
  Actie: ingesten naar `wiki/40-references/claude-code/agents-overview.md`.
- [ ] `workflows.md` — "Orchestrate subagents at scale with dynamic workflows". Dekt de
  `Workflow`-tool (pipeline/parallel/phase-API) die in deze sessie beschikbaar is maar nog
  niet gedocumenteerd is in de wiki.
  Actie: ingesten, met name de workflow-authoring-conventies.
- [ ] `cross-session-messaging.md` — "Message your other Claude Code sessions". Dekt
  `SendMessage` tussen eigen sessies, relevant voor routine-naar-sessie-communicatie.
  Actie: ingesten.
- [ ] `hooks-guide.md` — "Automate actions with hooks". Conceptuele guide naast de bestaande
  `hooks.md`-referentiepagina (die alleen events/velden dekt). CYRIX gebruikt SessionEnd-hooks
  actief.
  Actie: ingesten als aanvulling op `hooks.md`, niet als vervanging.
- [ ] `scheduled-tasks.md` — "Run prompts on a schedule" (dit is de huidige bron voor `/loop`,
  losstaand van `routines.md`). Onze `skills.md` noemt `/loop` alleen zijdelings.
  Actie: ingesten.
- [ ] `claude-code-on-the-web.md` — "Use Claude Code in the cloud". Dit is exact de omgeving
  waarin deze routine zelf draait (cloud-sessie, geen lokale laptop). Nog niet geïngest.
  Actie: ingesten, hoge prioriteit gezien CYRIX' eigen routine-architectuur.
- [ ] `tools-reference.md` — volledige toolreferentie, inclusief Task-tool-beschikbaarheid die
  `agent-teams.md` en `sub-agents.md` beide citeren.
  Actie: ingesten.
- [ ] `settings-reference.md` — volledige settingslijst. Onze `settings.md` dekt alleen de
  bestandslocaties, niet de individuele keys die elders al naar deze pagina verwijzen
  (`teammateMode`, `disableBundledSkills`, `subagentPromptCacheTtl`, `claudeMdExcludes`, etc.).
  Actie: ingesten.

### MIDDEN

- [ ] `sessions.md` — "Manage sessions". Sessienaamgeving, resume-gedrag.
- [ ] `artifacts.md` — "Share session output as artifacts". De `Artifact`-tool wordt in andere
  sessies gebruikt; nog geen lokale referentie.
- [ ] `goal.md` — "Keep Claude working toward a goal". Mogelijk relevant voor routine-ontwerp.
- [ ] `common-workflows.md` / `best-practices.md` — algemene patronen, laag risico maar nuttig
  als contextpagina.
- [ ] `mcp-quickstart.md` — companion bij `mcp.md`, praktische eerste-server-flow.
- [ ] `security-guidance.md` / `code-review.md` — relevant voor de `security-reviewer`-agent
  en algemene code-review-gewoonten.
- [ ] `worktrees.md` — git worktrees, waar `isolation: worktree` (subagents) en agent-teams
  naar verwijzen.
- [ ] `remote-control.md` — genoemd in de overview-tabel, niet apart geïngest.
- [ ] `settings-example.md` — voorbeeldbestanden naast `settings-reference.md`.
- [ ] `claude-directory.md` / `context-window.md` / `prompt-caching.md` — achtergrond over
  `.claude/`-structuur en context-mechanica.

### LAAG

- [ ] `quickstart.md`, `changelog.md`, `how-claude-code-works.md`, `features-overview.md`
- [ ] `platforms.md`, `mobile.md`, `chrome.md`, `computer-use.md`, `vs-code.md`,
  `jetbrains.md`, `slack.md`, `claude-tag.md`
- [ ] `desktop*.md` (quickstart, desktop, linux, wsl, desktop-scheduled-tasks,
  ios-simulator) — relevant alleen als de eigenaar ooit lokaal met de desktop-app werkt
- [ ] `troubleshoot-install.md`, `troubleshooting.md`, `errors.md`
- [ ] `github-actions*.md`, `gitlab-ci-cd.md`, `github-enterprise-server.md`
- [ ] Alle `agent-sdk/*.md` pagina's — relevant voor het bouwen van eigen SDK-apps, niet voor
  CYRIX als eindgebruiker van Claude Code
- [ ] Interface-pagina's: `terminal-config.md`, `fullscreen.md`, `accessibility.md`,
  `voice-dictation.md`, `statusline.md`, `keybindings.md`
- [ ] Admin/enterprise-secties volledig (setup, deployment, gateways, analytics, security,
  data-usage) — niet relevant voor een single-user workspace
- [ ] `glossary.md`, `whats-new/*.md` (wekelijkse changelog-pagina's)

## B. Gewijzigde pagina's (zes oudste references, ingest-date 2026-03-26)

### `overview.md`

- [ ] **Modellen-tabel verouderd.** Onze pagina noemt `claude-opus-4-6` / `claude-sonnet-4-6`
  / `claude-haiku-4-5` als actuele aliassen. De bronpagina toont geen vaste modellen-tabel
  meer op deze plek; de huidige modelgeneratie in deze sessie draait op `claude-sonnet-5`
  met `fable`/`opus`/`haiku` als aliassen. Bevestigt eerdere tracking-entry.
  Bestand: `wiki/40-references/claude-code/overview.md`.
- [ ] **Nieuwe surfaces en workflows niet gedekt:** Claude Projects, Remote Control →
  Dispatch, `/desktop`, `claude --teleport`, `claude --cloud` (vervangt deels de oude
  "web of Claude iOS app"-rij). Ook `AGENTS.md`-ondersteuning wordt hier al genoemd.
  Actie: her-ingest, surfaces-tabel volledig vervangen.
- [ ] **Installatie-instructies uitgebreid:** Windows CMD-variant en Linux
  package-manager-install (apt/dnf/apk) ontbreken in onze samenvatting.

### `skills.md`

- [ ] **Frontmatter-velden ontbreken:** `when_to_use`, `arguments`, `disallowed-tools`,
  `background`, `paths`, `metadata`, `license`, `compatibility`. Effort-niveaus moeten
  uitgebreid worden met `xhigh`.
  Bestand: `wiki/40-references/claude-code/skills.md`.
- [ ] **Skill-locaties onvolledig:** "Nested" (`.claude/skills/` in subdirectory),
  "Additional Dir" (via `--add-dir`) en "claude.ai sync"
  (`~/.claude/skills/synced/`, genaamd `/anthropic-skills:skill`) ontbreken.
- [ ] **Bundled-skills-lijst sterk verouderd.** Onze lijst (`/batch`, `/claude-api`, `/debug`,
  `/loop`, `/simplify`) mist `/run`, `/verify`, `/run-skill-generator`, `/code-review`
  (alias `/review`), `/doctor`, `/workflow-authoring`. Onduidelijk of `/simplify` nog als
  bundled skill meetelt op de bron; controleren bij re-ingest.
- [ ] **String-substituties onvolledig:** `$name` (named arguments), `${CLAUDE_EFFORT}`,
  `${CLAUDE_PROJECT_DIR}` ontbreken.

### `sub-agents.md`

- [ ] **Frontmatter-velden ontbreken:** `omitClaudeMd`, `color`, `experimental`
  (bijv. `cacheTtl`). `permissionMode` moet `auto` en `manual` bevatten naast de bestaande
  waarden. Model-aliassen moeten `fable` bevatten.
  Bestand: `wiki/40-references/claude-code/sub-agents.md`.
- [ ] **Built-in-agents-tabel klopt niet meer.** Onze tabel zegt Explore draait op Haiku.
  De bron zegt nu: model van de main conversation (of Opus op sommige providers wanneer
  main Fable gebruikt). Dit is een directe inhoudelijke correctie, geen uitbreiding.

### `agent-teams.md`

- [ ] **Hook-tabel incompleet:** `TaskCreated` ontbreekt naast de bestaande
  `TeammateIdle`/`TaskCompleted`.
  Bestand: `wiki/40-references/claude-code/agent-teams.md`.
- [ ] **Display-modes onvolledig:** `iterm2` als expliciete modus ontbreekt naast
  in-process/tmux/auto.
- [ ] **Nieuwe mechanismen niet gedekt:** teammates kunnen nu gespawned worden vanuit een
  subagent-definitie, model-selectievolgorde voor teammates (incl.
  `CLAUDE_CODE_SUBAGENT_MODEL_FORCE`), `subagentPromptCacheTtl`-setting, uitgebreide
  troubleshooting (orphaned tmux-sessies, mailbox-foutafhandeling), en de beperking dat een
  in-process teammate geen eigen background-subagents kan starten.
  Actie: substantiële her-ingest, niet alleen een patch.

### `mcp.md`

- [ ] **Transport-nuance ontbreekt.** HTTP is nu de aanbevolen transport, SSE is deprecated
  met automatische fallback, WebSocket heeft geen `--transport`-flag (alleen JSON-config).
  Onze pagina behandelt alle vier als gelijkwaardig.
  Bestand: `wiki/40-references/claude-code/mcp.md`.
- [ ] **CLI-commando's onvolledig:** `claude mcp get`, `add-json`, `add-from-claude-desktop`,
  `reset-project-choices`, `login`/`logout`, `serve`, en `/mcp reconnect all` ontbreken.
- [ ] **Settings onvolledig:** `disableClaudeAiConnectors`, `allowAllClaudeAiMcps` ontbreken.
- [ ] **Nieuwe concepten niet gedekt:** MCP runtime v1/v2 met protocol-onderhandeling,
  discovery cache, automatische backgrounding van lange tool calls (&gt;2 min), plugin-MCP
  servers, cloud-sessie connector-routing via Anthropic's servers.

### `memory.md`

- [ ] **AGENTS.md-ondersteuning ontbreekt volledig.** De bron behandelt nu uitgebreid wanneer
  Claude `AGENTS.md` leest in plaats van of naast `CLAUDE.md`, inclusief de
  `pluginConfigs` → `agents-md@builtin` → `instructionFiles`-setting
  (`claude-md-or-agents-md`, `claude-md-and-agents-md`, `claude-md`, `managed-only`).
  Bestand: `wiki/40-references/claude-code/memory.md`.
- [ ] **Directe tegenspraak over import-diepte.** Onze pagina zegt "max 5 niveaus diep",
  de bron zegt nu expliciet "maximum depth of four hops". Dit is geen uitbreiding maar een
  correctie: controleren welke waarde klopt bij re-ingest.
- [ ] **Auto-memory-limiet onvolledig.** Onze pagina noemt alleen "eerste 200 regels"; de bron
  specificeert "eerste 200 regels OF 25KB, wat eerst komt".
- [ ] **Nieuwe auto-memory-taxonomie ontbreekt:** vier types (`user`, `feedback`, `project`,
  `reference`) als `type`-veld in frontmatter, plus een `modified`-ISO-timestamp-veld.
- [ ] **Nieuwe commando's/instellingen ontbreken:** `/doctor prompt-audit`,
  `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD`, uitgebreide `claudeMdExcludes`-regels
  (glob-budget, symlink-netwerkpad-restricties).
  Actie: dit is de pagina met de meeste drift van de zes. Volledige her-ingest aanbevolen
  in plaats van een incrementele patch.

## C. Verdwenen of hernoemde pagina's

- [ ] `slash-commands.md` — bronpagina `https://code.claude.com/docs/en/slash-commands`
  toont nu de inhoud van de Skills-pagina (redirect/merge bevestigd). De lokale pagina
  markeert dit al als "gemerged met Skills", maar de bron zelf bestaat niet meer los.
  Bestand: `wiki/40-references/claude-code/slash-commands.md`.
  Actie: pagina laten vervallen of samenvoegen in `skills.md` bij volgende re-ingest.
  (Bevestigt tracking-entry van 2026-09-10, geen nieuwe rij nodig.)
- [ ] `cli-usage` — de link in `00-index.md` (regel 24, "CLI reference" →
  `https://code.claude.com/docs/en/cli-usage`) bestaat niet meer in de huidige index.
  De werkelijke bron is `https://code.claude.com/docs/en/cli-reference`, wat
  `cli-reference.md` zelf al correct citeert.
  Bestand: `wiki/40-references/claude-code/00-index.md`.
  Actie: regel 24 corrigeren naar `/cli-reference`. (Bevestigt tracking-entry van
  2026-09-10.)
- [ ] **Nieuw: `plugins.md` is structureel achterhaald.** Onze pagina behandelt plugins als
  één pagina onder `https://code.claude.com/docs/en/plugins`. De bron is nu een hele sectie
  `plugins/` met minstens 25 subpagina's (`plugins/overview.md`, `install.md`, `create.md`,
  `components.md`, `security.md`, `manifest-reference.md`, `marketplace-reference.md`,
  `mods/*.md`, etc.). De oude URL redirect naar `plugins/overview.md`.
  Bestand: `wiki/40-references/claude-code/plugins.md`.
  Actie: her-ingest als meerdere pagina's in plaats van één samenvatting, minstens
  `plugins/overview.md`, `plugins/install.md`, `plugins/create.md` en
  `plugins/manifest-reference.md`.

## D. Verlopen review-dates

- [ ] Alle 24 bestanden in `wiki/40-references/claude-code/` (inclusief `00-index.md`) hebben
  een review-date van 2026-09-09 of 2026-09-10. Vandaag is 2026-10-05, dus elke pagina is
  verlopen. Dit bevestigt de bestaande tracking-rij "Alle 23 claude-code-references hebben
  verlopen review-date" (first-seen 2026-09-10); geen nieuwe rij toegevoegd.
  Actie: her-ingest-cyclus plannen, prioriteit op basis van sectie B hierboven (memory.md en
  agent-teams.md eerst, gezien de omvang van de drift).

## Nieuwe tracking-entries (first-seen 2026-10-05)

Twee findings zijn nieuw ten opzichte van de vorige audit (2026-09-10) en toegevoegd aan
`_tracking.md`:

1. Structurele drift `plugins.md` (zie sectie C).
2. Content-drift `routines.md`: de pagina beschrijft nu hourly limits per actietype
   (scheduled/one-off: 100/uur per account; Run now/API-fires: 30/uur per routine) in plaats
   van de "daily run cap" die onze lokale pagina noemt. Onze pagina zegt ook expliciet dat
   one-off runs NIET tegen de cap tellen; de bron zegt nu dat one-off runs WEL tegen de
   hourly limit tellen. Dit is een directe tegenspraak, relevant omdat deze audit zelf als
   routine draait.
   Bestand: `wiki/40-references/claude-code/routines.md`.

---
title: Docs-drift audit Claude Code references
date: 2026-10-26
type: audit
category: 60-audits
status: open
tags: [audit, claude-code, docs-drift, lint]
---

# Docs-drift audit: Claude Code references (2026-10-26)

Vergelijking van `wiki/40-references/claude-code/` met de actuele documentatie-index op
`https://code.claude.com/docs/llms.txt`. Vervolg op de audit van 2026-09-10: die drift staat
nog open (niets is lokaal opnieuw geingest), plus nieuwe bevindingen uit deze cyclus.

## 1. Verlopen review-dates

Nog steeds van toepassing, ongewijzigd ten opzichte van 2026-09-10. Alle 23 pagina's in
`wiki/40-references/claude-code/` hebben een `review-date` van `2026-09-09` of `2026-09-10`.
Vandaag is `2026-10-26`, dus elke referentie staat nu ruim 45 dagen over de vervaldatum.

- [ ] Alle 23 referenties opnieuw ingesten via `/ingest`. Bestandspad: `wiki/40-references/claude-code/*.md` + `00-index.md`.

## 2. Verdwenen of hernoemde bronnen

- [ ] **`slash-commands.md`** (nog open, zie audit 2026-09-10). Bron-URL `/docs/en/slash-commands` bestaat nog niet in de index. Geen wijziging deze cyclus. Bestandspad: `wiki/40-references/claude-code/slash-commands.md`.
- [ ] **Nieuw deze cyclus: `plugins.md`** verwijst naar `https://code.claude.com/docs/en/plugins`. Die URL geeft nog wel geldige content terug, maar staat niet meer als los item in `llms.txt`; de index vermeldt nu uitsluitend `https://code.claude.com/docs/en/plugins/overview.md` ("Plugins overview"). Geen harde breuk zoals bij `slash-commands.md`, maar wel een signaal dat de pagina intern verhuisd is naar de `plugins/`-substructuur. Bij her-ingest de frontmatter `source-url` controleren en zo nodig bijwerken naar de `/plugins/overview`-vorm. Bestandspad: `wiki/40-references/claude-code/plugins.md`.

## 3. Nieuwe pagina's (nog niet geingest)

De vorige audit (2026-09-10) had al een lijst met HOOG/MIDDEN/LAAG-pagina's; die staat nog
open (zie `_tracking.md`) en wordt hier niet herhaald. Onderstaand uitsluitend wat deze cyclus
**voor het eerst** is opgevallen.

### Prioriteit HOOG (nieuw deze cyclus)

| Pagina | Bron | Waarom |
|---|---|---|
| Mods: overview, create, reference, interface, gallery, events, api, test, troubleshoot, admin | `/docs/en/plugins/mods/*` (10 pagina's) | Volledig nieuw subsysteem: plugins kunnen nu een "hooks module" (mod) bevatten die in JavaScript draait, panes tekent in de UI en op events reageert. Sommige mods zijn built-in. Dit raakt direct de bestaande `plugin-authoring`-skill in deze workspace, die al over "mods" spreekt zonder dat wij er een referentie voor hebben. |
| Explore the .claude directory | `/docs/en/claude-directory` | Beschrijft elk bestand dat Claude Code leest in `.claude/`, inclusief `~/.claude.json` (het vijfde, zelf-beheerde bestand). Direct relevant voor hoe deze repo's `.claude/`-structuur in elkaar zit. |

### Prioriteit MIDDEN (nieuw deze cyclus)

| Pagina | Bron | Waarom |
|---|---|---|
| Catch security issues as Claude writes code | `/docs/en/security-guidance` | Los van de al getrackte "Code Review"-pagina; relevant voor `security-reviewer`-agent en `security-context.md`-rule. |
| Scan your codebase for vulnerabilities | `/docs/en/claude-security` | Idem, security-scanfunctionaliteit los van code review. |
| Set up Code Review / Customize Code Review / Read and request reviews / Code Review costs / Troubleshoot Code Review | `/docs/en/code-review-setup`, `-customize`, `-pull-requests`, `-costs`, `-troubleshooting` | De al getrackte "Code Review"-pagina is uitgegroeid tot een sectie van 6 pagina's. Alleen de overzichtspagina stond al op onze MIDDEN-lijst. |

### Niet opnieuw beoordeeld

Enterprise-, gateway-, zelf-hosting-, GitHub Actions/GitLab CI- en Agent SDK-secties zijn
deze cyclus niet opnieuw doorlopen; daar is sinds september niets veranderd aan de
prioriteitsinschatting (niet relevant voor een single-user, niet org-beheerde workspace).

- [ ] Nieuwe HOOG-pagina's (mods-subsysteem, claude-directory) beoordelen voor `/ingest`. Bestandspad (doel): `wiki/40-references/claude-code/`.

## 4. Inhoudelijke wijzigingen op bestaande referenties

Zes referenties gecontroleerd, gekozen op oudste `ingest-date` die de vorige audit nog niet
behandelde. De zes pagina's met `ingest-date: 2026-03-26` die vorige keer al gecontroleerd zijn
(`overview.md`, `skills.md`, `sub-agents.md`, `agent-teams.md`, `mcp.md`, `memory.md`) zijn
deze cyclus overgeslagen; hun vorige bevindingen staan nog open in `_tracking.md`. In plaats
daarvan de resterende drie pagina's met `ingest-date: 2026-03-26` (`cli-reference.md`,
`settings.md`, `hooks.md`) plus drie met `ingest-date: 2026-06-09` (`routines.md`,
`output-styles.md`, `slash-commands.md`/`commands.md`).

### `cli-reference.md`

Onze referentie heeft al een "Update 2026-06-10"-addendum met de attach/logs/stop/respawn/rm/
daemon-commando's. Sindsdien is de CLI-oppervlakte verder flink gegroeid.

- [ ] Nieuwe top-level commando's die volledig ontbreken: `claude gateway` (self-hosted Claude apps gateway server), `claude install [version]`, `claude import [codex|gemini|cursor]`, `claude kill`, `claude purge [path]`, `claude self-hosted-runner <doctor|orchestrator|setup>`, `claude mcp login/logout <naam>`, `claude mcp serve`, `claude auto-mode config/reset`, `claude plugins` (los van `claude plugin`), `claude daemon run` en `claude daemon logs` (naast het al genoteerde `daemon status/stop`).
- [ ] Nieuwe flags die ontbreken: `--environment`, `--ref`, `--cloud`, `--desktop`, `--restricted`, `--safe-mode`, `--session-id`, `--setting-sources`, `--system-prompt-snapshot`, `--exclude-dynamic-system-prompt-sections`, `--append-subagent-system-prompt[-file]`, `--autocompact`, `--ax-screen-reader`, `--disable-slash-commands`, `--plugin-dir`/`--plugin-url`, `--prompt-suggestions`, `--replay-user-messages`, `--forward-subagent-text`, `--include-hook-events`/`--include-partial-messages`, `--no-session-persistence`, `--permission-prompts`, `--dry-run`/`--yes` (bij `import`/`purge`).
- Bestandspad: `wiki/40-references/claude-code/cli-reference.md`.

### `settings.md`

Dit is geen gewone content-drift maar een paginasplitsing.

- [ ] De bronpagina is herschreven van een platte settings-tabel naar "Settings files and precedence": scopes, precedence, troubleshooting en een nieuwe sectie "Settings in cloud sessions" (relevant, want deze CYRIX-sessie draait zelf in een cloud-omgeving en leest dus niet dezelfde bestanden als een lokale sessie). De key-voor-key tabel die wij nu inline hebben, staat nu op de apart gepubliceerde pagina `settings-reference.md` ("All settings"), die al als HOOG-missend getrackt staat.
- [ ] Nieuw: vijfde bestand `~/.claude.json` (door Claude Code zelf beheerd, niet handmatig bewerken) ontbreekt in onze bestandenlijst.
- [ ] Nieuw: tabel met uitzonderingen op managed-settings-precedentie (bv. `disableClaudeAiConnectors`, `enableArtifact`, `isolatePeerMachines` die altijd de strengste waarde winnen, ongeacht scope).
- [ ] `/status` → `Setting sources`-regel en `claude doctor` voor afgekeurde entries ontbreken als troubleshooting-stap.
- Bestandspad: `wiki/40-references/claude-code/settings.md`.

### `hooks.md`

- [ ] Event-aantal is nu 33 (ons "Update 2026-06-10"-addendum noemt circa 28). Nieuwe events die zelfs in dat addendum nog ontbreken: `DirectoryAdded`, `PreModelSwitch`, `PostModelSwitch`.
- [ ] Nieuwe velden die in onze referentie (ook na het addendum) ontbreken: `if` (permission-rule-filter op tool-events), `onFailure: "block"` (v2.1.295+, stopt de actie bij hook-fout/timeout), `retry` op `PermissionDenied` (laat het model een geweigerde tool-call opnieuw proberen), `displayContent` op `MessageDisplay`, `initialUserMessage`/`watchPaths`/`reloadSkills` als SessionStart-outputvelden, `terminalSequence`.
- [ ] Nieuwe admin-controls ontbreken: `allowManagedHooksOnly`, `allowedHttpHookUrls`, `httpHookAllowedEnvVars`, `disableCommandPluginSources`, `strictPluginOnlyCustomization`.
- [ ] Nieuwe limieten ontbreken: 10.000-tekenslimiet op `additionalContext`/`systemMessage`/`initialUserMessage`, maximaal 12 gelijktijdige prompt/agent-hooks, 1.024 hooks per skill-source (v2.1.304+).
- Bestandspad: `wiki/40-references/claude-code/hooks.md`.

### `routines.md`

- [ ] Herbranding: de pagina heet nu "Automate work with scheduled tasks" met de expliciete toevoeging "formerly routines". De naam "Routines" blijft alleen nog bestaan in: de webadres-slug `claude.ai/code/routines`, de CLI-alias `/routines`, het `/fire`-API-endpoint, de beta-header en de org-toggle "Scheduled tasks (Was Routines)". Onze referentie gebruikt nog overal de oude framing zonder dit te vermelden. Dit is exact de routine die deze audit zelf laat draaien, dus praktisch relevant.
- [ ] GitHub-trigger kent nu een extra event: naast pull request en release kan ook op **Issue**-events getriggerd worden. Filter-operators staan nu preciezer omschreven: equals, contains, starts with, is one of, is not one of, matches regex (onze referentie noemt alleen "regex" generiek).
- [ ] Usage-limieten zijn nu concreet gespecificeerd: 100 scheduled runs/uur per account, 30 "Run now"/API-fires/uur per taak, 100 "Run now"/uur per account, 100 API-fires/uur per account. Onze referentie noemt alleen vaag "Daily run cap per account".
- [ ] Nieuwe sectie "When a run publishes an artifact without asking": in auto mode publiceert Claude een artifact zonder te vragen zodra de classifier dat toestaat; buiten auto mode (Accept Edits) alleen onder een reeks voorwaarden (eigen organisatie, geen gedeeld artifact, geen runtime-capabilities, etc). Dit ontbreekt volledig en is relevant omdat deze workspace het Artifact-tool gebruikt.
- [ ] `/schedule why did ... ` (leest run-log en legt permission-denials/tool-errors uit, v2.1.227+) ontbreekt als CLI-mogelijkheid.
- [ ] Zelf-hosted-omgevingen als uitvoeringslocatie voor scheduled tasks (naast Anthropic-cloud) ontbreekt.
- [ ] API-fires worden gewrapt in een `<routine-fire-payload>`-blok dat expliciet als untrusted data gelabeld is; dit mechanisme staat niet in onze referentie, terwijl het relevant is voor iedereen die de API-trigger gebruikt.
- Bestandspad: `wiki/40-references/claude-code/routines.md`.

### `output-styles.md`

- [ ] **Ontbrekende built-in style:** naast Proactive, Explanatory en Learning bestaat nu ook **Concise** (v2.1.237+, responses leiden met het resultaat, geen inleiding/narratie). Onze referentie noemt deze stijl nergens.
- [ ] **Verouderd/onjuist:** onze referentie zegt dat een stijlwissel "treedt in werking na `/clear` of nieuwe sessie". Sinds v2.1.237+ is er een `/output-style`-commando, en sinds v2.1.251 geldt een nieuwe stijl al vanaf het volgende bericht in de lopende sessie, zonder `/clear`. Dit is een feitelijke fout in de huidige tekst, geen ontbrekende aanvulling.
- [ ] VS Code-extensie heeft een eigen "Output styles"-menu (v2.1.257+) waarmee ook custom styles gekozen kunnen worden; ontbreekt in onze referentie.
- Bestandspad: `wiki/40-references/claude-code/output-styles.md`.

### `slash-commands.md` / `commands.md`

De merge van custom commands met skills klopt nog (bevestigd in de live pagina), maar de
bundled-skills-lijst is sterk verouderd.

- [ ] Onze referentie noemt 7 bundled skills (`/code-review`, `/batch`, `/debug`, `/loop`, `/claude-api`, `/run`, `/verify`, `/run-skill-generator`). De actuele lijst is veel langer en bevat onder meer: `/artifact-capabilities`, `/artifact-diagramming`, `/dataviz`, `/deep-research` (nieuw "Workflow"-type, geen skill), `/design`, `/design-sync`, `/doctor` (incl. `prompt-audit`), `/fewer-permission-prompts`, `/import`, `/plugin-authoring`, `/reload-skills`, `/simplify`, `/skill-doctor`, `/skills`, `/slides`, `/update-config`, `/workflow-authoring`. Van deze lijst zijn `/plugin-authoring`, `/workflow-authoring`, `/dataviz`, `/update-config`, `/artifact-capabilities` en `/artifact-diagramming` al actief beschikbaar in deze CYRIX-sessie zelf, dus de referentie mist skills die hier al in gebruik zijn.
- [ ] Nieuw commando-type **Workflow** (bundled dynamic workflow, bv. `/deep-research`) staat naast Skill als eigen categorie; onze referentie kent alleen built-in/bundled-skill/custom-skill.
- Bestandspad: `wiki/40-references/claude-code/slash-commands.md` en `commands.md`.

## Conclusie en vervolgacties

Geen enkele bevinding uit de audit van 2026-09-10 is opgelost: er is sinds die datum niets
lokaal opnieuw geingest, dus alle findings uit die cyclus blijven open naast de nieuwe
bevindingen hierboven. De drift is breed: een nieuw plugin-subsysteem (mods) dat al impliciet
in gebruik is via de `plugin-authoring`-skill, een paginasplitsing bij settings, een
ontbrekende output-style, en een flink uitgedijde CLI- en bundled-skills-lijst.

Voorgestelde volgorde, boven op de volgorde uit de vorige audit:

1. `routines.md` her-ingesten voor de rebranding naar "scheduled tasks" en het
   artifact-publiceergedrag; deze pagina beschrijft de routine die deze audit zelf draait.
2. Mods-subsysteem (10 pagina's) en `claude-directory.md` toevoegen.
3. `output-styles.md` corrigeren (Concise-stijl, juiste timing van stijlwissel).
4. Overige wijzigingen uit sectie 4 verwerken bij de geplande her-ingest-cyclus.

Deze reference-pagina's zijn niet gewijzigd door deze audit. Re-ingest gebeurt lokaal via
`/ingest`.

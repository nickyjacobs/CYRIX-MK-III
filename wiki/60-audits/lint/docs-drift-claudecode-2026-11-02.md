---
title: Docs-drift audit Claude Code references
date: 2026-11-02
type: audit
category: 60-audits
status: open
tags: [audit, claude-code, docs-drift, lint]
---

# Docs-drift audit: Claude Code references (2026-11-02)

Vergelijking van `wiki/40-references/claude-code/` met de actuele documentatie-index op
`https://code.claude.com/docs/llms.txt`. Dit is de tweede cyclus van deze audit, na
2026-09-10. Geen van de destijds voorgestelde re-ingests is lokaal uitgevoerd: alle
ingest-dates en review-dates staan nog op hun waarde van juni 2026, en de twee eerder
gemelde kapotte links staan er nog. Deze audit herbevestigt die openstaande findings en
voegt nieuwe drift toe die sinds september is ontstaan of destijds gemist is.

## 1. Verlopen review-dates

Alle 23 pagina's in `wiki/40-references/claude-code/` hebben een `review-date` van
`2026-09-09` of `2026-09-10`. Vandaag is het `2026-11-02`, dus elke referentie staat
inmiddels ongeveer 54 dagen over de review-date heen. Dit is dezelfde verzameling als in
de vorige audit, nu verder verouderd.

- [ ] Alle 23 referenties in `wiki/40-references/claude-code/` opnieuw ingesten via `/ingest` en nieuwe review-dates zetten. Bestandspad: `wiki/40-references/claude-code/*.md` + `00-index.md`.

## 2. Verdwenen of hernoemde bronnen

Beide findings uit de vorige cyclus zijn nog steeds actueel, bevestigd tegen de huidige
`llms.txt`-index.

- [ ] **`slash-commands.md`** verwijst naar `https://code.claude.com/docs/en/slash-commands`. Deze URL staat nog steeds niet in de actuele docs-index. De inhoud blijft opgegaan in `https://code.claude.com/docs/en/commands`, wat wij al apart hebben als `commands.md`. Voorgestelde actie ongewijzigd: markeren als `status: superseded` of resterende unieke inhoud overzetten naar `commands.md`. Bestandspad: `wiki/40-references/claude-code/slash-commands.md`.
- [ ] **`00-index.md`** vermeldt voor "CLI reference" nog steeds de bron-URL `https://code.claude.com/docs/en/cli-usage`, die niet bestaat. De correcte URL is `https://code.claude.com/docs/en/cli-reference`, wat al wel klopt in de frontmatter van `cli-reference.md` zelf. Bestandspad: `wiki/40-references/claude-code/00-index.md`, regel 24.

## 3. Nieuwe pagina's (nog niet geingest)

De volledige HOOG/MIDDEN/LAAG-catalogus uit de audit van 2026-09-10 blijft geldig: geen van
die pagina's is sindsdien geingest (hooks-guide, scheduled-tasks, settings-reference,
workflows, agents, cross-session-messaging, tools-reference blijven prioriteit HOOG). Deze
sectie beschrijft alleen wat er sinds september is bijgekomen of destijds niet als apart
item was opgemerkt.

### Nieuw sinds 2026-09-10, prioriteit HOOG

| Pagina | Bron | Waarom |
|---|---|---|
| Explore the .claude directory | `/docs/en/claude-directory` | Beschrijft precies de map-structuur die deze repo gebruikt (rules, skills, agents, cleanup-gedrag). Direct toepasbaar op hoe CYRIX zelf is opgezet. |
| Let Claude coordinate ongoing work with Projects | `/docs/en/claude-projects` | Nieuw concept "Projects" voor het coordineren van lopende, parallelle sessies. Mogelijk overlap of aanvulling op onze eigen `wiki/10-projects/`-structuur, dus relevant om te begrijpen voor conflict-vermijding. |

### Nieuw sinds 2026-09-10, prioriteit MIDDEN

| Pagina | Bron | Waarom |
|---|---|---|
| Configure the sandboxed Bash tool | `/docs/en/sandboxing` | Beschrijft hoe de Bash-tool in cloud-omgevingen gesandboxed wordt. Relevant omdat deze routine zelf in zo'n cloud-omgeving draait. |
| Choose a sandbox environment / Configure cloud environments | `/docs/en/sandbox-environments`, `/docs/en/cloud-environments` | Directe achtergrond bij hoe deze sessie zelf geconfigureerd is; eerder al relevant gevonden voor vragen over de huidige container. |
| Catch security issues as Claude writes code / Scan your codebase for vulnerabilities | `/docs/en/security-guidance`, `/docs/en/claude-security` | Sluit aan op `.claude/rules/security-context.md`, relevant voor een security-professional-profiel. |
| Explore the context window | `/docs/en/context-window` | Relevant voor het begrijpen van de lazy-lookup-strategie en wat compaction overleeft. |

### Nieuw sinds 2026-09-10, prioriteit LAAG

Code-review-cluster (`code-review-local`, `ultrareview`, `code-review-setup`,
`code-review-customize`, `code-review-pull-requests`, `code-review-costs`,
`code-review-troubleshooting`), desktop-app-cluster (`desktop-quickstart`, `desktop`,
`desktop-linux`, `desktop-wsl`, `desktop-ios-simulator`), `plugins/mods/*` (nieuwe
UI-customization-feature, acht pagina's), `mobile.md`, `chrome.md`, `computer-use.md`,
`how-claude-code-works.md`, `features-overview.md`, `prompt-caching.md`,
`settings-example.md`, `large-codebases.md`, `troubleshoot-install.md`,
`auto-mode-classifier-billing.md`, `web-quickstart.md`. Geen van deze sluit direct aan op
hoe CYRIX als persoonlijke-assistent-workspace wordt gebruikt.

- [ ] Nieuwe HOOG- en MIDDEN-pagina's uit deze sectie beoordelen voor `/ingest`, naast de reeds openstaande lijst van 2026-09-10. Bestandspad (doel): `wiki/40-references/claude-code/`.

## 4. Inhoudelijke wijzigingen op bestaande referenties

Zes referenties gecontroleerd: dezelfde zes met de oudste `ingest-date` (2026-03-26) als
in de vorige cyclus, aangezien er sinds 2026-09-10 geen re-ingest heeft plaatsgevonden en
deze dus opnieuw de oudste zijn. Alle findings uit de vorige audit blijven staan en zijn
herbevestigd tegen de huidige brontekst. Hieronder alleen wat **nieuw** is ten opzichte
van de audit van 2026-09-10.

### `overview.md`

- [ ] De pagina-titel in de officiele navigatie voor cloud scheduled tasks is veranderd: `routines.md` (bron `/docs/en/routines`, URL ongewijzigd) heet in de huidige docs "Automate work with scheduled tasks", met de tekst "Cloud scheduled tasks, formerly routines". Onze lokale titel "Claude Code, Routines" dekt dit niet meer. Dit is gesignaleerd via `overview.md`; `routines.md` zelf is deze cyclus niet los gecontroleerd (zat niet in de zes oudste bestanden) en is kandidaat voor de volgende cyclus.
- [ ] Nieuw CLI-commando genoemd: `/schedule` om een cloud scheduled task vanaf de CLI aan te maken. Staat nog niet in onze referenties.
- [ ] De surfaces-tabelrij "Taken starten lokaal, voortzetten op mobiel" is in de bron gewijzigd naar `claude --cloud` gevolgd door de Claude mobile app (was: "Web of Claude iOS app"). Kleine maar concrete wijziging t.o.v. onze huidige tekst.
- Bestandspad: `wiki/40-references/claude-code/overview.md`.

### `skills.md`

- [ ] De bundled-skills-onzekerheid uit september is opgehelderd: de bron bevestigt nu expliciet dat `/simplify` een bundled skill is. Volledige actuele lijst: `/doctor`, `/code-review`, `/batch`, `/debug`, `/loop`, `/claude-api`, `/verify`, `/run`, `/run-skill-generator`, `/simplify`, en `/workflow-authoring` (alleen beschikbaar wanneer dynamic workflows aanstaan).
- [ ] Default-waarden nu expliciet gedocumenteerd: `disable-model-invocation` default `false`, `user-invocable` default `true`. Niet fout bij ons, maar ontbreekt als expliciete vermelding.
- Bestandspad: `wiki/40-references/claude-code/skills.md`.

### `sub-agents.md`

- [ ] **Gemist in de vorige audit:** de model-resolutievolgorde die in onze eigen referentie staat (regels 73-78: eerst `CLAUDE_CODE_SUBAGENT_MODEL` env var, dan per-invocatie parameter, dan subagent-definitie, dan main model) is de **oude** volgorde van voor v2.1.251. De huidige volgorde is: (1) per-invocatie `model`-parameter op de Agent tool call, (2) subagent-definitie's `model`-frontmatter, (3) `CLAUDE_CODE_SUBAGENT_MODEL` indien gezet, (4) main conversation's model. Dit stond al impliciet in de wijziging die de september-audit bij `agent-teams.md` noemde, maar is niet apart gevlagd voor `sub-agents.md` zelf, waar de volgorde letterlijk in de tekst staat.
- [ ] Nieuwe frontmatter-velden niet in september-lijst: `autoCompactWindow` (vereist v2.1.296+) en `omitClaudeMd` (vereist v2.1.271+, slaat user/project/local CLAUDE.md over).
- [ ] Nieuwe env-vars niet in september-lijst: `CLAUDE_CODE_FORK_SUBAGENT` (fork-modus uitschakelen), `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH` (default 3), `CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS` (default 20, vereist v2.1.217+), `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS`, `CLAUDE_CODE_EFFORT_LEVEL`.
- [ ] Explore-model-beschrijving is preciezer dan de septembersamenvatting: op een Claude-abonnement, Console-account of gateway via `ANTHROPIC_BASE_URL` draait Explore op het model van de `opus`-alias; op Bedrock, Vertex, Foundry, Claude Platform on AWS, of een Claude apps gateway blijft Explore op het main-model.
- Bestandspad: `wiki/40-references/claude-code/sub-agents.md`.

### `agent-teams.md`

- [ ] **Nieuwe functionaliteit, niet eerder vastgelegd:** het inschakelen van agent teams verandert ook gewoon subagent-gedrag. Zodra `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` staat, start een subagent die Claude zelf een naam geeft (wat Claude autonoom doet om later te kunnen berichten) automatisch als teammate in plaats van als gewone subagent, ook als de gebruiker geen team heeft gevraagd. Dit kan onbedoeld team-vorming en hogere tokenkosten veroorzaken. Uitschakelen vereist expliciet `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=0`, waarbij hogere-precedentie settings (project, local, managed) dit weer kunnen overschrijven. Relevant om te documenteren voordat deze experimentele flag ooit aangezet wordt in deze repo.
- [ ] Teammates erven de permissiemodus van de lead, **behalve** `dontAsk`-modus, die niet wordt overgenomen. Niet in onze referentie.
- Bestandspad: `wiki/40-references/claude-code/agent-teams.md`.

### `mcp.md`

Geen nieuwe drift gevonden ten opzichte van de septembercyclus; alle destijds gemelde
items (Local-scope, SSE-deprecation, nieuwe CLI-commando's, nieuwe settings-keys,
env-var-expansion, `MAX_MCP_OUTPUT_TOKENS`) zijn herbevestigd tegen de huidige bron.
Aanvullend gevonden: `allowAllClaudeAiMcps` kon niet terugvinden worden in de huidige
brontekst binnen het gelezen gedeelte; mogelijk verwijderd, hernoemd, of verderop in de
pagina (pagina is te lang om in een keer te lezen). Kandidaat om bij de volgende cyclus
met een gerichte fetch te bevestigen.

### `memory.md`

Alle septemberfindings herbevestigd (type-taxonomie, 200-regels/25KB-limiet,
`modified`-veld, AGENTS.md, CLAUDE.local.md-locatie, settings). Aanvullend gevonden,
niet in september gemeld:

- [ ] Nieuw `/import`-commando-detail: haalt niet alleen instructiebestanden over, maar ook MCP-servers, commands, subagents en skills van een ander ondersteund coding-agent-formaat.
- [ ] Nieuw: `/doctor prompt-audit` command om CLAUDE.md, CLAUDE.local.md, AGENTS.md, rules, skills, commands, subagents en output styles te auditten op verouderde of tegenstrijdige inhoud. Vereist v2.1.283+.
- [ ] CLAUDE.md-laadvolgorde is preciezer gedocumenteerd dan bij ons: van filesystem-root naar working directory, met `CLAUDE.local.md` steeds na `CLAUDE.md` binnen elke directory.
- [ ] Nieuw per-bestand limiet voor subdirectory-CLAUDE.md en path-scoped rules die on-demand laden: 40.000 karakters bij 200K-contextvenster, 200.000 (Opus/Sonnet 4.6) of 150.000 (latere modellen) bij 1M-contextvenster. Dit is een ander, strenger limiet dan de algemene 4 MiB-grens voor bij-launch-geladen CLAUDE.md.
- Bestandspad: `wiki/40-references/claude-code/memory.md`.

## Conclusie en vervolgacties

De drift is sinds 2026-09-10 verder toegenomen, niet opgelost. Geen van de eerder
voorgestelde acties is uitgevoerd: beide kapotte links staan er nog, alle 23 referenties
zijn nu ongeveer acht weken over hun review-date, en de HOOG-prioriteit-pagina's uit
september zijn niet geingest. Daarnaast is nieuwe drift gevonden: vier nieuwe
kandidaatpagina's (waarvan twee HOOG), een gemiste model-resolutievolgorde-wijziging in
`sub-agents.md`, en een niet eerder vastgelegd gedrag waarbij het inschakelen van agent
teams onbedoeld teamvorming kan veroorzaken bij gewone subagent-delegatie.

Voorgestelde volgorde, ongewijzigd ten opzichte van september plus de aanvullingen van
deze cyclus:

1. `slash-commands.md` afhandelen (superseded-markering of samenvoegen met `commands.md`).
2. `00-index.md` CLI-reference-link corrigeren.
3. Her-ingest van de zes gecontroleerde pagina's (`overview.md`, `skills.md`,
   `sub-agents.md`, `agent-teams.md`, `mcp.md`, `memory.md`), met de concrete wijzigingen
   uit deze en de vorige audit als checklist.
4. `routines.md` meenemen bij de volgende cyclus voor een volledige page-fetch (titel is
   gewijzigd in de bron, inhoud niet gecontroleerd).
5. Nieuwe HOOG-prioriteit pagina's ingesten: de zeven uit september plus
   `claude-directory.md` en `claude-projects.md` uit deze cyclus.
6. Overige referenties blijven qua inhoud ongecontroleerd buiten hun verlopen
   review-date; volgende cyclus weer de zes oudste `ingest-date`-bestanden selecteren
   (die na een her-ingest zullen verschuiven).

Deze reference-pagina's zijn niet gewijzigd door deze audit. Re-ingest gebeurt lokaal via
`/ingest`.

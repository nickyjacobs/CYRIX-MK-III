---
title: Docs-drift audit Claude Code references
date: 2026-09-14
type: audit
category: 60-audits
status: open
tags: [audit, claude-code, docs-drift, lint]
---

# Docs-drift audit: Claude Code references (2026-09-14)

Vervolg op de audit van 2026-09-10. Vergelijking van `wiki/40-references/claude-code/` met
`https://code.claude.com/docs/llms.txt`. Er is geen enkele reference lokaal opnieuw
geingest sinds vorige week: alle ingest-dates zijn ongewijzigd, dus de zes oudste
referenties (ingest-date 2026-03-26) zijn dezelfde zes als vorige week. Deze audit
verifieert die zes opnieuw tegen de actuele bron, vult de lijst nieuwe pagina's aan met
een sectie die vorige week gemist is, en bevestigt dat de al bekende findings nog steeds
open staan.

## 1. Verlopen review-dates

Nog steeds ongewijzigd: alle 23 referenties hebben een `review-date` van 2026-09-09 of
2026-09-10. Vandaag is 2026-09-14, dus elke referentie is 4 tot 5 dagen over de
review-datum. Dit is dezelfde finding als vorige week, nu verder opgelopen. Geen nieuwe
actie nodig, alleen escalatie-relevant: zie `_tracking.md`.

- [ ] Nog steeds openstaand: alle 23 referenties opnieuw ingesten via `/ingest`. Bestandspad: `wiki/40-references/claude-code/*.md` + `00-index.md`.

## 2. Verdwenen of hernoemde bronnen

Beide findings uit 2026-09-10 staan nog open, ongewijzigd:

- [ ] **`slash-commands.md`** verwijst naar `https://code.claude.com/docs/en/slash-commands`, een URL die niet meer in de docs-index voorkomt. De inhoud zit nu in `commands.md`. Bestandspad: `wiki/40-references/claude-code/slash-commands.md`.
- [ ] **`00-index.md`** linkt CLI reference naar `https://code.claude.com/docs/en/cli-usage`, wat niet bestaat. De juiste URL is `https://code.claude.com/docs/en/cli-reference` (klopt al in de frontmatter van `cli-reference.md` zelf). Bestandspad: `wiki/40-references/claude-code/00-index.md`, regel 24.

Geen nieuwe verdwenen of hernoemde bronnen gevonden bij de overige 21 referenties: elke
overige `source-url` in onze bestanden komt terug in de actuele docs-index.

## 3. Nieuwe pagina's (nog niet geingest)

### 3a. Nog open van vorige week

De HOOG- en MIDDEN-lijst uit de audit van 2026-09-10 (`docs-drift-claudecode-2026-09-10.md`,
sectie 3) staat nog volledig open: geen van de genoemde pagina's is deze week geingest.
Zie dat rapport voor de volledige lijst (hooks-guide, scheduled-tasks, settings-reference,
workflows, agents, cross-session-messaging, tools-reference als HOOG; sessions,
claude-code-on-the-web, desktop-scheduled-tasks, worktrees, plugins-reference,
discover-plugins, errors, troubleshooting, changelog, goal, artifacts, code-review,
mcp-quickstart, checkpointing, fast-mode, headless, remote-control als MIDDEN).

### 3b. Aanvulling: pagina's die vorige week niet in de selectie zaten

Bij het doorlopen van de volledige docs-index deze week vielen twee secties op die
vorige week niet apart benoemd zijn: "Core concepts" en een deel van "Use Claude Code".
Onderstaande pagina's ontbreken bij ons en zijn relevant genoeg om nu apart te noemen.

| Pagina | Bron | Prioriteit | Waarom |
|---|---|---|---|
| Extend Claude Code | `/docs/en/features-overview` | HOOG | Overkoepelende pagina over wanneer je CLAUDE.md, een skill, of een path-scoped rule gebruikt. `memory.md` verwijst er zelf naar ("de extension overview dekt wanneer je welk mechanisme gebruikt"). Direct bruikbaar voor het onderhoud van deze repo's eigen `.claude/`-structuur. |
| Explore the .claude directory | `/docs/en/claude-directory` | HOOG | Beschrijft de structuur en het opruimgedrag (`cleanupPeriodDays`-sweep) van `.claude/`, waar deze repo's rules, skills en agents in leven. |
| Explore the context window | `/docs/en/context-window` | MIDDEN | Beschrijft wat compaction overleeft en wat niet; relevant omdat CYRIX draait op lange sessies met automatische samenvatting. |
| How Claude Code works | `/docs/en/how-claude-code-works` | MIDDEN | Conceptuele basis, nuttig als startpunt naast `overview.md`. |
| How Claude Code uses prompt caching | `/docs/en/prompt-caching` | MIDDEN | Relevant voor cache-TTL-gedrag bij routines en subagents (`subagentPromptCacheTtl`, wakeup-scheduling). |
| Common workflows | `/docs/en/common-workflows` | LAAG-MIDDEN | Praktische patronen, aanvullend op bestaande references. |
| Prompt library | `/docs/en/prompt-library` | LAAG | Voorbeeldprompts, beperkt direct nut voor een assistant-workspace. |
| Best practices for Claude Code | `/docs/en/best-practices` | LAAG-MIDDEN | Algemene aanbevelingen, deels al impliciet verwerkt in `CLAUDE.md`-regels van deze repo. |
| Find bugs with ultrareview | `/docs/en/ultrareview` | LAAG | Nieuwe bug-finding feature voor coding-sessies; CYRIX is geen coding-assistant, beperkte relevantie. |

- [ ] Bovenstaande aanvullende pagina's meenemen bij de volgende `/ingest`-ronde, HOOG eerst. Bestandspad (doel): `wiki/40-references/claude-code/`.

## 4. Verwijderde/verdwenen pagina's waarnaar wij nog verwijzen

Geen nieuwe gevallen. Alleen de al bekende `slash-commands.md`-situatie uit sectie 2.

## 5. Inhoudelijke wijzigingen op bestaande referenties

Dezelfde zes referenties als vorige week gecontroleerd (oudste ingest-date, 2026-03-26,
ongewijzigd omdat er nog niet lokaal geingest is): `overview.md`, `skills.md`,
`sub-agents.md`, `agent-teams.md`, `mcp.md`, `memory.md`.

### Resultaat: geen nieuwe wijzigingen op vijf van de zes

Voor `overview.md`, `sub-agents.md`, `agent-teams.md`, `mcp.md` en `memory.md` is de
bron opnieuw opgehaald en vergeleken met de bevindingen van 2026-09-10. Alle destijds
genoteerde verschillen (modellen-tabel verdwenen op Overview, geen aparte Bash-subagent
meer, TeamCreate/TeamDelete-tools weg, TaskCreated-hook, Local MCP-scope, SSE deprecated,
auto-memory type-taxonomie, AGENTS.md, CLAUDE.local.md) zijn opnieuw bevestigd op de
huidige bronpagina's. Er is in de afgelopen vier dagen niets extra veranderd op deze vijf
pagina's. Geen nieuwe actie nodig bovenop de bestaande, nog open findings.

### `skills.md`: twee kleine aanvullingen op de bestaande finding

Bovenop de al genoteerde drift (nieuwe frontmatter-velden, nieuwe substituties, verouderde
bundled-skills-lijst) zijn er twee details die vorige week niet expliciet genoemd zijn:

- [ ] `/skill-doctor` staat nu in de officiele bundled-skills-lijst ("Analyze skill usage and context cost"). Onze referentie kent dit commando niet. Vorige week ontbrak dit ook al in het rapport, dus het is niet per se nieuw sinds 2026-09-10, maar wel een concrete aanvulling op de al openstaande bundled-skills-finding.
- [ ] Het `effort`-veld ondersteunt nu ook de waarde `xhigh`, naast `low`, `medium`, `high`, `max`. Onze referentie noemt alleen de eerste vier.
- Bestandspad: `wiki/40-references/claude-code/skills.md`. Deze twee punten horen bij de al bestaande tracking-regel voor deze pagina, geen nieuwe regel nodig.

## 6. Conclusie en vervolgacties

Er is drift, grotendeels een voortzetting van de audit van 2026-09-10: dezelfde
verlopen review-dates (nu verder opgelopen), dezelfde verdwenen/foute bron-URL's,
dezelfde inhoudelijke afwijkingen op de zes oudste referenties. Nieuw deze week is
uitsluitend de aanvullende lijst met niet eerder genoemde pagina's (sectie 3b) en twee
kleine details op `skills.md` (sectie 5). Er is geen enkele referentie lokaal opnieuw
geingest sinds vorige week, dus geen enkele eerder gemelde finding is opgelost.

Voorgestelde volgorde blijft ongewijzigd ten opzichte van 2026-09-10:

1. `slash-commands.md` afhandelen (superseded-markering of samenvoegen met `commands.md`).
2. `00-index.md` CLI-reference-link corrigeren.
3. Her-ingest van de zes gecontroleerde pagina's, inclusief de twee aanvullende
   `skills.md`-details uit sectie 5.
4. Nieuwe HOOG-prioriteit pagina's ingesten, inclusief de twee HOOG-pagina's uit
   sectie 3b (`features-overview`, `claude-directory`).
5. Overige, nog niet individueel gecontroleerde referenties (advisor, agent-view,
   channels, channels-reference, cli-reference, commands, debug-your-config, env-vars,
   hooks, model-config, output-styles, permissions, permission-modes, plugins, routines,
   settings) blijven kandidaat voor de "oudste ingest-date eerst"-selectie zodra de
   huidige zes zijn her-geingest.

Deze reference-pagina's zijn niet gewijzigd door deze audit. Re-ingest gebeurt lokaal via
`/ingest`.

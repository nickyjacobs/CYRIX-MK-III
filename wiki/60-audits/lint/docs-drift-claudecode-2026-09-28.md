---
title: Docs-drift audit Claude Code references
date: 2026-09-28
type: audit
category: 60-audits
status: open
tags: [audit, claude-code, docs-drift, lint]
---

# Docs-drift audit: Claude Code references (2026-09-28)

Vervolg op de audit van 2026-09-10. Vergelijking van `wiki/40-references/claude-code/` met
de actuele index op `https://code.claude.com/docs/llms.txt`. Geen van de 23 referenties is
sinds de vorige audit opnieuw geingest: alle `ingest-date`-waarden staan nog op 2026-03-26 of
2026-06-09/10. Alle findings uit de audit van 2026-09-10 zijn dus nog open. Deze audit
bevestigt dat, en voegt de wijzigingen toe die sinds die datum in de drift zelf zijn ontstaan.

## 1. Status van eerder gevonden findings

Ongewijzigd en nog open, zie `docs-drift-claudecode-2026-09-10.md` voor de volledige details:

- [ ] Alle 23 referenties hebben een verlopen `review-date` (nu 18-19 dagen verlopen in
  plaats van 0). Bestandspad: `wiki/40-references/claude-code/*.md`.
- [ ] `slash-commands.md` verwijst naar een niet meer bestaande bron-URL; inhoud zit nu in
  `commands.md`. Bestandspad: `wiki/40-references/claude-code/slash-commands.md`.
- [ ] `00-index.md` linkt CLI reference naar de foute URL `/cli-usage` in plaats van
  `/cli-reference`. Bestandspad: `wiki/40-references/claude-code/00-index.md`, regel 24.
- [ ] Inhoudelijke drift op `overview.md`, `skills.md`, `sub-agents.md`, `agent-teams.md`,
  `mcp.md`, `memory.md` (de zes oudste ingest-dates), zoals gedetailleerd in de vorige audit.
  Bij herfetch vandaag zijn deze bevindingen bevestigd, geen van de genoemde items is
  inmiddels rechtgezet op de bron.
- [ ] Nieuwe HOOG-prioriteit pagina's (hooks-guide, scheduled-tasks, settings-reference,
  workflows, agents, cross-session-messaging, tools-reference) staan nog niet in onze
  referentieset.

## 2. Nieuwe drift sinds 2026-09-10

### Plugins-documentatie fors heringericht

- [ ] De bron-URL van onze `plugins.md` (`https://code.claude.com/docs/en/plugins`) bestaat
  nog, maar toont nu de content van "Plugins overview" en verwijst door naar een volledige
  `plugins/`-substructuur: `plugins/install.md`, `plugins/create.md`, `plugins/components.md`,
  `plugins/security.md`, `plugins/org.md`, `plugins/troubleshooting.md`,
  `plugins/manifest-reference.md`, `plugins/marketplace-reference.md`,
  `plugins/cli-reference.md`, `plugins/publish.md`, `plugins/measure.md`,
  `plugins/create-marketplace.md`, `plugins/host-marketplace.md`, en meer (20+ pagina's
  totaal). De twee URLs die de vorige audit noemde voor "Plugins reference"
  (`/docs/en/plugins-reference`) en "Discover and install prebuilt plugins"
  (`/docs/en/discover-plugins`) bestaan niet in de huidige index; dat waren kennelijk geen
  geldige paden. Onze ene `plugins.md` dekt nu nog maar een fractie van de daadwerkelijke
  documentatie-oppervlakte. Voorgestelde actie: bij re-ingest kiezen tussen (a) een korte
  overview-pagina behouden en gericht 2-3 subpagina's toevoegen die relevant zijn voor
  single-user gebruik (install, create, components), of (b) expliciet documenteren dat de
  rest bewust buiten scope valt (marketplace-hosting en org-beheer zijn niet relevant voor
  een single-user workspace). Bestandspad: `wiki/40-references/claude-code/plugins.md`.

### Nieuwe pagina, niet eerder gesignaleerd

| Pagina | Bron | Prioriteit | Waarom |
|---|---|---|---|
| Let Claude coordinate ongoing work with Projects | `/docs/en/claude-projects` | MIDDEN | Beschrijft hoe Claude meerdere parallelle cloud-sessies coordineert onder een project. Relevant voor `wiki/10-projects`-achtige langlopende trajecten, met name in combinatie met routines. |

De overige nieuwe-pagina's-selectie uit de vorige audit (HOOG/MIDDEN/LAAG-tabellen) is
ongewijzigd gebleven; geen van die pagina's is inmiddels verdwenen of hernoemd.

## 3. Geverifieerd: geen overige verrassingen

- `agent-teams.md`: het `TaskCreated`-hook-event, genoemd in de vorige audit, is bij herfetch
  vandaag opnieuw bevestigd aanwezig naast `TeammateIdle` en `TaskCompleted`.
- `mcp.md`: SSE staat nog steeds expliciet als deprecated vermeld, HTTP als aanbevolen
  transport. Geen wijziging ten opzichte van 2026-09-10.
- `memory.md`: de AGENTS.md-ondersteuning en de vier-delige auto-memory-taxonomie
  (`user`/`feedback`/`project`/`reference`) staan nog steeds niet in onze referentie en zijn
  bij herfetch ongewijzigd bevestigd.
- Geen van de drie categorieen (nieuw / gewijzigd / verdwenen) laat een oplossing zien ten
  opzichte van de vorige cyclus. Er is dus geen "Opgelost"-verhuizing in `_tracking.md` deze
  ronde.

## Conclusie en vervolgacties

De backlog uit de audit van 2026-09-10 staat nog volledig open, wat op deze cadans (wekelijks)
nog geen escalatie rechtvaardigt (escalatie naar monthly pas na 30 dagen open in weekly). De
enige echt nieuwe drift is de herinrichting van de plugins-documentatie en een extra
MIDDEN-pagina (`claude-projects.md`). Voorgestelde volgorde blijft ongewijzigd ten opzichte
van de vorige audit: eerst `slash-commands.md` en de `00-index.md`-link afhandelen, dan de
zes oudste referenties her-ingesten, dan de HOOG-pagina's toevoegen. Her-ingest gebeurt lokaal
via `/ingest`; deze audit wijzigt geen referentiepagina's.

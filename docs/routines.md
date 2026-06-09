# CYRIX MK-III — Cloud routines

> Setup-gids voor `wiki-librarian` cloud-routines via de `/schedule`-skill of de web-UI.
> Geverifieerd tegen de officiele docs op 2026-06-10: https://code.claude.com/docs/en/routines

## Wat zijn routines

[Claude Code routines](https://code.claude.com/docs/en/routines) zijn opgeslagen configuraties (prompt + repo's + connectors + triggers) die draaien op Anthropic-beheerde cloud-infra. Ze blijven werken als je laptop dicht is. Status: research preview, dus gedrag en limieten kunnen wijzigen.

Voor CYRIX gebruiken we een schedule-trigger om de `wiki-librarian` agent op drie cadansen automatisch te draaien.

## De drie wiki-routines

| Naam | Cadans | Mode | Doel |
|---|---|---|---|
| `cyrix-wiki-audit-daily` | Elke dag rond 09:00 | daily | Lichte lint: broken links, frontmatter, orphans, lege notes |
| `cyrix-wiki-audit-weekly` | Wekelijks (zondag) | weekly | Structuur-consistentie, duplicates, openstaande TODOs |
| `cyrix-wiki-audit-monthly` | 1e van de maand | monthly | Diepe audit: archives, MEMORY-opschoning, stale references |

Findings landen in `wiki/60-audits/`. Escalerend mechanisme: ongelegen findings rijzen door naar de volgende cadens.

## Vereisten

- **Plan:** Pro, Max, Team of Enterprise, met Claude Code on the web ingeschakeld
- **Auth:** ingelogd via je claude.ai-subscription. Niet via een Console API-key of cloud-provider (Bedrock/Vertex/Foundry). Als `ANTHROPIC_API_KEY` of `ANTHROPIC_AUTH_TOKEN` in je shell staat, of `apiKeyHelper` in `settings.json`, verbergt de CLI `/schedule`. Verwijder die eerst.
- **CLI:** v2.1.81 of nieuwer (`claude --version`). Wij draaien 2.1.170.
- **GitHub gekoppeld:** voer eenmalig `/web-setup` uit zodat de cloud de repo kan clonen. Routines committen en pushen via jouw gekoppelde GitHub-identiteit, dus commits verschijnen als jou.
- **Repo:** `nickyjacobs/CYRIX-MK-III` gepusht naar GitHub met `.claude/agents/wiki-librarian.md` aanwezig.

> Let op: routines gebruiken NIET de `.env` `GITHUB_TOKEN`. Die token is alleen voor de lokale `github` MCP-server. De cloud-push loopt via je GitHub-identiteit. Token-rotatie blijft goede hygiene, maar blokkeert routine-setup niet.

### Branch-push permissie

Standaard mag een routine alleen pushen naar branches met een `claude/`-prefix, niet naar `main`. Twee opties voor de audit-rapporten:

- **Aanbevolen:** laat de routine naar een `claude/`-branch pushen en een PR openen. Jij reviewt en merget. Veiliger, want geen autonome writes naar `main`.
- **Direct naar `main`:** zet per repo "Allow unrestricted branch pushes" aan in het routine-formulier op de web-UI.

## Setup via `/schedule` (CLI)

`/schedule` maakt schedule-routines conversationeel aan en slaat ze op je account op. CLI-presets zijn hourly, daily, weekdays en weekly.

```text
/schedule daily om 09:00 in repo nickyjacobs/CYRIX-MK-III: draai @wiki-librarian daily,
schrijf de audit naar wiki/60-audits/ en open een PR met het rapport
```

```text
/schedule wekelijks op zondag om 18:00 in repo nickyjacobs/CYRIX-MK-III: draai
@wiki-librarian weekly, schrijf naar wiki/60-audits/ en open een PR
```

De **monthly** routine kan niet rechtstreeks als preset. Maak 'm eerst als weekly aan, en zet daarna de cron om via:

```text
/schedule update
# kies de monthly-routine, zet cron op: 0 18 1 * * (1e van de maand, 18:00 lokaal)
```

Minimum-interval is 1 uur. Tijden zijn in je lokale zone en worden automatisch omgezet. Runs starten mogelijk een paar minuten later door stagger.

## Setup via de web-UI (alternatief)

Ga naar [claude.ai/code/routines](https://claude.ai/code/routines) → **New routine** → **Remote**. Vul prompt, repo (`nickyjacobs/CYRIX-MK-III`), environment, en een **Schedule**-trigger in. Onder **Permissions** zet je eventueel "Allow unrestricted branch pushes" aan. Web en CLI schrijven naar hetzelfde account, dus een routine die je in de een aanmaakt verschijnt direct in de ander.

## Verificatie

```text
/schedule list      # toont al je routines
/schedule run       # kies een routine en draai 'm direct (of "Run now" op de web-detailpagina)
```

Een groene status betekent alleen dat de sessie zonder infra-fout startte en stopte, niet dat de taak slaagde. Open de run en lees het transcript om te bevestigen wat de agent deed.

## Beheer

- **Wijzigen:** `/schedule update` (CLI) of het potlood-icoon op de web-detailpagina
- **Pauzeren/hervatten:** toggle in de **Repeats**-sectie op de web-detailpagina
- **Verwijderen:** delete-icoon op de web-detailpagina
- **Runs bekijken:** elke run is een volwaardige sessie in je sessielijst

## Kosten en limieten

Routines tellen mee tegen je subscription-usage, net als interactieve sessies, plus een dagelijkse cap op het aantal runs per account. Verbruik en resterende runs zie je op [claude.ai/code/routines](https://claude.ai/code/routines) of [claude.ai/settings/usage](https://claude.ai/settings/usage). Eenmalige (one-off) runs tellen niet mee tegen de dagcap.

## Lokaal alternatief (laptop moet aan)

Wil je geen cloud, dan kan het lokaal, maar dan moet je machine draaien:

- **Desktop scheduled tasks** ([docs](https://code.claude.com/docs/en/desktop-scheduled-tasks)): in de Desktop-app kies je bij **New routine** voor **Local** in plaats van **Remote**.
- **In-sessie scheduling** via `/loop` of de scheduled-tasks-mechaniek ([docs](https://code.claude.com/docs/en/scheduled-tasks)): draait alleen zolang de CLI-sessie openstaat.

## Handmatig draaien

Altijd mogelijk vanuit de CYRIX-werkomgeving, zonder routine:

```text
@wiki-librarian daily
@wiki-librarian weekly
@wiki-librarian monthly
```

## Wijzigingslog

- **2026-06-10:** doc gecorrigeerd. De eerdere versie documenteerde een niet-bestaand `claude routine create --schedule` commando en een fout auth-model (`.env GITHUB_TOKEN` voor cloud-push). Vervangen door de echte `/schedule`-skill plus web-UI, en het correcte GitHub-identiteit-model.

# CYRIX MK-III: wiki-audits en cloud-routines

> Hoe de wiki-audit is ingericht: lokaal voor de volledige wiki, cloud voor wat publiek staat.
> Geverifieerd tegen de officiele docs op 2026-06-10: https://code.claude.com/docs/en/routines

## Wat zijn routines

[Claude Code routines](https://code.claude.com/docs/en/routines) zijn opgeslagen configuraties (prompt + repo's + connectors + triggers) die draaien op Anthropic-beheerde cloud-infra. Ze blijven werken als je laptop dicht is. Status: research preview, dus gedrag en limieten kunnen wijzigen.

Voor CYRIX gebruiken we een schedule-trigger om de `wiki-librarian` agent op drie cadansen automatisch te draaien.

## Wat een cloud-routine wel en niet kan zien

Een routine kloont de repo. De persoonlijke wiki-content is gitignored en zit dus **niet** in die
checkout: `00-context/`, `10-projects/`, `20-knowledge/`, `30-sessions/`, `50-decisions/` en
`90-archives/` ontbreken volledig. Een cloud-routine die `@wiki-librarian` draait, auditeert
daarom een vrijwel lege template en niet jouw wiki.

Daarom is de audit gesplitst.

### Lokaal: de volledige wiki

Draai in een gewone sessie:

```text
@wiki-librarian daily
@wiki-librarian weekly
@wiki-librarian monthly
```

Dit is de enige manier waarop de persoonlijke content geauditeerd wordt. De SessionStart-hook
herinnert je eraan zodra de laatste lokale audit meer dan 14 dagen oud is.

### Cloud: wat wel publiek staat

| Naam | Cadans | Doel |
|---|---|---|
| `cyrix-docs-drift-claudecode` | Wekelijks, maandag 08:00 lokaal (`0 6 * * 1` UTC) | Vergelijkt `wiki/40-references/claude-code/` met de actuele docs op code.claude.com en rapporteert nieuwe, gewijzigde en verdwenen pagina's |
| `cyrix-template-lint` | Maandelijks, 1e om 08:00 lokaal (`0 6 1 * *` UTC) | Links, frontmatter en structuur van de publieke template: index-pagina's, `_templates/`, `.example`-bestanden, `40-references/` |

Findings landen in `wiki/60-audits/lint/` via een pull request. De state staat in
`wiki/60-audits/lint/_tracking.md`, waarin elke finding een `first-seen` krijgt zodat het
escalatiemechanisme tussen cadansen werkt.

> Let op: de cron-expressies staan in UTC. In de zomertijd (CEST) is 06:00 UTC gelijk aan 08:00
> lokaal, in de wintertijd (CET) aan 07:00 lokaal. Er is geen automatische correctie.

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

`/schedule` maakt routines conversationeel aan en slaat ze op je account op.

**Eerst koppelen.** Zonder gekoppeld GitHub-account weigert de API elke routine die een
repository gebruikt, met `Connect your GitHub account before saving a routine that uses a
GitHub repository`. Draai eenmalig `/web-setup` en probeer het daarna opnieuw.

```text
/schedule wekelijks op maandag om 08:00 in repo nickyjacobs/CYRIX-MK-III: vergelijk
wiki/40-references/claude-code/ met de actuele docs op code.claude.com, schrijf een
drift-rapport naar wiki/60-audits/lint/ en open een PR
```

De prompt moet volledig zelfstandig zijn: de cloud-sessie start koud, zonder jouw CLAUDE.md-context.
Vermeld daarom expliciet dat de persoonlijke wiki-mappen ontbreken en dat dat geen finding is.

Minimum-interval is 1 uur. Runs starten mogelijk een paar minuten later door stagger.

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

## Wijzigingslog

- **2026-09-10:** audit-opzet gesplitst. De cloud-routine kan de gitignorede wiki-content niet
  zien, dus `@wiki-librarian` draait voortaan lokaal en de cloud doet alleen docs-drift en
  template-lint. Vereiste `/web-setup` toegevoegd; zonder gekoppeld GitHub-account weigert de
  routines-API elke repo-gebonden routine.
- **2026-06-10:** doc gecorrigeerd. De eerdere versie documenteerde een niet-bestaand `claude routine create --schedule` commando en een fout auth-model (`.env GITHUB_TOKEN` voor cloud-push). Vervangen door de echte `/schedule`-skill plus web-UI, en het correcte GitHub-identiteit-model.

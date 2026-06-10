---
title: "Claude Code: Advisor tool"
source-url: https://code.claude.com/docs/en/advisor
ingest-date: 2026-06-10
review-date: 2026-09-10
tags: [reference, claude-code, advisor]
category: 40-references
status: active
---

# Advisor tool

> Bron: https://code.claude.com/docs/en/advisor

De advisor-tool laat Claude een tweede, doorgaans sterker model consulteren op sleutelmomenten: voor het vastleggen van een aanpak, bij een terugkerende fout, of voor het afronden van een taak. De advisor krijgt de volledige conversatie en geeft guidance die Claude toepast. Draait server-side op Anthropic-infra.

Experimenteel, vereist v2.1.98+ met de Anthropic API. Niet op Bedrock/Vertex/Foundry.

## Wanneer

Past bij lange, meerstaps-taken waar de meeste turns routine zijn maar plan-kwaliteit de uitkomst bepaalt: grote refactors, debug-sessies met terugkerende fouten, taken die je onafhankelijk gecheckt wil hebben. Minder waarde bij korte taken; switch dan het main-model.

## Inschakelen (3 manieren)

| Manier | Hoe |
|--------|-----|
| `/advisor`-command | Mid-sessie zetten en als default opslaan |
| `advisorModel`-setting | Persistente default in settings |
| `--advisor`-flag | Per sessie bij launch |

Zonder argument opent `/advisor` een picker. Direct: `/advisor opus`. Settings: `{"advisorModel": "opus"}`. De flag heeft voorrang op de setting maar exit met error als het main-model de advisor niet ondersteunt.

## Advisor-model kiezen

De advisor moet minstens zo capabel zijn als het main-model.

| Main model | Geaccepteerde advisors |
|------------|------------------------|
| Haiku 4.5 | Fable, Opus, Sonnet (Haiku kan zelf geen advisor zijn) |
| Sonnet 4.6 | Fable, Opus, Sonnet |
| Opus 4.6+ | Fable, Opus op of boven main-versie |
| Fable 5 (v2.1.170+) | Fable |

Aliassen `opus`/`sonnet`/`fable` resolven naar de nieuwste versie; volledige ID's (bv. `claude-opus-4-8`) ook toegestaan. De API dwingt de pairing af, niet Claude Code: een afgewezen pairing wordt opgeslagen en faalt pas bij de volgende request. Fable verschijnt niet in de picker, pas `/advisor fable` direct toe.

## Gedrag

Claude beslist wanneer te consulteren. Je kunt het in je prompt vragen ("consult the advisor before you continue"). Geen setting om calls te cappen of forceren. Tijdens een call toont de transcript een `Advising`-regel; `Ctrl+O` om de volledige guidance te lezen. Claude volgt guidance meestal maar wijkt af als eigen bewijs een claim tegenspreekt.

## Kosten en caching

Elke call verbruikt tokens tegen het advisor-tarief bovenop het main-model. Op subscription-plannen telt het mee in de limieten en in `/usage`. Advisor toggelen mid-sessie invalideert de prompt-cache van het main-model niet, maar de advisor's eigen lezing van de conversatie wordt niet gecached.

## Uitschakelen

`/advisor off` of **No advisor** in de picker wist de opgeslagen `advisorModel`. De hele tool (inclusief command en flag) uit met `CLAUDE_CODE_DISABLE_ADVISOR_TOOL=1`.

## Vergelijking

| Aanpak | Wanneer sterker model draait |
|--------|------------------------------|
| Advisor-tool | Op beslismomenten mid-taak (Claude roept aan) |
| `opusplan` | Tijdens plan mode, daarna Sonnet voor executie |
| Subagents met `model` | Voor de hele gedelegeerde subtaak |
| `/model` | Voor alle volgende turns |

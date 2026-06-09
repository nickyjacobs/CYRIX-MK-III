---
title: DutchQuill — Nederlandse schrijfregels
source-url: https://github.com/nickyjacobs/dutchquill-ai
ingest-date: 2026-06-09
review-date: 2026-09-09
tags: [reference, dutchquill, writing, nederlands]
category: 40-references
status: active
license: MIT
attribution: DutchQuill AI Contributors
---

# DutchQuill — Nederlandse schrijfregels

> Lokale kopie van DutchQuill schrijfregels (MIT-licentie). Voor full project zie het oorspronkelijke DutchQuill AI project.
>
> Gebruik via `/dutch-write` skill of als reference bij handmatig NL-schrijfwerk.

## Bestanden in deze reference

| Bestand | Inhoud | Grootte |
|---|---|---|
| [`schrijfstijl.md`](./schrijfstijl.md) | 26 verboden woorden, 6 verboden openers, 7 stijlregels | 1.3 KB |
| [`taal_gids.md`](./taal_gids.md) | d/t/dt-regels, werkwoordsvervoeging, samenstellingen, kommaregels | 15 KB |
| [`humanize_nl_gids.md`](./humanize_nl_gids.md) | 20 AI-detectiecategorieën, n-gram patronen, burstiness, risicoscores | 36 KB |
| [`LICENSE.dutchquill`](./LICENSE.dutchquill) | MIT-licentie van DutchQuill AI | 1 KB |

## Hoe deze referentie gebruikt wordt

1. **`/dutch-write` skill** leest deze bestanden bij elke aanroep en past de regels toe op de input-tekst.
2. **PostToolUse hook** (`scripts/check_verboden_woorden.py`) checkt markdown-files in `docs/`, `wiki/`, root `README.md` op verboden woorden + openers. Advisory only (non-blocking).
3. **Handmatig**: bij twijfel of CYRIX iets stylistically goed schrijft, raadpleeg deze gidsen.

## Eigen aanvullingen

Eigen schrijfregels die niet in DutchQuill staan: zie `.claude/rules/writing-cyrix.md`. Bij conflict overrulen jouw regels DutchQuill.

## Review-cyclus

Review-date: **2026-09-09** (+3 maanden). De `wiki-librarian` monthly audit waarschuwt wanneer review-date verstreken is — re-ingestren door deze folder opnieuw te kopiëren vanuit DutchQuill AI project.

## NIET in deze reference (DutchQuill-intern)

De volgende DutchQuill-gidsen zijn **niet** opgenomen omdat ze studie-specifiek zijn (HBO-rapportage) en niet generiek toepasbaar voor CYRIX:

- `apa_nl_gids.md` — APA 7e editie bronvermelding (alleen relevant voor academisch werk)
- `academische_stijl_gids.md` — rapport-structuur, abstracttaal (te formeel voor CYRIX)
- `ai_gebruik_gids.md` — ChatGPT/Claude citering in APA (academisch)

Als je deze later nodig hebt: re-ingest direct uit het DutchQuill AI project.

## Attribution

Inhoud uit [DutchQuill AI](https://github.com/nickyjacobs/dutchquill-ai), MIT-licentie. Copyright 2026 DutchQuill AI Contributors. Zie [`LICENSE.dutchquill`](./LICENSE.dutchquill).

# DutchQuill integratie

CYRIX gebruikt [DutchQuill AI](https://github.com/nickyjacobs/dutchquill-ai)'s schrijfregels voor Nederlandse extern-bedoelde teksten. **Geen runtime-dependency** — alleen een gecureerde kopie van de relevante regels in de wiki.

## Relatie tussen CYRIX en DutchQuill

DutchQuill is een **apart Claude Code project** dat:
- Nederlandse academische rapportage schrijft
- 20 AI-detectiecategorieën gebruikt voor humanisering
- APA 7e editie ondersteunt

CYRIX is **niet** DutchQuill. CYRIX gebruikt alleen de generieke schrijfregels (verboden woorden, openers, em dashes, taalregels) die ook buiten academisch werk relevant zijn.

## Wat is geïmporteerd

| Bestand | Doel | Locatie |
|---|---|---|
| `schrijfstijl.md` | 26 verboden woorden, 6 verboden openers, 7 stijlregels | `wiki/40-references/dutchquill/` |
| `taal_gids.md` | d/t/dt, samenstellingen, kommaregels | `wiki/40-references/dutchquill/` |
| `humanize_nl_gids.md` | 20 AI-detectiecategorieën, n-gram patronen | `wiki/40-references/dutchquill/` |
| `LICENSE.dutchquill` | MIT-licentie | `wiki/40-references/dutchquill/` |

## Wat is NIET geïmporteerd

| Bestand | Reden |
|---|---|
| `apa_nl_gids.md` | APA-bronvermelding alleen relevant voor academisch werk |
| `academische_stijl_gids.md` | Rapport-structuur, te formeel voor CYRIX |
| `ai_gebruik_gids.md` | ChatGPT/Claude citering in APA — academisch |
| `workflows/*` | DutchQuill-interne task-routing, niet voor CYRIX |

## Hoe de regels gebruikt worden

### Via `/dutch-write` skill (primair)

```
/dutch-write Het is essentieel om proactief te zijn.
```

De skill leest `wiki/40-references/dutchquill/schrijfstijl.md`, herschrijft de tekst zonder verboden woorden, em-dashes en AI-typische patronen.

### Via PostToolUse hook (vangnet)

Bij `.md` files in `docs/`, `wiki/`, root `README.md` draait `scripts/check_verboden_woorden.py` automatisch na elke Edit/Write — non-blocking advisory.

### Via `CLAUDE.md` rule (impliciet)

Bij Nederlands extern werk verwijst `.claude/rules/writing-dutch.md` naar de DutchQuill-regels. Claude leest ze bij relevante context.

## Re-ingest workflow

DutchQuill kan worden bijgewerkt — wanneer dat gebeurt, draai re-ingest:

1. Update `wiki/40-references/dutchquill/00-index.md` `review-date` naar vandaag
2. Kopieer nieuwste versies van de drie gidsen vanuit het oorspronkelijke DutchQuill project
3. Vergelijk diff, archiveer oude versies indien nodig in `wiki/90-archives/40-references/dutchquill-YYYY-MM-DD/`
4. Update CHANGELOG-entry in `wiki/40-references/log.md`

De `wiki-librarian` monthly audit flaggert wanneer review-date verstreken is — gebruik dat als trigger.

## Licentie en attribution

DutchQuill content is MIT-gelicenseerd. CYRIX behoudt de DutchQuill `LICENSE.dutchquill` in dezelfde folder als de gekopieerde content. Bij gebruik van de regels: geen attribution-vereiste, wel respect voor de bron.

## Eigen schrijfregels

CYRIX's eigen aanvullingen op DutchQuill staan in `.claude/rules/writing-cyrix.md` (publiek, generiek) en `.claude/rules-private/writing-personal.md` (gitignored, persoonlijk). Eigen regels override DutchQuill bij conflict.

---
name: dutch-write
description: Schrijf of herschrijf Nederlandse tekst volgens DutchQuill-stijlregels en eigen schrijfregels. Voor extern werk (rapporten, mails, READMEs, blog-posts, klant-communicatie). Past verboden-woordenlijst, openers, em-dashes en humaniseer-patronen toe.
---

# /dutch-write

## Wanneer gebruiken

- Externe Nederlandse teksten: rapporten, mails, GitHub READMEs, blog-posts, klant-communicatie
- Tekst die al bestaat maar te AI-achtig klinkt (herschrijven)
- Belangrijke berichten waar stijl ertoe doet

**Niet voor:** snelle interne berichten, code-commentaar, taken-trackers. Die mogen direct.

## Hoe het werkt

### Stap 1 — Regels inladen

Lees:
1. `wiki/40-references/dutchquill/schrijfstijl.md` (26 verboden woorden + 6 openers + 7 stijlregels)
2. `wiki/40-references/dutchquill/taal_gids.md` (d/t/dt-regels)
3. `wiki/40-references/dutchquill/humanize_nl_gids.md` (AI-detectiecategorieën — alleen relevante stukken)
4. `.claude/rules/writing-cyrix.md` (eigen aanvullingen, override DutchQuill bij conflict)
5. `.claude/rules/writing-dutch.md` (algemene NL schrijfregels)

### Stap 2 — Input verwerken

Drie modes:

| Input | Mode |
|---|---|
| Tekst direct in prompt | Inline-mode |
| Pad naar `.md` bestand | File-mode |
| `--from-clipboard` | Clipboard-mode |

### Stap 3 — Stijl-analyse vóór herschrijven

Scan tekst op:
- **Verboden woorden** (uit schrijfstijl.md) — markeer elk hit
- **Verboden openers** — check eerste zin van elke paragraaf
- **Em dashes (—) en gedachtestreepjes** — vervang door komma/punt/zinsplit
- **AI-tells** uit humanize_nl_gids.md (overdreven connectoren, vage abstracties, platitudes)
- **dt-fouten** — check werkwoordsvervoegingen

### Stap 4 — Herschrijven

- Vervang verboden woorden door synoniemen die NIET in de verbodenlijst staan
- Herschrijf openers die op de verboden lijst staan
- Vervang em dashes door komma's, punten, of zinsplits
- Varieer zinslengtes (kort < 10, middel, lang)
- Gebruik specifieke cijfers/namen/data waar de tekst dat toelaat
- Bij feitelijke claims: voeg `[bron nodig]` toe als geen bron expliciet is

### Stap 5 — Validatie (post-herschrijven)

Run `scripts/check_verboden_woorden.py` (kopie uit DutchQuill, MIT) op de output:

- **Hits** worden gerapporteerd, niet automatisch hersteld
- **0 hits = pass** — output is clean
- Bij `--auto-fix`: probeer nog één herschrijf-ronde

### Stap 6 — Output

```markdown
## Originele tekst
<originele tekst>

## Herschreven
<herschreven tekst>

## Wijzigingen
- "cruciaal" → "belangrijk" (2x)
- Em dash op regel 4 → punt
- Opener "Het is belangrijk om..." → herschreven naar concrete zin
- Zinslengte gevarieerd (was uniforme middellange zinnen)

## Status
✅ 0 verboden woorden in output
✅ Geen em dashes / gedachtestreepjes
⚠️  2 feitelijke claims missen een bron — overweeg toevoeging
```

## Inputs

- **Verplicht:** tekst, pad of `--from-clipboard`
- **Optioneel:**
  - `--auto-fix` — herhaal herschrijven tot 0 hits (max 3 rondes)
  - `--style=<rapport|mail|readme|blog>` — toon-hints voor het doelmedium
  - `--keep-structure` — behoud kopstructuur en lijsten exact, alleen tekst herschrijven

## Gedragsregels

- **Géén** APA-citaties of academische conventies toepassen — die zijn DutchQuill-intern (studie-specifiek) en niet voor jouw gebruik
- **Wel** signaalwoorden voor oorzaak/contrast/opsomming gebruiken
- Bij twijfel over context (bv. mail-toon vs rapport-toon): vraag éénregelig om verheldering
- **Nooit** woorden uit MK-II/CYRIX domein-vocabulaire vervangen — bv. "playbook", "engagement", "ingest", "lazy lookup" blijven staan ook als ze niet typisch Nederlands zijn

## Validatie-script

`scripts/check_verboden_woorden.py` wordt in fase 1 toegevoegd (kopie uit DutchQuill MIT). Tot die er is: handmatige check tegen `wiki/40-references/dutchquill/schrijfstijl.md`.

## Bron

Schrijfregels gebaseerd op [DutchQuill AI](https://github.com/...) (MIT) — zie `wiki/40-references/dutchquill/` voor de volledige geïmporteerde regels, en `integrations/dutchquill/README.md` voor de relatie tot CYRIX.

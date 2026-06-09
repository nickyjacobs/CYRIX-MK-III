---
name: ingest
description: Verwerk een raw bron (tekst of URL) naar gestructureerde wiki-references. Karpathy-stijl ingest-flow met master-index, frontmatter, supersession-tracking. Werkt voor single pagina, multi-page sites, en losse tekstfragmenten.
---

# /ingest

## Wanneer gebruiken

- Vendor-documentatie verwerken (Claude Code docs, Rapid7, Wazuh, n8n)
- Whitepapers, threat reports, CVE-pagina's als reference opslaan
- Blog-posts, RFCs, certification-guides
- Raw notities of transcripts naar gestructureerde wiki-content

**Niet voor:** snelle research-vragen — gebruik `/search`.

## Hoe het werkt

### Mode-detectie

| Input | Mode |
|---|---|
| URL die met `http(s)://` begint | URL-mode |
| Pad naar lokaal bestand | File-mode |
| Vrije tekst | Text-mode |

### URL-mode

1. **Map** — `mcp__tavily__tavily_map(<URL>, max_depth=2)` om alle gerelateerde pagina's te vinden
2. **Bepaal scope** — 1 result = single-page; >1 = multi-page met master-index
3. **Extract** — voor elke pagina `mcp__tavily__tavily_extract`
4. **Fallback** — bij quota-error: `WebFetch` per pagina, `WebSearch` voor link-discovery
5. **Slug** — afgeleid van hostname (bv. `code.claude.com` → `claude-code`), overschrijfbaar via `--slug=`

### File-mode / Text-mode

1. Lees content
2. Bespreek met gebruiker: "Wat zijn de 3-5 kernpunten die we moeten vastleggen?"
3. Output naar `wiki/sources/<slug>.md` (raw samenvatting) + relevante content-pagina's

## Karpathy-flow (alle modes)

1. **Bron lezen** — volledige content scannen
2. **Curatie** — geen kopie van de bron; per pagina 3-5 zinnen overzicht + bullet list van kernconcepten
3. **Output schrijven** — gebruik `wiki/_templates/reference-page.md` als basis
4. **Master-index** — bij multi-page: `wiki/40-references/<slug>/00-index.md` met TOC, source-URL, ingest-datum, review-datum (+3 maanden)
5. **Supersession-check** — bestaat al een reference met deze slug? Diff content, markeer oude versies in frontmatter (`superseded-by`)
6. **Index/log update** — voeg toe aan `wiki/index.md` (als nieuwe categorie zichtbaar moet zijn) en append-entry in `wiki/40-references/log.md`
7. **Rapport** — geef gebruiker een samenvatting: aantal pagina's, opgeslagen pad, ingest-datum

## Frontmatter (verplicht op elke ingest-output)

```yaml
---
title: <titel>
source-url: <URL of n.v.t.>
ingest-date: YYYY-MM-DD
review-date: YYYY-MM-DD  (default: +3 maanden)
tags: [reference, <source-slug>]
category: 40-references
status: active
supersedes: []
superseded-by: 
---
```

## Re-ingest

Als de slug-folder al bestaat:

1. Hash-check elke pagina (content-hash in frontmatter)
2. Toon diff aan gebruiker (nieuwe pagina's, gewijzigde pagina's, weggehaalde pagina's)
3. Bij akkoord: verplaats oude versies naar `wiki/90-archives/40-references/<slug>-YYYY-MM-DD/` (nooit overschrijven)
4. Schrijf nieuwe versies + update `00-index.md`

## Inputs

- **Verplicht:** bron (URL, pad, of raw tekst)
- **Optioneel:**
  - `--slug=<slug>` — override de auto-afgeleide slug
  - `--max-pages=<N>` — beperk multi-page crawl (default: 50)
  - `--target=<folder>` — override default `wiki/40-references/` (bv. `wiki/sources/`)

## Output

- Bevestiging met pad, aantal pagina's, ingest-datum
- Eerste 3-5 belangrijke pagina's als links voor inspectie
- Suggestie voor follow-up (bv. "Wil je deze reference taggen aan project X?")

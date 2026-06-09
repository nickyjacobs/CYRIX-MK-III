---
name: search
description: Web-search met Tavily als primary, automatische fallback naar WebFetch + WebSearch bij quota-uitval of errors. Gebruik voor research-vragen, CVE lookups, threat intel, vendor docs. Voorkomt search-errors door drie-traps degradatie.
---

# /search

## Wanneer gebruiken

- Snelle factual lookups (definities, CVE info, threat actor research)
- Eerste verkenning van een onderwerp
- Vendor advisories, security bulletins
- Vergelijking van opties (tools, frameworks, certificeringen)

**Niet voor:** documentatie van een specifieke site die je volledig wilt ingestren — gebruik daarvoor `/ingest`.

## Hoe het werkt

Drie-traps fallback-keten:

### Stap 1 — Tavily (primary)

Probeer `mcp__tavily__tavily_search` met de query.

```
mcp__tavily__tavily_search(query="<query>", search_depth="basic")
```

Bij succes: format antwoord met top-3 bronnen + samenvatting.

### Stap 2 — WebSearch + WebFetch (fallback)

Bij Tavily quota-error, API-error, of timeout:

1. `WebSearch(query="<query>")` voor link-discovery
2. Voor de top-3 relevante resultaten: `WebFetch(url, prompt="extract the key information for: <query>")`
3. Synthese in zelfde format als Tavily-output

### Stap 3 — Handmatige fallback (laatste redmiddel)

Bij volledig falen: meld dit aan de gebruiker en stel handmatige bronnen voor (bv. "probeer rechtstreeks op vendor-site X" of "deze info zou kunnen staan op MITRE ATT&CK").

## Output-format

```markdown
## Resultaat: <query>

<2-4 zinnen samenvatting>

### Bronnen
- [Bron 1 — titel](url) — kort waarom relevant
- [Bron 2 — titel](url) — kort waarom relevant
- [Bron 3 — titel](url) — kort waarom relevant

### Vervolgacties (optioneel)
- Suggestie voor `/ingest` als de bron diep genoeg is om als reference te bewaren
```

## Inputs

- **Verplicht:** query (string) — concreet en specifiek
- **Optioneel:** `--depth basic|advanced` — diepte van Tavily-search (default: basic)

## Gedragsregels

- Bij elk gebruikt fallback-niveau: meld het kort ("Tavily-quota op, gebruikte WebFetch")
- Géén Tavily MCP direct aanroepen vanuit andere skills — alles via deze skill
- Bij errors: log naar `wiki/60-audits/tavily-errors.md` (voor audit-trail) als de error reproduceerbaar lijkt

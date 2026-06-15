---
title: Daily Wiki Audit 2026-06-15
audit-date: 2026-06-15
audit-mode: daily
findings-total: 8
findings-hard: 5
findings-soft: 3
---

# Wiki audit 2026-06-15 (daily)

## Samenvatting

- Files gescand: 48
- Hard findings: 5
- Soft findings: 3
- Geescaleerd vanuit vorige cadens: 0 (findings van 2026-06-09 zijn 6 dagen oud, escaleren bij >7d)

---

## Hard findings

### Broken wikilink

- [ ] `wiki/index.md:61` — wikilink `[[50-decisions/log]]` bestond in vorige audit; **opgelost** (nu `[[50-decisions/log.example]]`). Echter: de wikilink `[[50-decisions/log]]` zelf (`wiki/50-decisions/log.md`) bestaat nog steeds niet — de `log.md` is gitignored en aanwezig lokaal alleen als de eigenaar hem aangemaakt heeft.
  - **Voorgestelde actie:** controleer of `wiki/50-decisions/log.md` lokaal aanwezig is; zo niet, is de index-link naar `log.example` de juiste fallback (al correct in index.md).
  - **First seen:** 2026-06-09 (als `[[50-decisions/log]]`), nu bijgesteld naar `log.example`

### Broken markdown-links (raw transcript)

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md:34` — link `../raw/2026-06-10-0011-session.md` verwijst naar een bestand dat niet bestaat (`30-sessions/raw/` map bestaat niet)
  - **Voorgestelde actie:** verwijder de link of maak de `raw/`-map aan als gitignored directory; de raw-bestanden zelf zijn gitignored maar de map-structuur kan ontbreken
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` — link `../raw/2026-06-10-0025-kan-je-me-de-vergelijking-benchmarks-gev.md` verwijst naar een bestand dat niet bestaat
  - **Voorgestelde actie:** zie vorige finding
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md:32` — link `../raw/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` verwijst naar een bestand dat niet bestaat
  - **Voorgestelde actie:** zie vorige finding
  - **First seen:** 2026-06-15

### Ontbrekende frontmatter-velden

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — mist verplicht veld `title` (sessies vereisen: `title`, `date`, `type`, `status`, `tags`, `category`)
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — session"` toe aan de frontmatter
  - **First seen:** 2026-06-09

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — mist verplicht veld `title`
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — kan-je-me-de-vergelijking-benchmarks-gev"` toe aan de frontmatter
  - **First seen:** 2026-06-09

---

## Soft findings

### Orphan page

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` — geen enkel ander wiki-bestand linkt naar deze pagina (de andere twee sessie-bestanden worden ook niet gelinkt, maar sessies zijn structureel zelden gelinkt)
  - **Voorgestelde actie:** acceptabel voor sessie-bestanden; overweeg een sessie-index onder `30-sessions/` als het volume groeit
  - **First seen:** 2026-06-15

### Index.md mist `created`-veld

- [ ] `wiki/index.md` — frontmatter heeft `updated: 2026-06-09` maar geen `created`-veld. Voor een `index.md`-landingspagina zijn alleen `title`, `category`, `status` vereist — geen datum-velden. Dit is dus een soft bevinding (de `updated`-key is overtollig maar niet schadelijk).
  - **Voorgestelde actie:** geen actie vereist; optioneel `updated` weghalen of laten staan
  - **First seen:** 2026-06-09 (als hard finding, nu herclassificeerd als soft)

### 40-references/log.md gebruikt verkeerde frontmatter-conventie

- [ ] `wiki/40-references/log.md` — dit bestand zit in `40-references/` maar gebruikt `created`/`updated` in plaats van `ingest-date`/`review-date`/`source-url` (de conventie voor reference-bestanden). Inhoudelijk is het een ingest-log, geen externe reference.
  - **Voorgestelde actie:** overweeg het bestand te verplaatsen naar `50-decisions/` of de frontmatter te corrigeren naar de reference-conventie; of documenteer expliciet dat dit bestand bewust afwijkt
  - **First seen:** 2026-06-15

---

## Opgeloste findings (t.o.v. 2026-06-09)

De volgende hard findings uit de vorige audit zijn opgelost:

- `wiki/index.md:34` — `[[10-projects/index]]` — `wiki/10-projects/index.md` bestaat nu
- `wiki/index.md:43` — `[[20-knowledge/index]]` — `wiki/20-knowledge/index.md` bestaat nu
- `wiki/index.md:61` — `[[40-references/index]]` — `wiki/40-references/index.md` bestaat nu
- `wiki/index.md:70` — `[[50-decisions/log]]` — link is bijgesteld naar `[[50-decisions/log.example]]` (bestaat)
- `wiki/40-references/claude-code/00-index.md` — orphan — is nu gelinkt vanuit `wiki/40-references/index.md`

---

## Escalatie-status

- Findings ouder dan 7d die naar weekly escaleren: 0
  - (Openstaande findings van 2026-06-09 zijn 6 dagen oud; escaleren als ze op 2026-06-17 nog openstaan)
- Findings ouder dan 30d die naar monthly escaleren: 0

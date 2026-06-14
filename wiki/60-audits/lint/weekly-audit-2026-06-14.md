---
audit-date: 2026-06-14
audit-mode: weekly
findings-total: 18
findings-hard: 11
findings-soft: 7
---

# Wiki audit 2026-06-14 (weekly)

## Samenvatting

- Files gescand: 48
- Hard findings: 11
- Soft findings: 7
- Geescaleerd vanuit daily (2026-06-09, >7 dagen open): 5

---

## Hard findings

### Broken wikilinks (geescaleerd vanuit daily-audit-2026-06-09)

- [ ] `wiki/index.md:70` — wikilink `[[50-decisions/log.example|Decisions log]]` is inconsistent: verwijst naar `log.example.md` terwijl de toelichting ernaast zegt dat de echte `log.md` gitignored is. De `log.md` bestaat niet in de repo; `log.example.md` is de enige publieke versie.
  - **Voorgestelde actie:** pas de link aan zodat hij aansluit bij de werkelijkheid, of voeg een notitie toe dat `log.md` lokaal aangemaakt moet worden
  - **First seen:** 2026-06-09
  - **Escalatie:** hard finding (>7 dagen open)

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md:34` — markdown-link naar `../raw/2026-06-10-0011-session.md` — bestand bestaat niet (raw-map is leeg)
  - **Voorgestelde actie:** verwijder de link of voeg commentaar toe dat raw-bestanden gitignored zijn
  - **First seen:** 2026-06-09
  - **Escalatie:** hard finding (>7 dagen open)

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md:31` — markdown-link naar `../raw/2026-06-10-0025-kan-je-me-de-vergelijking-benchmarks-gev.md` — bestand bestaat niet
  - **Voorgestelde actie:** zie boven
  - **First seen:** 2026-06-09
  - **Escalatie:** hard finding (>7 dagen open)

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md:32` — markdown-link naar `../raw/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` — bestand bestaat niet
  - **Voorgestelde actie:** zie boven (nieuw t.o.v. daily-audit: dit bestand is pas zichtbaar geworden)
  - **First seen:** 2026-06-14

### Ontbrekende/verkeerde frontmatter

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — mist verplicht veld `title` (sessions vereisen: `title`, `date`, `type`, `status`, `tags`, `category`)
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10"` toe aan frontmatter
  - **First seen:** 2026-06-09
  - **Escalatie:** hard finding (>7 dagen open)

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — mist verplicht veld `title`
  - **Voorgestelde actie:** voeg `title: "Sessie 2026-06-10 — vergelijking benchmarks"` (of vergelijkbaar) toe
  - **First seen:** 2026-06-09
  - **Escalatie:** hard finding (>7 dagen open)

- [ ] `wiki/40-references/log.md` — bestand zit in `40-references/` maar gebruikt `created`/`updated` in plaats van de vereiste `ingest-date`/`review-date` voor references. Mist ook `source-url`.
  - **Voorgestelde actie:** pas frontmatter aan: vervang `created`/`updated` door `ingest-date: 2026-06-09` en voeg `review-date` toe, of herdefinieer dit bestand als een niet-reference (bv. category `log`)
  - **First seen:** 2026-06-14

- [ ] `wiki/index.md` — mist `tags`-veld in frontmatter (heeft wel `title`, `updated`, `category`, `status`)
  - **Voorgestelde actie:** voeg `tags: [index, wiki]` toe
  - **First seen:** 2026-06-14

### Broken interne markdown-link (URL-mismatch)

- [ ] `wiki/40-references/claude-code/00-index.md:24` — tabel vermeldt source-url `https://code.claude.com/docs/en/cli-usage` voor `cli-reference.md`, maar de pagina is inmiddels verplaatst naar `/en/cli-reference` (gesignaleerd in docs-drift rapport van 2026-06-10)
  - **Voorgestelde actie:** update de source-url in de tabelregel naar `https://code.claude.com/docs/en/cli-reference`
  - **First seen:** 2026-06-10

### Orphan pages

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` — geen enkel ander wiki-bestand linkt naar deze pagina
  - **Voorgestelde actie:** voeg een link toe vanuit een overkoepelende sessiepagina, of accepteer als gitignored sessie-artefact
  - **First seen:** 2026-06-14

- [ ] `wiki/60-audits/lint/daily-audit-2026-06-09.md` — geen backlinks vanuit andere wiki-pagina's
  - **Voorgestelde actie:** acceptabel voor audit-bestanden; overweeg een index-pagina in `60-audits/` aan te maken die alle audits overziet
  - **First seen:** 2026-06-14

- [ ] `wiki/60-audits/lint/docs-drift-claudecode-2026-06-10.md` — geen backlinks
  - **Voorgestelde actie:** zie boven
  - **First seen:** 2026-06-14

---

## Soft findings

### Naamgevingsconventies

- [ ] `wiki/40-references/dutchquill/taal_gids.md` — bestandsnaam gebruikt underscores (`taal_gids`) in plaats van kebab-case (`taal-gids`). Zelfde voor `humanize_nl_gids.md`.
  - **Voorgestelde actie:** hernoem naar `taal-gids.md` en `humanize-nl-gids.md`; update de verwijzingen in `dutchquill/00-index.md`
  - **First seen:** 2026-06-14

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` — bestandsnaam bevat een timestamp (`1339`) als onderdeel van de slug na de datum. Andere sessies gebruiken `YYYY-MM-DD-slug` zonder tijdstip.
  - **Voorgestelde actie:** overweeg een consistente naamgevingsregel voor sessies met tijdstip (bv. altijd weglaten of altijd includeren)
  - **First seen:** 2026-06-14

### Openstaande sessies met needs-distillation status

- [ ] `wiki/30-sessions/processed/2026-06-10-session.md` — status `needs-distillation`, aangemaakt 2026-06-10 (4 dagen geleden)
  - **Voorgestelde actie:** run `/process-sessions` om deze sessie te distilleren naar `20-knowledge/`
  - **First seen:** 2026-06-14

- [ ] `wiki/30-sessions/processed/2026-06-10-kan-je-me-de-vergelijking-benchmarks-gev.md` — status `needs-distillation`
  - **Voorgestelde actie:** zie boven
  - **First seen:** 2026-06-14

- [ ] `wiki/30-sessions/processed/2026-06-10-1339-hi-ik-wil-weten-wat-zit-sinds-de-nieuwe-.md` — status `needs-distillation`
  - **Voorgestelde actie:** zie boven
  - **First seen:** 2026-06-14

### Index-consistentie

- [ ] `wiki/60-audits/` heeft geen eigen `index.md`. Audit-bestanden zijn alleen vindbaar via browse of grep.
  - **Voorgestelde actie:** maak een `wiki/60-audits/index.md` met een tabel van alle audit-runs (datum, modus, findings-total)
  - **First seen:** 2026-06-14

### Structuurobservatie

- [ ] `wiki/90-archives/` bestaat maar is leeg (alleen `.gitkeep`). Geen content gearchiveerd.
  - **Voorgestelde actie:** geen actie vereist — structuur is correct. Noteer dat archivering pas relevant is bij notes >90 dagen zonder verwijzingen (monthly-check)
  - **First seen:** 2026-06-14

---

## Opgeloste daily-findings (niet meer van toepassing)

De volgende findings uit `daily-audit-2026-06-09` zijn inmiddels opgelost:

- `wiki/index.md:34` — `[[10-projects/index]]` — `wiki/10-projects/index.md` bestaat nu **[opgelost]**
- `wiki/index.md:43` — `[[20-knowledge/index]]` — `wiki/20-knowledge/index.md` bestaat nu **[opgelost]**
- `wiki/index.md:61` — `[[40-references/index]]` — `wiki/40-references/index.md` bestaat nu **[opgelost]**
- `wiki/40-references/claude-code/00-index.md` orphan — `wiki/40-references/index.md` linkt er nu naar **[opgelost]**

---

## Escalatie-status

- Findings geescaleerd vanuit daily-audit-2026-06-09 (>7 dagen open): 5
- Findings ouder dan 30d die naar monthly escaleren: 0

---

## Aanbevelingen per prioriteit

### Prioriteit High

1. **Broken raw-links in sessies** — drie sessies linken naar niet-bestaande raw-bestanden. Verwijder de links of voeg een opmerking toe dat raw-bestanden gitignored zijn. Terugkerend probleem: de session-curator schrijft altijd een raw-link.
2. **Ontbrekende `title` in sessies** — twee sessies missen `title` in frontmatter. Corrigeer in de session-curator of voeg handmatig toe.
3. **`40-references/log.md` verkeerde frontmatter** — `created`/`updated` ipv `ingest-date`/`review-date`. Lage fix-kosten, hoge consistentie-impact.

### Prioriteit Medium

4. **Kebab-case violations** in `dutchquill/` — twee bestanden met underscores; vereis aanpassing in 00-index als je hernoemt.
5. **`wiki/index.md` mist `tags`** — kleine fix, verbetert grep-baarheid.
6. **Drie sessies `needs-distillation`** — de kennis zit vast in sessie-logs. Run `/process-sessions`.

### Prioriteit Low

7. **`60-audits/` mist een index-pagina** — handig voor overzicht, niet kritiek.
8. **Naamgevingsinconsistentie tijdstip in sessienaam** — definieer een conventie voor tijdstip-prefix in sessienames.

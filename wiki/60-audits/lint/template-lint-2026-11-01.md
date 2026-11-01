---
title: "Template-lint CYRIX MK-III, 2026-11-01"
date: 2026-11-01
type: audit
category: 60-audits
status: open
tags: [audit, template-lint, cloud-routine]
---

# Template-lint CYRIX MK-III (2026-11-01)

> Maandelijkse lint van de publieke template. De gitignorede persoonlijke wiki-content
> (`00-context/`, `10-projects/`, `20-knowledge/`, `30-sessions/`, `50-decisions/`, `90-archives/`)
> staat terecht niet in deze checkout en is geen onderwerp van deze audit.

## Samenvatting

- Findings totaal: 10
- HOOG: 2
- MIDDEN: 5
- LAAG: 3

---

## HOOG

- [ ] **HOOG**: `wiki/40-references/ninja-possiblecooker-mc1001eu.md`. Bevat persoonlijke, niet-werkgerelateerde content (keukenapparaat-handleiding, gezondheidsproject) met de echte voornaam van de eigenaar ("Nicky's eigen bedieningspaneel", "Nicky's apparaat", "Nicky's foto"). `wiki/40-references/index.md` stelt expliciet dat references "niet-persoonlijk (publieke docs), dus committable" zijn. Dit bestand hoort niet in een publiek forkbare template.
  - **Voorgestelde actie:** verplaats de inhoud naar een gitignored locatie (bijvoorbeeld `wiki/20-knowledge/` lokaal, of `10-projects/gezondheid/`) en verwijder het bestand uit de publieke repo, of anonimiseer het volledig (geen naam, geen persoonlijk apparaat) als het toch als generieke reference moet blijven staan.

- [ ] **HOOG**: `README.md` (sectie "Hooks") documenteert een **Stop (smart-trigger)**-hook die "bij ≥10 tool-uses" een stub-log schrijft. Deze hook bestaat niet. `.claude/settings.json` registreert geen `Stop`-event, en er is geen los hook-script voor. De eigenlijke smart-trigger-logica zit in `session-end.sh` (onder het `SessionEnd`-event) met een drempel van `>= 3` tool-uses, niet 10. `docs/archief/verificatie-fase1.md` bevestigt dat een Stop-hook ooit bestond in fase 1, maar hij is niet meegenomen in de huidige `settings.json`.
  - **Voorgestelde actie:** verwijder de losse Stop-regel uit README.md's hooks-lijst en beschrijf de smart-trigger als onderdeel van SessionEnd, met de juiste drempel (`>= 3` tool-uses of content-changes).

## MIDDEN

- [ ] **MIDDEN**: `README.md` (sectie "Agents"). Trigger voor `security-reviewer` staat als "post-edit hook + manual". De post-edit hook (`.claude/hooks/post-edit-secret-scan.sh`) roept de agent niet aan, die scant zelf via `scripts/validate.py`. Nergens in `.claude/hooks/*.sh` wordt de `security-reviewer`-agent aangeroepen.
  - **Voorgestelde actie:** pas de tabel aan naar "manual" (of "bij twijfel", conform `.claude/rules/security-context.md`), of koppel de agent daadwerkelijk aan de hook als geautomatiseerde aanroep de bedoeling is.

- [ ] **MIDDEN**: `README.md` (architectuurdiagram, map `scripts/`). Somt `validate.py`, `check_verboden_woorden.py`, `setup.sh`, `statusline.example.sh` op, maar mist `scripts/anonymize.py`. Dat script bestaat wel en wordt actief aangeraden in `.claude/hooks/pre-commit-secret-scan.sh` als scrub-tool.
  - **Voorgestelde actie:** voeg `anonymize.py` toe aan de lijst in het architectuurdiagram.

- [ ] **MIDDEN**: `.env.example` definieert `HASS_URL`/`HASS_TOKEN` voor een optionele Home Assistant-integratie, maar `.mcp.json` bevat geen bijbehorende MCP-server, en geen skill of document legt uit waarvoor of hoe deze variabelen gebruikt worden. Enige vermeldingen staan in `README.md` en `scripts/setup.sh`, beide slechts als "(optioneel Home Assistant)" zonder verdere uitleg.
  - **Voorgestelde actie:** voeg een MCP-server-config of korte toelichting toe (bijvoorbeeld in `docs/`), of verwijder de HASS-variabelen en verwijzingen totdat de integratie daadwerkelijk bestaat.

- [ ] **MIDDEN**: `scripts/setup.sh` kopieert `wiki/00-context/*.example.md`, `wiki/50-decisions/log.example.md`, `.env.example` en optioneel `.claude/gevoelige-termen.example.txt`, maar kopieert `MEMORY.example.md` nooit naar `MEMORY.md`. De eindchecklist van het script ("Volgende stappen") noemt `MEMORY.md` ook niet. `session-start.sh` handelt een ontbrekend `MEMORY.md` weliswaar gracieus af, maar een nieuwe fork start zonder duidelijke aanwijzing om het bestand aan te maken.
  - **Voorgestelde actie:** voeg een stap toe aan `scripts/setup.sh` die `MEMORY.example.md` naar `MEMORY.md` kopieert, consistent met de andere `.example`-bestanden, of noem de stap expliciet in de eindchecklist.

- [ ] **MIDDEN**: `docs/routines.md` gebruikt op meerdere plekken (regels 54, 74, 86) het hardgecodeerde repo-pad `nickyjacobs/CYRIX-MK-III` in voorbeeldcommando's voor `/schedule` en de web-UI, terwijl `README.md` in zijn Quick start consequent de placeholder `<you>/CYRIX-MK-III` gebruikt. Voor een forker die deze voorbeelden letterlijk overneemt, verwijst het commando naar de verkeerde repo.
  - **Voorgestelde actie:** vervang de voorbeelden door een placeholder (`<jouw-gebruikersnaam>/CYRIX-MK-III`) of voeg een expliciete noot toe dat dit voorbeeld-waarden van de originele repo zijn.

## LAAG

- [ ] **LAAG**: `wiki/40-references/index.md` linkt niet naar `wiki/40-references/ninja-possiblecooker-mc1001eu.md`, een orphan binnen de "Collecties"-lijst. Vervalt als de HOOG-finding hierboven leidt tot verwijdering van het bestand. Anders verdient de pagina alsnog een link of een expliciete reden waarom ze ontbreekt.
  - **Voorgestelde actie:** samen oplossen met de HOOG-finding over dit bestand.

- [ ] **LAAG**: Frontmatter-afwijking ten opzichte van de conventie in `wiki/index.md` ("Minimum per pagina: `title`, `tags`, `category`, `status`"). `wiki/60-audits/lint/daily-audit-2026-06-09.md` mist `title`, `tags` en `category`; `wiki/60-audits/lint/docs-drift-claudecode-2026-06-10.md` mist `tags` en `category`.
  - **Voorgestelde actie:** vul de ontbrekende velden aan, of documenteer in `wiki/index.md` dat audit-rapporten in `60-audits/lint/` een eigen frontmatter-schema volgen. Ze gebruiken nu `audit-date`/`auditor`/`scope`/`status` in plaats daarvan.

- [ ] **LAAG**: `README.md` regel 4-7. De HTML-comment stelt voor de GitHub user-attachments-afbeelding te vervangen door `assets/cyrix-logo.png`, maar `assets/` bevat alleen een `.gitkeep`. De externe afbeelding werkt nog, dus dit is geen gebroken weergave, enkel een openstaande todo.
  - **Voorgestelde actie:** voeg `assets/cyrix-logo.png` toe en update de `src`, of verwijder de comment totdat dat gebeurt.

---

## Stijl-check (advisory, `check_verboden_woorden.py`)

Gedraaid op `README.md` en alle `.md`-bestanden in `docs/`:

| Bestand | Issues | Type |
|---|---|---|
| `README.md` | 24 | uitsluitend em-dashes (Engelse tekst, maar de hook checkt root-README sowieso) |
| `docs/routines.md` | 0 | geen |
| `docs/archief/README.md` | 0 | geen |
| `docs/archief/verificatie-fase1.md` | 18 | em-dashes plus enkele bewust geplaatste signaalwoorden, gebruikt als voorbeeldinput om de checker zelf te demonstreren |
| `docs/archief/verificatie-fase2.md` | 14 | em-dashes plus twee vervoegde signaalwoorden uit dezelfde verboden-lijst |

Alle meldingen zijn non-blocking. De waarschuwingen in `docs/archief/` zitten grotendeels in bewust gekozen testzinnen die de werking van `check_verboden_woorden.py` demonstreren, dus weinig actiegericht. De 24 em-dashes in `README.md` zijn wel reëel fixbare stijlpunten als het bestand ooit via `/dutch-write`-achtige discipline opgeschoond wordt, al is README.md Engelstalig en valt het strikt genomen buiten de Nederlandse schrijfregels.

## Niet gerapporteerd (verwacht, buiten scope)

- Lege of alleen-`.example`/`.gitkeep`-mappen in `wiki/00-context/`, `wiki/10-projects/`, `wiki/20-knowledge/`, `wiki/30-sessions/`, `wiki/50-decisions/`, `wiki/90-archives/`.
- Wikilinks vanuit `wiki/index.md` naar `00-context/me`, `work`, `team`, `current-priorities`, `goals`. Deze wijzen pas ergens heen na lokale setup, zoals de pagina zelf aangeeft.
- Verwijzingen naar `wiki/60-audits/audit-2026-09-10-compleet.md` (buiten `lint/`, dus gitignored net als de andere persoonlijke categorieën) vanuit `daily-audit-2026-06-09.md` en `docs-drift-claudecode-2026-06-10.md`.

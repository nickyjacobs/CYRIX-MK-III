---
name: einde-sessie
description: Sluit de huidige sessie af en verwerk de kennis naar de wiki. Schrijft sessie-log, merget inzichten naar MEMORY.md, appendt besluiten aan decisions/log.md, en update betroffen wiki-pagina's. Triggert automatisch via Stop-hook bij substantiële sessies, kan ook handmatig.
---

# /einde-sessie

## Wanneer gebruiken

- Aan het einde van een werksessie die substantiële kennis of voortgang opleverde
- Wanneer een besluit genomen is dat geregistreerd moet worden
- Bij wisseling naar een ander onderwerp binnen één sessie (mini-afsluiting)
- Automatisch via Stop-hook bij sessies > 5 tool-uses

**Niet voor:** triviale sessies (één vraag, één antwoord). De Stop-hook detecteert dit.

## Hoe het werkt

### Stap 1 — Focus bepalen

**Interactive mode** (handmatige aanroep of `--interactive`):
Vraag aan gebruiker: *"De focus van deze sessie was [X]. Klopt dat, of moet ik dit aanpassen?"*

**Automatic mode** (via Stop-hook of `--auto`):
Geen bevestiging vragen — focus direct afleiden, log schrijven, melden wat geschreven is.

In beide modi leid je de focus af uit:
- De eerste user-prompt van de sessie
- De Plan/TaskList als die gebruikt is
- De grootste cluster wijzigingen (git diff)
- TaskList completion-state (welke tasks zijn afgerond)

### Stap 2 — Vervang eventuele stub

Check of `wiki/30-sessions/YYYY-MM-DD-onafgesloten.md` bestaat (geschreven door Stop-hook bij eerdere sessie-end). Als die er is: vervang volledig met deze formele log.

### Stap 3 — Schrijf sessie-log

Gebruik `wiki/_templates/session.md`. Vul in:

- `title`, `date`, `focus`, `tool-uses` (uit hook-context), `duration-min` (geschat)
- **Doel** — wat wilde je bereiken
- **Vooraf** — beginstatus (git status, fase, vorige open items)
- **Wat er gedaan is** — chronologisch, met subsecties per logisch blok
- **Besluiten** — bullets van wat besloten is (samenvatting; detail naar log.md)
- **Inzichten / lessen** — wat geleerd
- **Openstaand** — wat niet af is gekomen
- **Volgende stappen** — concrete acties (worden zichtbaar bij volgende SessionStart)

Pad: `wiki/30-sessions/YYYY-MM-DD-<korte-slug>.md`

### Stap 4 — Update MEMORY.md (merge)

Voor elk inzicht in "Inzichten / lessen":

1. Read MEMORY.md
2. Check op duplicaat (semantische match op titel)
3. **Bij nieuw inzicht:** append in juiste sectie met format uit MEMORY.md
4. **Bij update van bestaand:** vervang met nieuwe datum, oude content naar `wiki/90-archives/memory-archive.md`
5. **Géén** blind append — altijd merge

### Stap 5 — Append decisions/log.md

Voor elk besluit in "Besluiten":

```markdown
## YYYY-MM-DD — <korte titel>
**Gebied:** <bv. architecture | tools | priorities | workflow>
**Besluit:** <wat besloten>
**Onderbouwing:** <waarom>
**Impact:** <wat verandert>
**Verwijzing:** [[30-sessions/YYYY-MM-DD-<slug>]]
```

Path: `wiki/50-decisions/log.md` (append-only).

### Stap 6 — Update betroffen wiki-pagina's

Als de sessie impact had op:
- **Project-README** (`wiki/10-projects/<naam>/README.md`) — update "Recente voortgang" en "Volgende concrete stap"
- **Priorities** (`wiki/00-context/current-priorities.md`) — update status / datum / actieve items
- **Knowledge-notes** (`wiki/20-knowledge/*`) — update of voeg toe als nieuwe kennis ontstond

Doe dit alleen voor pagina's die je expliciet hebt aangeraakt of die direct relevant zijn — geen brede sweeps.

### Stap 7 — Rapportage

Geef gebruiker:

```
Sessie afgesloten:
- Log: wiki/30-sessions/2026-06-09-cyrix-mk-iii-fase1.md
- MEMORY: 2 nieuwe inzichten, 1 update
- Decisions: 1 besluit toegevoegd
- Updates: wiki/10-projects/cyrix-mk-iii/README.md
```

## Gedrag

- **Commit niet automatisch** — de gebruiker beslist wanneer er gecommit wordt
- **Geen wiki/ wijzigingen buiten de bovenstaande paden** zonder expliciete vraag
- **Idempotent** — meermaals aanroepen overschrijft niet, voegt geen duplicaten toe (door merge-logica)
- **Bij conflict** (bv. bestaande sessie-log voor zelfde dag met andere focus): vraag of het een aparte log moet worden (`-<slug>-2`) of een merge

## Inputs

- **Optioneel:** `--focus=<korte slug>` — override de auto-gedetecteerde focus
- **Optioneel:** `--no-merge` — schrijf alleen sessie-log, sla MEMORY/decisions/wiki update over
- **Optioneel:** `--dry-run` — toon wat geschreven zou worden zonder schrijven
- **Optioneel:** `--interactive` of `--auto` — forceer mode (default: interactive bij directe aanroep, auto bij Stop-hook)

## Trigger en mode-detectie

| Trigger | Mode | Bevestiging vragen? |
|---|---|---|
| Stop-hook (substantiële sessie zonder /einde-sessie) | automatic | Nee — schrijf direct |
| Gebruiker zegt `/einde-sessie` of "einde sessie" | interactive | Ja — bevestig focus en geef preview |
| `/einde-sessie --auto` | automatic | Nee |
| `/einde-sessie --interactive` | interactive | Ja |
| `/einde-sessie --force` | automatic | Nee — ook bij triviale sessies |

## Conflict-resolutie bij stub

Als Stop-hook eerder een `wiki/30-sessions/YYYY-MM-DD-onafgesloten.md` schreef en je roept later `/einde-sessie` aan: **vervang** de stub volledig met de formele log. Geen merge — een formele log is altijd autoritatiever dan een stub.

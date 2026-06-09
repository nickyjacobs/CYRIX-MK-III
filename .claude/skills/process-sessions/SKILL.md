---
name: process-sessions
description: Verwerk raw sessie-logs uit wiki/30-sessions/raw/ via @session-curator naar gestructureerde wiki-content (knowledge, decisions, project-updates, MEMORY). Roept session-curator agent aan per log in dry-run mode, vraagt akkoord per groep, schrijft + committeert pas bij apply. Standaard wijze om de backlog te verwerken die de SessionEnd-hook achterlaat.
---

# /process-sessions

## Wanneer gebruiken

- Na één of meerdere sessies: lees ingest-marker of scan raw/-folder, distilleer kennis naar wiki
- Wekelijks als hygiëne — voorkomt dat raw/-folder vol loopt
- Vóór een grote refactor van CYRIX zelf: oude inzichten naar boven halen

## Hoe het werkt

### Stap 1 — Vind te-verwerken raw logs

Twee bronnen:

1. **Marker-file** (primair) — `/tmp/cyrix-ingest-backlog.txt` heeft `session_id|raw_path|processed_path|date` per regel, geschreven door SessionEnd-hook
2. **Folder-scan** (fallback) — `find wiki/30-sessions/raw -name "*.md" ! -path "*/processed/*"` — alles wat nog niet verwerkt is

Bij argument `--since=YYYY-MM-DD`: filter op datum uit frontmatter.

### Stap 2 — Per log: roep session-curator aan in dry-run

```
@session-curator
Analyseer: wiki/30-sessions/raw/<filename>.md
Mode: dry-run — toon plan, schrijf niets.
```

De agent retourneert een gestructureerd plan (knowledge / decisions / project / memory / archives).

### Stap 3 — Vraag akkoord per groep

Aan de gebruiker:

```
Voor wiki/30-sessions/raw/<filename>.md heeft session-curator dit plan:

[plan van agent]

Wat doe ik?
  [a] apply all
  [k] alleen knowledge schrijven
  [d] alleen decisions
  [p] alleen project-updates
  [m] alleen MEMORY
  [s] skip deze log
  [q] stop met process-sessions
```

### Stap 4 — Uitvoeren (afhankelijk van keuze)

Bij `apply all` of partial: roep `@session-curator` opnieuw aan met `--apply` flag voor die bucket(s). Curator schrijft de bestanden.

### Stap 5 — Commit per logische groep

Na succesvolle apply: commit per bucket:

```
# Per bucket een schone commit (niet alles in 1 grote)
git add wiki/20-knowledge/
git commit -m "Distil session <date>: 2 knowledge notes"

git add wiki/50-decisions/log.md
git commit -m "Distil session <date>: 1 decision logged"

git add wiki/10-projects/
git commit -m "Distil session <date>: project updates"

git add MEMORY.md
git commit -m "Distil session <date>: MEMORY merge"
```

NIET auto-pushen. Eigenaar pusht handmatig na review (`git push`).

### Stap 6 — Markeer log als verwerkt

Verplaats raw-log naar `wiki/30-sessions/raw/processed/<filename>` (sub-folder, ook gitignored).

Verwijder de bijbehorende regel uit `/tmp/cyrix-ingest-backlog.txt`.

### Stap 7 — Eindrapport

Per log:

```
✓ wiki/30-sessions/raw/2026-06-09-1603-foo.md
  Buckets toegepast: knowledge(2), decisions(1), project(1), memory(1)
  Skipped: 0 archives
  4 commits gemaakt (niet gepusht)

Totaal over 3 logs: 5 knowledge, 2 decisions, 3 project-updates, 4 memory-merges.
Volgende: 'git push' om te delen.
```

## Inputs

- **Geen verplichte argumenten** — leest backlog automatisch
- `--since=YYYY-MM-DD` — filter op datum
- `--dry-run` — toon plan voor ALLE logs, schrijf NIETS (overschrijft per-log dry-run)
- `--auto-apply` — geen bevestiging per groep (gevaarlijk, alleen bij sterke confidence)
- `--log=<pad>` — verwerk specifieke raw-log, negeer backlog

## Gedrag

- **Default behaviour** = veilig: per log één keer agent in dry-run, dan akkoord vragen, dan apply
- **Geen auto-push** — gebruiker controleert wat extern wordt
- **Idempotent** — verwerkte logs (in `raw/processed/`) worden niet opnieuw verwerkt
- **Failover** — bij fouten in één log: rapporteer en ga door met volgende

## Relatie tot andere componenten

- **SessionEnd hook** schrijft raw logs en de ingest-marker
- **session-curator agent** doet het denkwerk (categorisatie + distillatie)
- **/einde-sessie skill** (handmatige variant) genereert geen marker; gebruik deze skill voor sessies die via SessionEnd-hook geschreven werden

## Voorbeeld-gebruik

```
> /process-sessions
Ik vind 3 raw logs in de backlog. Begin met de oudste?
[1] 2026-06-07-fase1-finishing.md  → 4 tool-uses, 12 changes
[2] 2026-06-08-rename-prep.md      → 7 tool-uses, 5 changes
[3] 2026-06-09-1603-c2-test.md     → 1 tool-use, 2 changes (waarschijnlijk skippen)

> Begin met [1]
[session-curator output: plan voor log 1...]

> apply all
[curator schrijft 3 knowledge + 1 decision + project-update]
✓ 4 commits gemaakt.

> Volgende? [2]
...
```

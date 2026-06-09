# CYRIX MK-III — Cloud routines

> Setup-gids voor `wiki-librarian` cloud-routines. Vereist Claude Code v2.x+ met cloud-account.

## Wat zijn routines

[Claude Code routines](https://code.claude.com/docs/en/routines) zijn cloud-gehoste, geplande sessies met volledige tool-access. Ze draaien onafhankelijk van je lokale machine — je MacBook hoeft niet aan te staan.

Voor CYRIX gebruiken we routines om de `wiki-librarian` agent op drie cadansen automatisch te draaien.

## De drie wiki-routines

| Naam | Schedule | Mode | Doel |
|---|---|---|---|
| `cyrix-wiki-audit-daily` | Elke dag 09:00 CET | daily | Lichte lint: broken links, frontmatter, orphans, lege notes |
| `cyrix-wiki-audit-weekly` | Zondag 18:00 CET | weekly | Structuur-consistentie, duplicates, openstaande TODOs |
| `cyrix-wiki-audit-monthly` | 1e van de maand 18:00 CET | monthly | Diepe audit: archives, MEMORY-opschoning, stale references |

Findings landen in `wiki/60-audits/`. Escalerend mechanisme: ongelegen findings rijzen door naar de volgende cadens.

## Setup-instructies

### Vereisten

- Claude Code v2.x of nieuwer (`claude --version`)
- Actief Claude.ai account (cloud-toegang)
- Repo `cyrix-mk-iii` gecloned met `.claude/agents/wiki-librarian.md` aanwezig
- `.env` of shell-env met `GITHUB_TOKEN` (voor commit-toegang vanuit cloud)

### Routine 1 — daily

```bash
claude routine create \
  --name cyrix-wiki-audit-daily \
  --schedule "0 9 * * *" \
  --timezone Europe/Amsterdam \
  --repo nickyjacobs/cyrix-mk-iii \
  --prompt "@wiki-librarian daily — schrijf de audit naar wiki/60-audits/ en commit + push het rapport met message 'wiki: daily audit YYYY-MM-DD'"
```

### Routine 2 — weekly

```bash
claude routine create \
  --name cyrix-wiki-audit-weekly \
  --schedule "0 18 * * 0" \
  --timezone Europe/Amsterdam \
  --repo nickyjacobs/cyrix-mk-iii \
  --prompt "@wiki-librarian weekly — schrijf de audit naar wiki/60-audits/ en commit + push het rapport met message 'wiki: weekly audit YYYY-MM-DD'"
```

### Routine 3 — monthly

```bash
claude routine create \
  --name cyrix-wiki-audit-monthly \
  --schedule "0 18 1 * *" \
  --timezone Europe/Amsterdam \
  --repo nickyjacobs/cyrix-mk-iii \
  --prompt "@wiki-librarian monthly — schrijf de audit naar wiki/60-audits/ en commit + push het rapport met message 'wiki: monthly audit YYYY-MM-DD'"
```

## Verificatie

Na setup, check:

```bash
claude routine list
# Verwacht 3 actieve routines

claude routine run cyrix-wiki-audit-daily --dry-run
# Test-run zonder commit
```

## Beheer

- **Pauzeren**: `claude routine pause cyrix-wiki-audit-daily`
- **Hervatten**: `claude routine resume cyrix-wiki-audit-daily`
- **Verwijderen**: `claude routine delete cyrix-wiki-audit-daily`
- **Logs**: `claude routine logs cyrix-wiki-audit-daily --tail 50`

## Kosten

Routines worden gefactureerd op cloud-compute. Reken op:

- Daily: <2 min compute → minimaal
- Weekly: 5-10 min compute
- Monthly: 15-30 min compute

Bij eerste maand: monitor via `claude routine logs` of de tijden binnen verwachting blijven.

## Wat als ik geen cloud-routines wil

Lokaal alternatief via `launchd` op macOS (handmatig opgezet, MacBook moet aan staan):

```bash
# Voorbeeld plist in ~/Library/LaunchAgents/com.cyrix.wiki-audit-daily.plist
# Roept aan: claude -p "@wiki-librarian daily" in cyrix-mk-iii directory
```

Zie `scripts/launchd/` voor template plists (komt in fase 2).

## Handmatig draaien

Altijd mogelijk vanuit de CYRIX-werkomgeving:

```
@wiki-librarian daily
@wiki-librarian weekly
@wiki-librarian monthly
```

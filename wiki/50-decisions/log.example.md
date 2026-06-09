---
title: Besluitenlog
created: 2026-06-09
updated: 2026-06-09
tags: [decisions, log]
category: 50-decisions
status: active
---

# Besluitenlog

> Kopieer dit bestand naar `log.md` (gitignored). Append-only — elk besluit krijgt een gedateerde entry.
> `/einde-sessie` schrijft hier automatisch naar wanneer een sessie besluiten oplevert.

## Format

```markdown
## YYYY-MM-DD — Korte titel
**Gebied:** architecture | tools | priorities | workflow | personal
**Besluit:** Wat is besloten — één à twee zinnen.
**Onderbouwing:** Waarom — context, afgewogen alternatieven.
**Impact:** Wat verandert er door dit besluit.
**Verwijzing:** [[30-sessions/YYYY-MM-DD-slug]] (optioneel — sessie waar besluit viel)
```

---

## 2026-06-09 — Setup besluitenlog
**Gebied:** workflow
**Besluit:** Besluitenlog ingericht als append-only markdown-file in `wiki/50-decisions/log.md`.
**Onderbouwing:** Versiebeheerbare audit-trail van keuzes, makkelijk te grep'en, geen tooling-afhankelijkheid.
**Impact:** Alle architectuur- en workflow-beslissingen worden hier vastgelegd via `/einde-sessie` of handmatig.

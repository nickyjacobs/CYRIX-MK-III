---
title: Claude Code — Slash Commands (gemerged met Skills)
source-url: https://code.claude.com/docs/en/slash-commands
ingest-date: 2026-06-09
review-date: 2026-09-09
tags: [reference, claude-code, skills]
category: 40-references
status: active
---

# Claude Code — Slash commands (skills)

> Bron: https://code.claude.com/docs/en/slash-commands · Custom commands zijn gemerged met skills.

**Belangrijk:** sinds een recente release zijn custom slash commands samengevoegd met skills. Een file op `.claude/commands/deploy.md` en een skill op `.claude/skills/deploy/SKILL.md` maken beide `/deploy` en werken hetzelfde.

`.claude/commands/` files blijven backwards-compatible werken. Voor nieuwe commands: gebruik `.claude/skills/<naam>/SKILL.md` — die ondersteunt extra features (supporting files in de folder, frontmatter voor invocation control, automatische loading bij relevantie).

## Ingebouwde commands (built-in)

Worden altijd geladen, executeren vaste logica:

- `/help` — toon beschikbare commands
- `/clear` — wis sessie-context
- `/compact` — comprimeer conversatie
- `/config` — settings menu
- `/agents` — overzicht subagents

## Bundled skills (prompt-based built-ins)

Worden bij elke sessie geleverd, werken als prompts (geen fixed logic):

- `/code-review`, `/batch`, `/debug`, `/loop`, `/claude-api`
- `/run`, `/verify`, `/run-skill-generator` (v2.1.145+)

## Custom skills

Eigen functionaliteit, drie locaties:

| Locatie | Scope |
|---|---|
| `~/.claude/skills/<naam>/` | User-level (alle projecten) |
| `.claude/skills/<naam>/` | Project-level |
| Plugin `skills/` directory | Via geïnstalleerde plugin |

### Minimal SKILL.md

```markdown
---
description: Wanneer/waarvoor deze skill gebruikt wordt. Helpt Claude bij auto-invocatie.
---

# Skill naam

Instructies voor Claude wanneer de skill draait.
```

### Frontmatter velden

- `description` — auto-invocatie criteria (verplicht voor model-invocation)
- `disable-model-invocation` — alleen via expliciete `/skill-naam` aanroep
- `allowed-tools` — beperk tool-toegang (bv. `Read, Glob, Grep`)
- `argument-hint` — hint voor `$ARGUMENTS` placeholder
- `name` — overschrijf folder-naam als skill-naam

### Argumenten

`$ARGUMENTS` placeholder in SKILL.md wordt vervangen door de tekst na de skill-naam:

```markdown
---
description: Greet a user
---
Greet "$ARGUMENTS" warmly.
```

Aanroep: `/greet Alex` → Claude krijgt "Greet 'Alex' warmly."

## Dynamic context injection

Voer een commando uit en injecteer de output VOORDAT Claude de skill ziet:

```markdown
## Current changes

!`git diff HEAD`

## Instructions
Summarize the changes above.
```

De `!`backtick-command`` wordt vervangen door de stdout van het commando.

## CYRIX MK-III gebruik

Onze 4 skills in `.claude/skills/`:
- `/search` — Tavily fallback search
- `/ingest` — doc/text ingest naar wiki
- `/einde-sessie` — sessie afsluiten
- `/dutch-write` — NL-tekst herschrijven

Plus de wiki-librarian agent: `@wiki-librarian daily|weekly|monthly`.

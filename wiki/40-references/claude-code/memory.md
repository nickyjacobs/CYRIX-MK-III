---
title: Claude Code — Memory
source-url: https://code.claude.com/docs/en/memory
ingest-date: 2026-03-26
review-date: 2026-09-09
tags: [reference, claude-code]
category: 40-references
status: active
---

# Memory (CLAUDE.md & Auto Memory)

> Bron: https://code.claude.com/docs/en/memory

Elke Claude Code sessie begint met een vers context window. Twee mechanismen dragen kennis over tussen sessies:

- **CLAUDE.md bestanden**: instructies die jij schrijft
- **Auto memory**: notities die Claude zelf schrijft

## CLAUDE.md vs Auto Memory

| | CLAUDE.md | Auto Memory |
|--|-----------|-------------|
| **Wie schrijft** | Jij | Claude |
| **Wat** | Instructies en regels | Learnings en patronen |
| **Scope** | Project, user, of org | Per working tree |
| **Geladen in** | Elke sessie | Elke sessie (eerste 200 regels) |
| **Gebruik voor** | Coding standards, workflows, architectuur | Build commands, debugging, preferences |

## CLAUDE.md locaties

| Scope | Locatie | Doel |
|-------|---------|------|
| **Managed policy** | `/Library/Application Support/ClaudeCode/CLAUDE.md` (macOS) | Organisatie-breed |
| **Project** | `./CLAUDE.md` of `./.claude/CLAUDE.md` | Team-gedeeld |
| **User** | `~/.claude/CLAUDE.md` | Persoonlijke voorkeuren |

### Loading

- CLAUDE.md bestanden in de directory hierarchy boven de working directory worden volledig geladen bij launch
- CLAUDE.md bestanden in subdirectories laden on-demand wanneer Claude bestanden in die directories leest

## Effectieve instructies schrijven

- **Grootte**: richt op <200 regels per CLAUDE.md
- **Structuur**: markdown headers en bullets
- **Specificiteit**: concreet genoeg om te verifieren
  - Goed: "Use 2-space indentation"
  - Slecht: "Format code properly"
- **Consistentie**: vermijd tegenstrijdige regels

## Imports

Gebruik `@path/to/import` syntax:

```markdown
Zie @README voor project overzicht en @package.json voor npm commands.

# Extra instructies
- Git workflow @docs/git-instructions.md
- Persoonlijk @~/.claude/my-project-instructions.md
```

Imports ondersteunen relatieve en absolute paden, max 5 niveaus diep.

## .claude/rules/

Voor grotere projecten, split instructies in meerdere bestanden:

```
.claude/
├── CLAUDE.md
└── rules/
    ├── code-style.md
    ├── testing.md
    └── security.md
```

### Path-specific rules

Scope regels aan specifieke bestanden met YAML frontmatter:

```yaml
---
paths:
  - "src/api/**/*.ts"
---

# API Development Rules
- Alle endpoints moeten input validatie bevatten
- Gebruik standaard error response format
```

### User-level rules

Persoonlijke regels in `~/.claude/rules/` gelden voor elk project.

## Auto Memory

Claude slaat automatisch notities op: build commands, debugging insights, architectuur, code style preferences.

### Enablen/disablen

- `/memory` command in sessie
- `autoMemoryEnabled: false` in project settings
- `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1` env var

### Opslag

```
~/.claude/projects/<project>/memory/
├── MEMORY.md          # Index, geladen elke sessie (eerste 200 regels)
├── debugging.md       # Gedetailleerde notities
├── api-conventions.md # API design decisions
└── ...
```

- Machine-lokaal
- Alle worktrees in dezelfde git repo delen een memory directory
- Custom locatie: `autoMemoryDirectory` in settings

### /memory command

Toont alle geladen CLAUDE.md en rules bestanden, toggle auto memory, open memory folder.

## Tips

- Draai `/init` om een startende CLAUDE.md automatisch te genereren
- HTML comments (`<!-- -->`) in CLAUDE.md worden gestript uit context
- Na `/compact` wordt CLAUDE.md opnieuw geladen vanaf disk
- `claudeMdExcludes` in settings om specifieke CLAUDE.md bestanden over te slaan (handig in monorepos)

---
title: Claude Code — Output Styles
source-url: https://code.claude.com/docs/en/output-styles
ingest-date: 2026-06-09
review-date: 2026-09-09
tags: [reference, claude-code, customization]
category: 40-references
status: active
---

# Claude Code — Output Styles

> Bron: https://code.claude.com/docs/en/output-styles

Output styles veranderen **hoe** Claude antwoordt (rol, toon, format), niet **wat** Claude weet. Ze passen de system prompt aan. Gebruik wanneer je dezelfde voice/format herhaaldelijk vraagt, of wanneer Claude iets anders moet zijn dan een software engineer.

Voor project-conventies en codebase-context: gebruik [CLAUDE.md](https://code.claude.com/docs/en/memory) in plaats van een output style.

## Ingebouwde styles

| Style | Wat het doet |
|---|---|
| **Default** | Standaard software-engineering instructies |
| **Proactive** | Direct uitvoeren, redelijke aannames, action over planning. Sterker dan auto-mode, werkt mét permission prompts. |
| **Explanatory** | Voegt "Insights" toe tussen taken — onderwijst over implementatie-keuzes |
| **Learning** | Collaboratief leer-by-doing: `TODO(human)` markers in code voor de gebruiker |

## Wisselen

- `/config` → Output style menu
- Of direct in settings.json: `"outputStyle": "Explanatory"`
- Treedt in werking na `/clear` of nieuwe sessie

Selectie wordt opgeslagen in `.claude/settings.local.json` (lokaal per project).

## Custom output style maken

Een markdown-file met YAML frontmatter, opgeslagen op één van drie locaties:

- **User**: `~/.claude/output-styles/`
- **Project**: `.claude/output-styles/`
- **Managed policy**: in de managed settings directory

File-naam wordt style-naam (of override via `name:` frontmatter).

### Frontmatter

| Veld | Doel | Default |
|---|---|---|
| `name` | Style naam | filename |
| `description` | Getoond in `/config` picker | none |
| `keep-coding-instructions` | Behoud built-in software engineering instructies | `false` |
| `force-for-plugin` | Plugin-style auto-activeren | `false` |

Bij `keep-coding-instructions: false` (default): vervangt code-instructies volledig. Bij `true`: alleen aanvullen.

## Voorbeeld custom style

```markdown
---
name: Diagrams first
description: Lead every explanation with a diagram
keep-coding-instructions: true
---

When explaining code, architecture, or data flow, start with a Mermaid diagram showing the structure, then explain in prose.

## Diagram conventions
Use `flowchart TD` for control flow and `sequenceDiagram` for request paths. Keep diagrams under 15 nodes.
```

## Verhouding tot andere features

| Feature | Hoe het werkt | Wanneer gebruiken |
|---|---|---|
| Output styles | Past system prompt aan | Andere rol/toon/format voor elke turn |
| CLAUDE.md | User-message na system prompt | Project conventies en codebase context |
| `--append-system-prompt` | Voegt toe aan system prompt zonder vervangen | One-off voor één invocatie |
| Agents | Aparte subagent met eigen system prompt | Focused gescopete helper |
| Skills | Task-specifieke instructies bij invocatie | Herbruikbare workflow |

## Mogelijke MK-III use cases

- **Custom style voor JacOps content** — bv. pentest-rapporten met vaste structuur (executive summary → findings → remediation)
- **Diagrams-first** voor architectuur-discussies
- Niet kritisch voor fase 1

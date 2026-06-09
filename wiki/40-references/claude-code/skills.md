---
title: Claude Code — Skills
source-url: https://code.claude.com/docs/en/skills
ingest-date: 2026-03-26
review-date: 2026-09-09
tags: [reference, claude-code]
category: 40-references
status: active
---

# Skills

> Bron: https://code.claude.com/docs/en/skills

Skills breiden uit wat Claude kan doen. Maak een `SKILL.md` bestand met instructies, en Claude voegt het toe aan zijn toolkit. Claude gebruikt skills wanneer relevant, of je roept ze direct aan met `/skill-name`.

## Locaties

| Locatie | Pad | Geldt voor |
|---------|-----|-----------|
| Enterprise | Managed settings | Alle gebruikers in organisatie |
| Personal | `~/.claude/skills/<skill-name>/SKILL.md` | Al je projecten |
| Project | `.claude/skills/<skill-name>/SKILL.md` | Alleen dit project |
| Plugin | `<plugin>/skills/<skill-name>/SKILL.md` | Waar plugin enabled is |

Prioriteit: enterprise > personal > project.

## Structuur

```
my-skill/
├── SKILL.md           # Hoofdinstructies (verplicht)
├── template.md        # Template voor Claude om in te vullen
├── examples/
│   └── sample.md      # Voorbeeld output
└── scripts/
    └── validate.sh    # Script dat Claude kan uitvoeren
```

## Frontmatter referentie

```yaml
---
name: my-skill
description: Wat deze skill doet
disable-model-invocation: true
user-invocable: true
allowed-tools: Read, Grep
model: sonnet
effort: high
context: fork
agent: Explore
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/check.sh"
shell: bash
---

Skill instructies hier...
```

| Veld | Verplicht | Beschrijving |
|------|-----------|-------------|
| `name` | Nee | Display naam (default: mapnaam). Lowercase, hyphens, max 64 chars |
| `description` | Aanbevolen | Wat de skill doet en wanneer te gebruiken |
| `argument-hint` | Nee | Hint bij autocomplete (bijv. `[issue-number]`) |
| `disable-model-invocation` | Nee | `true` = Claude kan niet automatisch aanroepen |
| `user-invocable` | Nee | `false` = verborgen uit `/` menu |
| `allowed-tools` | Nee | Tools zonder permissie-prompt wanneer skill actief is |
| `model` | Nee | Model wanneer skill actief is |
| `effort` | Nee | Effort level: `low`, `medium`, `high`, `max` |
| `context` | Nee | `fork` = draai in een geforkte subagent context |
| `agent` | Nee | Welk subagent type bij `context: fork` |
| `hooks` | Nee | Hooks scoped aan deze skill's lifecycle |
| `shell` | Nee | Shell voor `` !`command` `` blokken: `bash` of `powershell` |

## Invocation control

| Frontmatter | Jij kunt aanroepen | Claude kan aanroepen | Wanneer geladen |
|-------------|-------------------|---------------------|----------------|
| (default) | Ja | Ja | Description altijd in context, full skill bij invocatie |
| `disable-model-invocation: true` | Ja | Nee | Niet in context, full skill bij jouw invocatie |
| `user-invocable: false` | Nee | Ja | Description altijd in context, full skill bij invocatie |

## String substitutions

| Variabele | Beschrijving |
|-----------|-------------|
| `$ARGUMENTS` | Alle argumenten bij aanroep |
| `$ARGUMENTS[N]` of `$N` | Specifiek argument (0-based) |
| `${CLAUDE_SESSION_ID}` | Huidige sessie ID |
| `${CLAUDE_SKILL_DIR}` | Map van de skill's SKILL.md |

## Dynamische context injectie

De `` !`<command>` `` syntax voert shell commands uit VOOR de skill content naar Claude gaat:

```yaml
---
name: pr-summary
context: fork
agent: Explore
---

## PR context
- PR diff: !`gh pr diff`
- Changed files: !`gh pr diff --name-only`

## Taak
Vat deze PR samen...
```

## Bundled skills

| Skill | Doel |
|-------|------|
| `/batch <instruction>` | Grote veranderingen over codebase parallel orchestreren |
| `/claude-api` | Claude API referentiemateriaal laden |
| `/debug [description]` | Debug logging inschakelen en problemen troubleshooten |
| `/loop [interval] <prompt>` | Prompt herhaaldelijk draaien op interval |
| `/simplify [focus]` | Recent gewijzigde code reviewen op reuse, kwaliteit, efficiency |

## Skills in subagent draaien

Voeg `context: fork` toe om een skill in isolatie te draaien:

```yaml
---
name: deep-research
context: fork
agent: Explore
---

Research $ARGUMENTS:
1. Zoek relevante bestanden
2. Analyseer de code
3. Vat bevindingen samen
```

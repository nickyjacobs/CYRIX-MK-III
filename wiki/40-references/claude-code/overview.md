---
title: Claude Code — Overview
source-url: https://code.claude.com/docs/en/overview
ingest-date: 2026-03-26
review-date: 2026-09-09
tags: [reference, claude-code]
category: 40-references
status: active
---

# Claude Code Overview

> Bron: https://code.claude.com/docs/en/overview

Claude Code is een agentic coding tool dat je codebase leest, bestanden bewerkt, commands uitvoert en integreert met development tools. Beschikbaar in terminal, IDE, desktop app en browser.

## Installatie

### Terminal (native install)

```bash
# macOS, Linux, WSL
curl -fsSL https://claude.ai/install.sh | bash

# Windows PowerShell
irm https://claude.ai/install.ps1 | iex
```

### Homebrew

```bash
brew install --cask claude-code
```

### Starten

```bash
cd your-project
claude
```

## Beschikbare omgevingen

| Omgeving | Beschrijving |
|----------|-------------|
| **Terminal** | Full-featured CLI |
| **VS Code** | Extension met inline diffs, @-mentions, plan review |
| **JetBrains** | Plugin voor IntelliJ, PyCharm, WebStorm etc. |
| **Desktop app** | Standalone app voor Mac en Windows |
| **Web** | Browser-based op claude.ai/code |

## Wat je ermee kunt doen

- **Automatiseren**: tests schrijven, lint errors fixen, merge conflicts oplossen, dependencies updaten
- **Features bouwen en bugs fixen**: beschrijf in natural language, Claude plant en implementeert
- **Git**: commits maken, branches aanmaken, PRs openen
- **MCP**: externe tools koppelen (Google Drive, Jira, Slack, etc.)
- **Customizen**: CLAUDE.md voor instructies, skills voor herbruikbare workflows, hooks voor automatisering
- **Agent teams**: meerdere Claude instances parallel laten werken
- **CLI scripting**: pipen, CI/CD, chaining met andere tools
- **Scheduling**: terugkerende taken plannen (cloud of lokaal)

## Modellen

| Alias | Model ID | Gebruik |
|-------|----------|---------|
| `opus` | `claude-opus-4-6` | Meest capabel, complex redeneren |
| `sonnet` | `claude-sonnet-4-6` | Balans tussen capability en snelheid |
| `haiku` | `claude-haiku-4-5` | Snel, low-latency taken |

## Surfaces tabel

| Ik wil... | Beste optie |
|-----------|-------------|
| Sessie voortzetten vanaf telefoon | Remote Control |
| Events pushen vanuit Telegram/Discord/iMessage | Channels |
| Taken starten lokaal, voortzetten op mobiel | Web of Claude iOS app |
| Claude op schema draaien | Cloud/Desktop scheduled tasks |
| PR reviews automatiseren | GitHub Actions of GitLab CI/CD |
| Automatische code review op elke PR | GitHub Code Review |
| Bug reports van Slack naar PRs | Slack integratie |
| Live web apps debuggen | Chrome extensie |
| Custom agents bouwen | Agent SDK |

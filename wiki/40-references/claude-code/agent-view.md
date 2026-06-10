---
title: "Claude Code: Agent view"
source-url: https://code.claude.com/docs/en/agent-view
ingest-date: 2026-06-10
review-date: 2026-09-10
tags: [reference, claude-code, agent-view]
category: 40-references
status: active
---

# Agent view

> Bron: https://code.claude.com/docs/en/agent-view

Agent view, geopend met `claude agents`, is één scherm voor al je background sessions: wat draait, wat input nodig heeft, en wat klaar is. Elke background session is een volledige Claude Code conversatie die zonder terminal blijft draaien.

Research preview, vereist Claude Code v2.1.139 of later.

## Kern-loop

1. `claude agents` opent agent view.
2. Type een prompt + `Enter` om een background session te dispatchen.
3. `Space` op een rij opent het peek-panel (recente output of de vraag).
4. `Enter` of `→` om te attachen voor de volledige conversatie.
5. `←` op een lege prompt detacht en gaat terug naar de tabel.

## Sessie-state (icoon-kleur)

| State | Betekenis |
|-------|-----------|
| Working | Claude draait actief tools of genereert |
| Needs input | Wacht op vraag of permissie-beslissing |
| Idle | Niets te doen, klaar voor je prompt |
| Completed | Taak succesvol klaar |
| Failed | Geëindigd met error |
| Stopped | Gestopt via `Ctrl+X` of `claude stop` |

Icoon-vorm: `✻`/`✽` = proces leeft, `∙` = proces afgesloten (peek/reply/attach herstart), `✢` = `/loop`-sessie tussen iteraties.

## Keyboard shortcuts (selectie)

| Shortcut | Actie |
|----------|-------|
| `↑` / `↓` | Tussen rijen |
| `Enter` | Attach, of dispatch als er tekst staat |
| `Space` | Peek-panel openen/sluiten |
| `Shift+Enter` | Dispatch en direct attach |
| `Ctrl+S` | Groeperen op state of directory |
| `Ctrl+T` | Sessie pinnen/unpinnen |
| `Ctrl+R` | Sessie hernoemen |
| `Ctrl+X` | Stoppen; nogmaals binnen 2s om te verwijderen |
| `?` | Alle shortcuts |

## Dispatchen

- **Vanuit agent view**: prompt + `Enter`. Prefixes: `<agent> <prompt>` of `@<agent>` (custom subagent als main), `@<repo>` (run in die repo), `! <command>` (shell-job als background-rij).
- **Vanuit een sessie**: `/background` of `/bg`.
- **Vanuit shell**: `claude --bg "<prompt>"`, met `--agent`, `--name`, `--model`, `--exec '<cmd>'`.

## Shell-management

| Command | Doel |
|---------|------|
| `claude agents` | Agent view openen |
| `claude agents --cwd <path>` | Scope tot één project (v2.1.141+) |
| `claude agents --json` | Actieve sessies als JSON-array |
| `claude attach <id>` | Attachen in deze terminal |
| `claude logs <id>` | Recente output |
| `claude stop <id>` | Stoppen (ook `claude kill`) |
| `claude respawn <id>` | Herstarten met conversatie intact |
| `claude rm <id>` | Uit lijst verwijderen |
| `claude daemon status` | Supervisor-state |

## File-isolatie

Voor het bewerken van files verplaatst Claude de session naar een geïsoleerde git worktree onder `.claude/worktrees/`. Uitschakelen per repo met `worktree.bgIsolation: "none"` (v2.1.143+). Een session verwijderen in agent view verwijdert de Claude-aangemaakte worktree, inclusief uncommitted changes.

## Hosting en uitschakelen

Background sessions draaien op een per-user supervisor-proces, los van je terminal. State onder `~/.claude/jobs/<id>/`, roster in `~/.claude/daemon/roster.json`. Uitschakelen: setting `disableAgentView: true` of env var `CLAUDE_CODE_DISABLE_AGENT_VIEW`.

Background sessions verbruiken subscription-quota net als interactieve sessies, en stoppen bij machine-shutdown (overleven sleep).

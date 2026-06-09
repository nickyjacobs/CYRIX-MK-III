# Agent Teams (experimenteel)

> Bron: https://code.claude.com/docs/en/agent-teams

Agent teams coordineren meerdere Claude Code instances die samenwerken. Een sessie is de team lead, coordineeert werk, wijst taken toe en synthestiseert resultaten. Teammates werken onafhankelijk, elk in eigen context window.

**Status:** Experimenteel, standaard uitgeschakeld.

## Enablen

```json
// settings.json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
```

## Subagents vs Agent Teams

| | Subagents | Agent Teams |
|--|-----------|-------------|
| **Context** | Eigen window, resultaten terug naar caller | Eigen window, volledig onafhankelijk |
| **Communicatie** | Rapporteert alleen terug naar main agent | Teammates berichten elkaar direct |
| **Coordinatie** | Main agent beheert al het werk | Gedeelde takenlijst met zelf-coordinatie |
| **Best voor** | Gefocuste taken waar alleen resultaat telt | Complex werk dat discussie en samenwerking vereist |
| **Token kosten** | Lager | Hoger (elke teammate is apart Claude instance) |

## Starten

Beschrijf in natural language:

```
Create an agent team to review PR #142. Spawn three reviewers:
- One focused on security implications
- One checking performance impact
- One validating test coverage
```

## Display modes

| Modus | Beschrijving |
|-------|-------------|
| `in-process` | Alles in main terminal, Shift+Down om te wisselen |
| `tmux` | Elke teammate eigen pane, vereist tmux of iTerm2 |
| `auto` (default) | Split panes als al in tmux, anders in-process |

```json
{ "teammateMode": "in-process" }
```

Of per sessie:
```bash
claude --teammate-mode in-process
```

## Architectuur

| Component | Rol |
|-----------|-----|
| **Team lead** | Main sessie, maakt team, spawnt teammates, coordineert |
| **Teammates** | Aparte Claude Code instances, werken aan taken |
| **Task list** | Gedeelde lijst, teammates claimen en voltooien taken |
| **Mailbox** | Berichtensysteem voor communicatie tussen agents |

Opslag:
- Team config: `~/.claude/teams/{team-name}/config.json`
- Task list: `~/.claude/tasks/{team-name}/`

## Taken

Taken hebben drie statussen: **pending**, **in progress**, **completed**.

Taken kunnen afhankelijkheden hebben. Een pending taak met onafgeronde afhankelijkheden kan niet geclaimed worden.

- **Lead assigns**: vertel de lead welke taak aan wie
- **Self-claim**: teammate pakt automatisch de volgende beschikbare taak

## Hooks voor teams

| Event | Wanneer | Kan blokkeren? |
|-------|---------|---------------|
| `TeammateIdle` | Teammate wordt idle | Ja (exit 2 = feedback + doorgaan) |
| `TaskCompleted` | Taak wordt als voltooid gemarkeerd | Ja (exit 2 = niet voltooien + feedback) |

## Best practices

- **3-5 teammates** voor de meeste workflows
- **5-6 taken per teammate** houdt iedereen productief
- Vermijd file conflicts: elke teammate werkt aan eigen set bestanden
- Begin met research/review taken als je nieuw bent met teams
- Monitor en stuur bij
- Vertel de lead te wachten op teammates als hij zelf gaat implementeren

## Beperkingen

- Geen session resumption met in-process teammates
- Task status kan achterlopen
- Shutdown kan traag zijn
- Een team per sessie
- Geen geneste teams
- Lead is vast (niet overdraagbaar)
- Permissies gezet bij spawn
- Split panes vereisen tmux of iTerm2

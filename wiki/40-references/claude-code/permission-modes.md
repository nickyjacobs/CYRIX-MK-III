---
title: "Claude Code: Permission modes"
source-url: https://code.claude.com/docs/en/permission-modes
ingest-date: 2026-06-10
review-date: 2026-09-10
tags: [reference, claude-code, permissions]
category: 40-references
status: active
---

# Permission modes

> Bron: https://code.claude.com/docs/en/permission-modes

Permissie-modes bepalen hoe vaak Claude pauzeert om approval te vragen voor file-edits, shell-commands of netwerk-requests. Modes zetten de baseline; leg permissie-regels eroverheen voor specifieke tools. Deny-regels en expliciete ask-regels gelden in elke mode.

## Beschikbare modes

| Mode | Draait zonder vragen | Best voor |
|------|----------------------|-----------|
| `default` | Alleen reads | Starten, gevoelig werk |
| `acceptEdits` | Reads, file-edits, filesystem-commands (`mkdir`, `touch`, `mv`, `cp`, `rm`, `sed`) | Itereren op code die je reviewt |
| `plan` | Alleen reads | Codebase verkennen voor wijzigen |
| `auto` | Alles, met background safety-checks | Lange taken, minder prompt-moeheid |
| `dontAsk` | Alleen pre-approved tools | Locked-down CI en scripts |
| `bypassPermissions` | Alles | Alleen geïsoleerde containers/VMs |

In elke mode behalve `bypassPermissions` worden writes naar protected paths nooit auto-approved.

## Wisselen

- **Tijdens sessie**: `Shift+Tab` cyclet `default → acceptEdits → plan`. Optionele modes slotten erna in.
- **Bij startup**: `claude --permission-mode plan`. Ook `--dangerously-skip-permissions` (= `bypassPermissions`), `--allow-dangerously-skip-permissions` (voegt toe aan cycle zonder te activeren).
- **Als default**: `{"permissions": {"defaultMode": "acceptEdits"}}`.

VS Code-labels: Ask before edits = `default`, Edit automatically = `acceptEdits`, Plan mode = `plan`, Auto mode = `auto`, Bypass permissions = `bypassPermissions`.

## Plan mode

Claude onderzoekt en stelt voor zonder te wijzigen. In met `Shift+Tab` of `/plan`. Bij approval kies je: start in auto mode, accept edits, manueel reviewen, blijven plannen, of Ultraplan. Approven verlaat plan mode en noemt de sessie naar de plan-inhoud.

## Auto mode

Vereist v2.1.83+. Een aparte classifier-model reviewt acties voor ze draaien en blokkeert wat boven je verzoek escaleert, onbekende infra raakt, of door hostile content lijkt gedreven. Expliciete ask-regels forceren nog steeds een prompt. Research preview, geen veiligheidsgarantie.

Vereisten: admin-enabling op Team/Enterprise; model Opus 4.6+ of Sonnet 4.6 (op Bedrock/Vertex/Foundry alleen Opus 4.7/4.8 plus `CLAUDE_CODE_ENABLE_AUTO_MODE=1`). `defaultMode: "auto"` wordt genegeerd uit project/local settings (v2.1.142+), zet het in `~/.claude/settings.json`.

Geblokkeerd by default: `curl | bash`, sensitieve data naar externe endpoints, production deploys/migraties, mass-deletion, IAM-grants, force push of push naar `main`. Toegestaan: lokale file-ops, dependencies uit lockfiles, read-only HTTP, push naar de start-branch. Boundaries die je in de conversatie stelt ("don't push") blokkeren matchende acties.

Fallback: bij 3x op rij of 20x totaal geblokkeerd pauzeert auto mode en prompt Claude Code weer.

## dontAsk en bypassPermissions

- **`dontAsk`**: auto-denyt elke prompt-waardige call; alleen `permissions.allow` en read-only Bash draaien. Volledig non-interactief. Zetten met `--permission-mode dontAsk`.
- **`bypassPermissions`**: skipt prompts en safety-checks, inclusief writes naar protected paths (v2.1.126+). Ask-regels en `rm -rf /` / `rm -rf ~` prompten nog. Niet te betreden vanuit een sessie zonder enabling-flag. Weigert te starten als root/sudo. Admins blokkeren met `permissions.disableBypassPermissionsMode: "disable"`.

## Protected paths

Nooit auto-approved (behalve in `bypassPermissions`). Directories o.a.: `.git`, `.config/git`, `.vscode`, `.idea`, `.husky`, `.cargo`, `.devcontainer`, `.yarn`, `.mvn`, `.claude` (behalve `.claude/worktrees`). Files o.a.: `.gitconfig`, `.bashrc`/`.zshrc` en varianten, `.npmrc`, `.pre-commit-config.yaml`, `.mcp.json`, `.claude.json`. `permissions.allow`-regels pre-approven protected-path writes niet.

| Mode | Protected-path writes |
|------|------------------------|
| `default`, `acceptEdits`, `plan` | Geprompt |
| `auto` | Naar de classifier |
| `dontAsk` | Geweigerd |
| `bypassPermissions` | Toegestaan |

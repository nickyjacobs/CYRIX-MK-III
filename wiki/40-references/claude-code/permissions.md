---
title: "Claude Code: Permissions"
source-url: https://code.claude.com/docs/en/permissions
ingest-date: 2026-06-10
review-date: 2026-09-10
tags: [reference, claude-code, permissions]
category: 40-references
status: active
---

# Permissions

> Bron: https://code.claude.com/docs/en/permissions

Fijnmazige permissie-regels bepalen exact wat Claude Code mag. Regels staan in version control en zijn per developer aan te passen. Afgedwongen door Claude Code, niet door het model: instructies in `CLAUDE.md` sturen wat Claude probeert, niet wat is toegestaan.

## Tiered permissie-systeem

| Tool-type | Voorbeeld | Approval | "Don't ask again" |
|-----------|-----------|----------|-------------------|
| Read-only | File reads, Grep | Nee | N.v.t. |
| Bash commands | Shell-execution | Ja | Permanent per project + command |
| File modification | Edit/write | Ja | Tot einde sessie |

## Allow / ask / deny

Beheer met `/permissions`. Evaluatie-volgorde: **deny → ask → allow**. Eerste match wint; specificiteit verandert de volgorde niet (een ask-regel prompt ook als een specifiekere allow-regel matcht).

- **Allow**: tool zonder approval.
- **Ask**: prompt bij elk gebruik.
- **Deny**: blokkeert. Bare toolnaam (`Bash`) haalt de tool uit Claude's context; scoped (`Bash(rm *)`) blokkeert alleen matchende calls.

## Rule syntax

Format `Tool` of `Tool(specifier)`.

| Regel | Effect |
|-------|--------|
| `Bash` | Alle Bash-commands |
| `Bash(npm run build)` | Exact commando |
| `Bash(npm run *)` | Wildcard (`*` op elke positie) |
| `Read(./.env)` | Specifiek bestand |
| `WebFetch(domain:example.com)` | Fetch naar domein |
| `mcp__puppeteer__*` | Alle tools van puppeteer-server |
| `Agent(Explore)` | Specifieke subagent |

Spatie voor `*` dwingt word-boundary af: `Bash(ls *)` matcht `ls -la` niet `lsof`; `Bash(ls*)` matcht beide. `:*`-suffix is gelijk aan trailing ` *`.

## Tool-specifieke regels

- **Bash**: bewust van shell-operators (`&&`, `||`, `;`, `|`, `&`, newline); regel moet elk subcommando matchen. Process-wrappers `timeout`, `time`, `nice`, `nohup`, `stdbuf` en bare `xargs` worden gestript. Read-only commands (`ls`, `cat`, `grep`, `find`, read-only `git`) draaien zonder prompt.
- **PowerShell**: zelfde shape, aliassen gecanonicaliseerd, case-insensitive.
- **Read/Edit**: gitignore-patronen met 4 anchors: `//path` (absoluut), `~/path` (home), `/path` (project-root), `path`/`./path` (cwd). `*` = één directory, `**` = recursief.
- **MCP**: `mcp__<server>`, `mcp__<server>__*`, `mcp__<server>__<tool>`. Allow-globs alleen na literal `mcp__<server>__`-prefix.
- **Cd**: bepaalt `/cd`-targets (niet model-invocable). Eén allow-regel zet `/cd` in allowlist-modus.

## Working directories

File-toegang uitbreiden: `--add-dir <path>` (startup), `/add-dir` (sessie), `additionalDirectories` (settings). Let op: `additionalDirectories` in settings geeft alleen file-toegang, geen config-loading. `--add-dir` laadt wel skills, beperkte plugin-settings, en (met `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1`) CLAUDE.md.

## Hooks en sandboxing

PreToolUse-hooks draaien voor de permissie-prompt en kunnen denyen/forceren. Hook-beslissingen omzeilen deny/ask-regels niet. Een hook met exit-code 2 blokkeert vóór regels worden geëvalueerd. Sandboxing is OS-niveau enforcement op Bash; permissies en sandbox vormen defense-in-depth.

## Managed settings

Admin-only keys o.a.: `allowManagedHooksOnly`, `allowManagedMcpServersOnly`, `allowManagedPermissionRulesOnly`, `channelsEnabled`, `allowedChannelPlugins`, `strictPluginOnlyCustomization`, `strictKnownMarketplaces`, `blockedMarketplaces`, `forceRemoteSettingsRefresh`. `disableBypassPermissionsMode` werkt vanaf elke scope.

## Precedentie

Managed > CLI-args > Local > Project > User. Deny op enig niveau kan door geen ander niveau ge-allowed worden.

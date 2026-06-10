---
title: Docs-drift rapport — Claude Code references
audit-date: 2026-06-10
auditor: cyrix-docs-drift-claudecode (routine)
scope: wiki/40-references/claude-code/
status: actief
---

# Docs-drift rapport: Claude Code references (2026-06-10)

> Live docs geraadpleegd via WebFetch op `code.claude.com/docs/en/`. Vergeleken met 13 lokale reference-bestanden in `wiki/40-references/claude-code/`.

## Samenvatting

| Categorie | Aantal |
|---|---|
| NIEUW (live pagina's zonder lokale reference) | 39 |
| GEWIJZIGD (inhoud wijkt significant af) | 9 |
| VERWIJDERD / DEPRECATED | 2 |
| Source-URL mismatch | 1 |
| Nieuwe Claude Code versie / release | ✓ (v2.1.169+, `fable` model alias) |

**Aanbeveling**: prioriteit bij `hooks.md`, `cli-reference.md`, `settings.md` — die zijn het meest out-of-date. Nieuwe pagina's via `/ingest` toevoegen in de volgende review-cyclus.

---

## NIEUW — live pagina's zonder lokale reference

Pagina's die in de live navigatie zichtbaar zijn maar geen lokale reference hebben. In volgorde van relevantie voor CYRIX MK-III.

### Prioriteit HOOG (direct bruikbaar voor CYRIX-workflows)

| Pagina | URL | Waarom relevant |
|---|---|---|
| Commands reference | `/en/commands` | Overzicht van alle built-in commands + bundled skills; vervangt/complementeert `slash-commands.md` |
| Agent view | `/en/agent-view` | Background agents UI + CLI beheer (`claude attach`, `claude logs`, `claude bg`) |
| Permissions | `/en/permissions` | Uitgebreide uitleg van permission rules, scopes, additional-directories |
| Environment variables | `/en/env-vars` | Volledige lijst van env vars (`CLAUDE_CODE_*`, `ANTHROPIC_*`) |
| Channels | `/en/channels` | MCP-gebaseerde push vanuit Telegram, Discord, webhooks — CYRIX use case |
| Channels reference | `/en/channels-reference` | Technische spec voor channels |
| Advisor | `/en/advisor` | Server-side advisor tool (v2.1.98+); nieuw model-type |
| Permission modes | `/en/permission-modes` | Overzicht van alle permission modes incl. `auto`, `acceptEdits`, `bypassPermissions` |
| Model config | `/en/model-config` | Effort levels, fallback chains, `fable` alias |
| Debug your config | `/en/debug-your-config` | Troubleshooting CLAUDE.md + settings |

### Prioriteit MIDDEL

| Pagina | URL | Waarom relevant |
|---|---|---|
| Context window | `/en/context-window` | Visualisatie wat er bij startup in context gaat; nuttig voor CYRIX-architectuur |
| Agent SDK overview | `/en/agent-sdk/overview` | Programmatisch gebruik via print mode; relevant voor routines |
| Worktrees | `/en/worktrees` | `--worktree` / `-w` flag voor geïsoleerde git worktrees |
| Interactive mode | `/en/interactive-mode` | Keyboard shortcuts, prompt suggestions, `/add-dir` |
| Headless mode | `/en/headless` | `--bare`, print mode, scripting; relevant voor CYRIX routines |
| Large codebases | `/en/large-codebases` | Monorepo patterns, `claudeMdExcludes` |
| Desktop scheduled tasks | `/en/desktop-scheduled-tasks` | Lokale scheduled tasks (tegenhanger van cloud routines) |
| Remote control | `/en/remote-control` | Sessies vanuit telefoon/browser besturen |
| Hooks guide | `/en/hooks-guide` | User-friendly hooks introductie (naast de technische reference) |
| Features overview | `/en/features-overview` | Overzicht wanneer welk mechanisme te gebruiken |

### Prioriteit LAAG (setup/onboarding; minder urgent voor bestaande installatie)

| Pagina | URL |
|---|---|
| Quickstart | `/en/quickstart` |
| Setup (advanced) | `/en/setup` |
| VS Code | `/en/vs-code` |
| JetBrains | `/en/jetbrains` |
| Desktop quickstart | `/en/desktop-quickstart` |
| Web quickstart | `/en/web-quickstart` |
| Desktop app | `/en/desktop` |
| Web (Claude Code on the web) | `/en/claude-code-on-the-web` |
| GitHub Actions | `/en/github-actions` |
| GitLab CI/CD | `/en/gitlab-ci-cd` |
| Code review (GitHub) | `/en/code-review` |
| Slack integration | `/en/slack` |
| Chrome extension | `/en/chrome` |
| Third-party integrations | `/en/third-party-integrations` |
| Common workflows | `/en/common-workflows` |
| Best practices | `/en/best-practices` |
| Troubleshooting | `/en/troubleshooting` |
| UltraReview | `/en/ultrareview` |
| Scheduled tasks (in-session) | `/en/scheduled-tasks` |
| Plugins reference | `/en/plugins-reference` |

---

## GEWIJZIGD — lokale references met significante inhoud-drift

### 1. `hooks.md` — **KRITIEKE drift** ★★★

**Ingest:** 2026-03-26 | **Bron:** `/en/hooks`

Live docs tonen nu **31 hook events** (lokaal: ~17). Nieuwe events:

| Nieuw event | Beschrijving |
|---|---|
| `Setup` | One-time init (`--init-only`, `--init`, `--maintenance`) |
| `UserPromptExpansion` | Wanneer user-typed command expandeert |
| `PostToolBatch` | Na parallelle tool batch resolveert |
| `PermissionDenied` | Wanneer tool call geweigerd door auto-mode classifier |
| `TaskCreated` | Wanneer taak aangemaakt via `TaskCreate` |
| `MessageDisplay` | Terwijl assistant message streamt (display-only) |

Nieuwe **5e handler type**: `mcp_tool` — call direct een MCP tool als hook. Lokaal kent alleen `command`, `http`, `prompt`, `agent`.

Nieuwe velden op alle handler types:
- `if` — permission rule filter (bv. `"Bash(git *)"`) — alleen tool events
- `async` — run in background, niet blokkeren
- `asyncRewake` — background + wake Claude op exit 2

Nieuwe universele JSON output velden: `continue`, `stopReason`, `suppressOutput`, `systemMessage`, `terminalSequence`.

Nieuwe environment variabele: `$CLAUDE_ENV_FILE` — persisteer env vars voor de sessie vanuit SessionStart/Setup/CwdChanged/FileChanged hooks.

**Aanbeveling**: **re-ingest** — te veel drift voor een update-patch.

---

### 2. `cli-reference.md` — **KRITIEKE drift** ★★★

**Ingest:** 2026-03-26 | **Bron:** `/en/cli-usage` ← **URL mismatch**: live pagina is nu `/en/cli-reference`

Nieuwe CLI **subcommands** (niet in lokale reference):

| Command | Beschrijving |
|---|---|
| `claude install [version]` | Specifieke versie installeren |
| `claude attach <id>` | Attach aan background session |
| `claude daemon status` / `claude daemon stop` | Background supervisor beheren |
| `claude logs <id>` | Output van background session |
| `claude project purge [path]` | Alle lokale state voor project verwijderen |
| `claude respawn <id>` | Background session herstarten |
| `claude rm <id>` | Background session verwijderen |
| `claude setup-token` | Long-lived OAuth token genereren |
| `claude stop <id>` / `claude kill` | Background session stoppen |
| `claude ultrareview [target]` | UltraReview non-interactief |

Nieuwe / gewijzigde **flags** (selectie):

| Flag | Status |
|---|---|
| `--advisor <model>` | Nieuw (v2.1.98+) |
| `--bg` | Nieuw — start als background agent |
| `--channels` | Nieuw — MCP channel subscriptions |
| `--safe-mode` | Nieuw (v2.1.169+) — alle customizations uitschakelen |
| `--exec` | Nieuw — shell command als background job |
| `--exclude-dynamic-system-prompt-sections` | Nieuw — prompt-cache reuse |
| `--no-session-persistence` | Nieuw |
| `--prompt-suggestions` | Nieuw |
| `--replay-user-messages` | Nieuw |
| `--tmux` | Nieuw — tmux voor worktree |
| `--init`, `--init-only`, `--maintenance` | Nieuw — Setup hooks |
| `--include-hook-events` | Nieuw |
| `--debug-file <path>` | Nieuw |
| `--enable-auto-mode` | **VERWIJDERD** v2.1.111 |
| `--effort` | Gewijzigd: nieuw niveau `xhigh` |
| `--model` | Gewijzigd: `fable` alias toegevoegd |
| `--permission-mode` | Gewijzigd: nu ook `dontAsk` expliciet gedocumenteerd |

**Aanbeveling**: **re-ingest** + source-url bijwerken naar `/en/cli-reference`.

---

### 3. `settings.md` — **HOGE drift** ★★★

**Ingest:** 2026-03-26 | **Bron:** `/en/settings`

Lokale reference documenteert ~25 settings. Live docs documenteren >80 settings. Selectie van nieuw gedocumenteerde settings:

| Setting | Versie | Doel |
|---|---|---|
| `advisorModel` | v2.1.98+ | Server-side advisor model |
| `alwaysThinkingEnabled` | - | Extended thinking standaard aan |
| `showThinkingSummaries` | - | Thinking summaries tonen |
| `disableBundledSkills` | - | Bundled skills uitschakelen |
| `disableWorkflows` | - | Dynamic workflows uitschakelen |
| `disableSkillShellExecution` | - | `!`command`` in skills blokkeren |
| `skillListingBudgetFraction` | v2.1.105+ | Context-budget voor skill listing |
| `maxSkillDescriptionChars` | v2.1.105+ | Per-skill description cap |
| `skillOverrides` | v2.1.129+ | Per-skill visibility override |
| `disableRemoteControl` | v2.1.128+ | Remote Control blokkeren |
| `parentSettingsBehavior` | v2.1.133+ | Managed settings merge gedrag |
| `policyHelper` | v2.1.136+ | Dynamic managed settings script |
| `disableAgentView` | - | Background agent view uitschakelen |
| `fastModePerSessionOptIn` | - | Per-sessie fast mode opt-in |
| `allowManagedPermissionRulesOnly` | - | Alleen managed permission rules |
| `allowedHttpHookUrls` | - | HTTP hook URL allowlist |
| `httpHookAllowedEnvVars` | - | Env vars voor HTTP hooks |
| `modelOverrides` | - | Model ID mapping |
| `otelHeadersHelper` | - | Dynamic OpenTelemetry headers |
| `fileSuggestion` | - | Custom `@` file autocomplete |
| `language` | - | Voorkeurstaal voor antwoorden |
| `editorMode` | - | Vim key bindings |
| `awsAuthRefresh` / `gcpAuthRefresh` | - | Cloud provider auth refresh |

**Aanbeveling**: **re-ingest**.

---

### 4. `hooks.md` (source URL intact) en `memory.md` — **MIDDEL drift** ★★

**memory.md** — Ingest: 2026-03-26 | Bron: `/en/memory`

Nieuwe/gewijzigde inhoud:
- `CLAUDE.local.md` — project-lokale instructies (gitignored) nu uitgebreid gedocumenteerd als first-class concept
- `AGENTS.md` bridge via `@AGENTS.md` import of symlink
- Managed policy CLAUDE.md locaties voor Linux (`/etc/claude-code/CLAUDE.md`) en Windows (`C:\Program Files\ClaudeCode\CLAUDE.md`)
- `claudeMd` settings key — managed content direct in `managed-settings.json`
- `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1` — CLAUDE.md laden vanuit `--add-dir` directories
- `CLAUDE_CODE_NEW_INIT=1` — interactieve multi-fase `/init` flow
- Auto memory limiet: 200 regels **of** 25KB (was alleen 200 regels)
- HTML comments (`<!-- -->`) in CLAUDE.md worden uit context gestript
- Path-specific rules: uitgebreide documentatie met glob-tabel
- `claudeMdExcludes` patterns nu uitgebreid gedocumenteerd (array merge over settings layers)

**Aanbeveling**: gerichte update of re-ingest.

---

### 5. `mcp.md` — **MIDDEL drift** ★★

**Ingest:** 2026-03-26 | **Bron:** `/en/mcp`

| Wijziging | Detail |
|---|---|
| SSE transport deprecated | Gebruik HTTP in plaats van SSE |
| `streamable-http` alias | `type: "streamable-http"` werkt als alias voor `http` |
| Scope namen gewijzigd | `local` (was `project`), `user` (was `global`) |
| `claude mcp add-json` | Nieuw subcommand |
| `headersHelper` | Dynamic auth headers |
| `claude mcp get <name>` | Nieuw subcommand |
| Dynamic tool updates | `list_changed` notifications |
| Automatische reconnect | Exponential backoff voor HTTP/SSE servers |
| Channels via MCP | MCP server als push channel |
| Gereserveerde naam | `workspace` is gereserveerd voor intern gebruik |
| Tool search default | `ToolSearch` nu standaard enabled |
| `MAX_MCP_OUTPUT_TOKENS` | Nieuw env var voor output token limiet |
| `CLAUDE_PROJECT_DIR` in server env | Env var nu ook in spawned server process |

**Aanbeveling**: gerichte update of re-ingest.

---

### 6. `skills.md` — **MIDDEL drift** ★★

**Ingest:** 2026-03-26 | **Bron:** `/en/skills`

| Wijziging | Detail |
|---|---|
| Agent Skills open standard | Skills volgen nu [agentskills.io](https://agentskills.io) open standard |
| Bundled skills gewijzigd | `/run`, `/verify`, `/run-skill-generator` toegevoegd (v2.1.145+); `/simplify` verwijderd uit bundled list |
| Live change detection | Skills worden hot-reloaded zonder restart |
| Monorepo skill discovery | Nested `.claude/skills/` in subdirectories worden on-demand geladen |
| Parent directory discovery | Skills worden ook gevonden in parent directories t/m repo root |
| `--add-dir` exception | `.claude/skills/` uit `--add-dir` directories worden wél geladen (uitzondering op config-discoveryregel) |
| `disableBundledSkills` setting | Bundled skills uitschakelbaar |

**Aanbeveling**: gerichte update.

---

### 7. `sub-agents.md` — **LAGE-MIDDEL drift** ★

**Ingest:** 2026-03-26 | **Bron:** `/en/sub-agents`

| Wijziging | Detail |
|---|---|
| Managed settings hoogste prioriteit | Nieuw prioriteitsniveau boven `--agents` CLI flag |
| `/agents` command | Tabbed UI met Library/Running tabs, Generate with Claude, kleurinstelling |
| Recursive scanning agents/ | Subfolders in `agents/` worden recursief gescand |
| Plugin agent scoping | `plugin-name:subfolder:agent-name` namespacing |
| Explore/Plan skip CLAUDE.md | Expliciet gedocumenteerd dat Explore en Plan CLAUDE.md en git status overslaan |
| `CLAUDE_AGENT_SDK_DISABLE_BUILTIN_AGENTS=1` | Nieuw env var |

**Aanbeveling**: gerichte update.

---

### 8. `routines.md` — **LAGE drift** ★

**Ingest:** 2026-06-09 | **Bron:** `/en/routines`

Weinig drift (recent ingested). Enkele toevoegingen:
- API trigger `/fire` endpoint volledig gedocumenteerd met response body
- `anthropic-beta: experimental-cc-routine-2026-04-01` header vereist
- GitHub trigger filters uitgebreider (7 filter-velden met operators)
- One-off runs tellen niet mee voor dagelijkse cap (was al in lokale reference, maar nu uitgebreider)
- Connectors beheer: onderscheid lokale MCP (`claude mcp add`) vs. claude.ai connectors

**Aanbeveling**: minimale update; feitelijk grotendeels kloppend.

---

### 9. `overview.md` — **LAGE drift** ★

**Ingest:** 2026-03-26 | **Bron:** `/en/overview`

| Wijziging | Detail |
|---|---|
| `fable` model alias | Nu beschikbaar als model alias (v2.1.170+) |
| Windows CMD install | Nieuw installatie-commando voor Windows CMD |
| WinGet install | `winget install Anthropic.ClaudeCode` |
| Linux package managers | `apt`, `dnf`, `apk` installatie |
| Windows ARM64 Desktop | Aparte download voor ARM64 |
| Dispatch | Nieuwe feature voor phone-to-desktop taakstart |
| Channels | Nieuw in surfaces-tabel |
| Remote Control | Nu uitgebreider beschreven |
| Teleport | `claude --teleport` voor web → terminal |

**Aanbeveling**: gerichte update bij volgende review.

---

## VERWIJDERD / DEPRECATED

| Item | Locatie | Status |
|---|---|---|
| `--enable-auto-mode` flag | `cli-reference.md` | **Verwijderd** in v2.1.111. Auto mode zit nu standaard in Shift+Tab cyclus. Gebruik `--permission-mode auto` |
| MCP SSE transport | `mcp.md` | **Deprecated**. Markeer als deprecated in lokale reference; gebruik HTTP transport |

---

## Source-URL mismatch

| Lokale file | Lokale source-url | Huidige live URL |
|---|---|---|
| `cli-reference.md` | `/en/cli-usage` | `/en/cli-reference` |

De pagina op `/en/cli-usage` geeft mogelijk nog een redirect of 404. Bij re-ingest: source-url bijwerken naar `/en/cli-reference`.

---

## Nieuwe Claude Code versie / release

Uit de live docs zijn de volgende versie-markeringen zichtbaar:

| Versie | Feature |
|---|---|
| v2.1.59 | Auto memory minimum vereiste |
| v2.1.81 | `/schedule` CLI minimum |
| v2.1.98 | `--advisor` flag, `advisorModel` setting |
| v2.1.105 | `skillListingBudgetFraction`, `maxSkillDescriptionChars` |
| v2.1.111 | `--enable-auto-mode` verwijderd; auto mode standaard in Shift+Tab |
| v2.1.121 | MCP initial reconnect retry bij startup |
| v2.1.128 | `disableRemoteControl`, `--plugin-dir .zip` support |
| v2.1.129 | `skillOverrides` |
| v2.1.133 | `parentSettingsBehavior` |
| v2.1.136 | `policyHelper` |
| v2.1.144 | Background sessions in `--resume` picker |
| v2.1.145 | `/run`, `/verify`, `/run-skill-generator` bundled skills |
| v2.1.162 | MCP per-server `timeout` floor gedrag gewijzigd |
| v2.1.169 | `--safe-mode` flag |
| v2.1.170 | `fable` model alias |

Huidige stabiele release is dus **≥ v2.1.170**. Lokale references zijn gebaseerd op een snapshot van ~v2.1.x (maart 2026, voor de meeste; juni 2026 voor routines/plugins/output-styles/slash-commands).

**`fable` als model alias**: Claude Fable 5 is nu beschikbaar via `--model fable` en als `advisorModel`. Dit is een significante toevoeging voor CYRIX-configuraties die een model-alias gebruiken.

---

## Aanbevelingen (geprioriteerd)

### Actie A — Re-ingest (hoge urgentie)

1. `hooks.md` — volledig re-ingestren; 31 events vs. 17 lokaal, nieuw `mcp_tool` handler type
2. `cli-reference.md` — volledig re-ingestren; bron-URL bijwerken naar `/en/cli-reference`; ~10 nieuwe subcommands, ~15 nieuwe flags

### Actie B — Re-ingest (middel urgentie)

3. `settings.md` — volledig re-ingestren; >60 nieuwe settings
4. `memory.md` — re-ingestren; `CLAUDE.local.md`, `AGENTS.md` bridge, managed Linux/Windows paden, `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD`
5. `mcp.md` — re-ingestren; SSE deprecated, scope namen gewijzigd, reconnect gedrag

### Actie C — Gerichte update of re-ingest (lage urgentie)

6. `skills.md` — Agent Skills open standard, live change detection, monorepo discovery
7. `sub-agents.md` — managed settings prioriteit, `/agents` UI, recursive scanning
8. `overview.md` — `fable` alias, nieuwe install-methodes, Dispatch/Channels

### Actie D — Nieuwe pagina's ingestren via `/ingest`

Prioriteit hoog: `/en/commands`, `/en/agent-view`, `/en/permissions`, `/en/env-vars`, `/en/channels`, `/en/advisor`, `/en/permission-modes`, `/en/model-config`

Prioriteit middel: `/en/context-window`, `/en/agent-sdk/overview`, `/en/worktrees`, `/en/interactive-mode`, `/en/headless`, `/en/large-codebases`, `/en/desktop-scheduled-tasks`, `/en/remote-control`

### Actie E — Deprecated items markeren

- `cli-reference.md`: `--enable-auto-mode` markeren als verwijderd in v2.1.111
- `mcp.md`: SSE transport markeren als deprecated

---

*Rapport gegenereerd door cyrix-docs-drift-claudecode routine op 2026-06-10.*
*Live docs bereikbaar op code.claude.com — geen network-access-issues geconstateerd.*

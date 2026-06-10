---
title: "Claude Code: Environment variables"
source-url: https://code.claude.com/docs/en/env-vars
ingest-date: 2026-06-10
review-date: 2026-09-10
tags: [reference, claude-code, env-vars]
category: 40-references
status: active
---

# Environment variables

> Bron: https://code.claude.com/docs/en/env-vars

Environment variables sturen Claude Code-gedrag aan: model-selectie, auth, routing, feature-toggles. Te zetten in de shell of in het `env`-blok van een settings-bestand. Env vars hebben voorrang op settings-bestanden; CLI-flags en in-sessie commands kunnen ze per feature overschrijven.

## Auth en endpoints

| Variabele | Beschrijving |
|-----------|-------------|
| `ANTHROPIC_API_KEY` | API-key (X-Api-Key header) |
| `ANTHROPIC_AUTH_TOKEN` | Custom Authorization-header |
| `ANTHROPIC_BASE_URL` | API-endpoint overschrijven (proxy/gateway) |
| `AWS_BEARER_TOKEN_BEDROCK` | Bedrock API-key |

## Model-configuratie

| Variabele | Beschrijving |
|-----------|-------------|
| `ANTHROPIC_MODEL` | Te gebruiken model-setting |
| `ANTHROPIC_DEFAULT_OPUS_MODEL` / `_SONNET_` / `_HAIKU_` / `_FABLE_MODEL` | Default model per familie-alias |
| `ANTHROPIC_SMALL_FAST_MODEL` | DEPRECATED, gebruik `ANTHROPIC_DEFAULT_HAIKU_MODEL` |
| `ANTHROPIC_CUSTOM_MODEL_OPTION` | Custom model-ID voor `/model`-picker |
| `CLAUDE_CODE_SUBAGENT_MODEL` | Model voor alle subagents/teams |

## Effort en thinking

| Variabele | Beschrijving |
|-----------|-------------|
| `CLAUDE_CODE_EFFORT_LEVEL` | `low`, `medium`, `high`, `xhigh`, `max`, `auto` |
| `MAX_THINKING_TOKENS` | Max tokens voor extended thinking (`0` = uit) |
| `CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING` | Adaptive reasoning uit (Opus 4.6/Sonnet 4.6) |

## Timeouts

| Variabele | Default | Beschrijving |
|-----------|---------|-------------|
| `API_TIMEOUT_MS` | 600000 | API-request timeout |
| `BASH_DEFAULT_TIMEOUT_MS` | 120000 | Default bash-timeout |
| `BASH_MAX_TIMEOUT_MS` | 600000 | Max bash-timeout |
| `BASH_MAX_OUTPUT_LENGTH` | - | Max bash-output voor opslaan naar file |

## Features uitschakelen (selectie)

| Variabele | Beschrijving |
|-----------|-------------|
| `CLAUDE_CODE_DISABLE_AGENT_VIEW` | Background agents en agent view uit |
| `CLAUDE_CODE_DISABLE_ADVISOR_TOOL` | Advisor-tool uit |
| `CLAUDE_CODE_DISABLE_WORKFLOWS` | Workflows uit |
| `CLAUDE_CODE_DISABLE_BUNDLED_SKILLS` | Bundled skills uit |
| `CLAUDE_CODE_DISABLE_CRON` | Scheduled tasks uit |
| `CLAUDE_CODE_DISABLE_1M_CONTEXT` | 1M-context uit |
| `CLAUDE_CODE_DISABLE_AUTO_MEMORY` | Auto memory uit |
| `CLAUDE_CODE_DISABLE_CLAUDE_MDS` | CLAUDE.md-files niet laden |
| `CLAUDE_CODE_DISABLE_GIT_INSTRUCTIONS` | Built-in git-instructies weg |

## Telemetry en privacy

| Variabele | Beschrijving |
|-----------|-------------|
| `CLAUDE_CODE_ENABLE_TELEMETRY` | OpenTelemetry aan |
| `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` | Auto-updater, feedback, error-reporting, telemetry uit |
| `DISABLE_TELEMETRY` / `DISABLE_AUTOUPDATER` / `DISABLE_ERROR_REPORTING` / `DO_NOT_TRACK` | Individuele toggles |

## Overig

| Variabele | Beschrijving |
|-----------|-------------|
| `CLAUDE_CODE_ENABLE_AUTO_MODE` | Auto mode op Bedrock/Vertex/Foundry |
| `CLAUDE_CONFIG_DIR` | Config-directory overschrijven (i.p.v. `~/.claude`) |
| `CLAUDE_CODE_DEBUG_LOG_LEVEL` | `verbose`, `debug`, `info`, `warn`, `error` |
| `CLAUDECODE` | Op `1` gezet in subprocessen van Claude Code |
| `DISABLE_PROMPT_CACHING` | Prompt caching uit (+ per-tier varianten) |

> De live docs bevatten een uitgebreidere lijst (AWS/Vertex/Foundry-routing, TLS/mTLS, UI-rendering, IDE-integratie). Raadpleeg de bron voor provider-specifieke variabelen.

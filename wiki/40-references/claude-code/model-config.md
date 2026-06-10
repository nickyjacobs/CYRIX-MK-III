---
title: "Claude Code: Model configuration"
source-url: https://code.claude.com/docs/en/model-config
ingest-date: 2026-06-10
review-date: 2026-09-10
tags: [reference, claude-code, model-config]
category: 40-references
status: active
---

# Model configuration

> Bron: https://code.claude.com/docs/en/model-config

Het `model`-setting accepteert een alias of een volledige model-naam (Anthropic API), inference-profile ARN (Bedrock), deployment-naam (Foundry) of version-naam (Vertex). `ANTHROPIC_BASE_URL` verandert waar requests heen gaan, niet welk model antwoordt.

## Model-aliassen

| Alias | Gedrag |
|-------|--------|
| `default` | Wist override, terug naar aanbevolen model voor je account |
| `best` | Fable 5 waar beschikbaar, anders nieuwste Opus |
| `fable` | Claude Fable 5, voor zwaarste/langste taken |
| `sonnet` | Nieuwste Sonnet, dagelijks codewerk |
| `opus` | Nieuwste Opus, complex redeneren |
| `haiku` | Snelle Haiku, simpele taken |
| `sonnet[1m]` / `opus[1m]` | Met 1M-token context window |
| `opusplan` | Opus tijdens plan mode, dan Sonnet voor executie |

Op de Anthropic API resolvet `opus` naar Opus 4.8 en `sonnet` naar Sonnet 4.6. Op Bedrock/Vertex/Foundry naar Opus 4.6 / Sonnet 4.5; pin nieuwere modellen via `ANTHROPIC_DEFAULT_OPUS_MODEL` etc.

## Model zetten (prioriteit hoog naar laag)

1. Tijdens sessie: `/model <alias|name>` (slaat op als default sinds v2.1.153; `s` in picker = alleen deze sessie).
2. Bij startup: `claude --model <alias|name>`.
3. Env var: `ANTHROPIC_MODEL`.
4. Settings: `model`-veld.

Project- en managed-settings hebben voorrang en herapplyen bij volgende launch. Hervatte sessies behouden hun model.

## Effort levels

| Model | Levels |
|-------|--------|
| Fable 5, Opus 4.8, Opus 4.7 | `low`, `medium`, `high`, `xhigh`, `max` |
| Opus 4.6, Sonnet 4.6 | `low`, `medium`, `high`, `max` |

Default effort is `high` (Fable 5, Opus 4.8, Opus 4.6, Sonnet 4.6) en `xhigh` op Opus 4.7. `low`/`medium`/`high`/`xhigh` persisten; `max` en `ultracode` zijn session-only. Zetten via `/effort`, `--effort`-flag, `CLAUDE_CODE_EFFORT_LEVEL` (heeft voorrang op alles), `effortLevel`-setting (geen `max`/`ultracode`), of skill/subagent-frontmatter (`effort`). `ultracode` stuurt `xhigh` plus dynamic-workflow orchestratie. `ultrathink` in een prompt vraagt eenmalig dieper redeneren.

## Restrict en override

- `availableModels` (managed/policy): allowlist van selecteerbare modellen; `default` blijft altijd beschikbaar.
- `model`: initiële selectie, geen enforcement.
- `modelOverrides`: mapt individuele Anthropic model-ID's naar provider-specifieke strings (ARN, version, deployment).

## Fallback

- **Fallback-chains** (availability): `--fallback-model sonnet,haiku` of `fallbackModel`-array in settings. Max 3 na dedup, alleen voor de huidige turn.
- **Automatic fallback** (content): Fable 5 met safety-classifiers (cybersecurity/biology) reruns op de default Opus bij een flag. Security-research en biology triggeren dit frequent, vaak op de eerste request (workspace-context zoals CLAUDE.md/git-status). Check met `claude --safe-mode`. Ask-before-switching via `/config`.

## Extended context en thinking

Fable 5, Opus 4.6+ en Sonnet 4.6 ondersteunen 1M-context. Op Max/Team/Enterprise wordt Opus automatisch geüpgraded; Sonnet 1M vereist usage-credits. Uitschakelen met `CLAUDE_CODE_DISABLE_1M_CONTEXT=1`. Append `[1m]` aan alias of model-naam. Thinking togglen: `Option+T`/`Alt+T`, `alwaysThinkingEnabled`-setting, of `MAX_THINKING_TOKENS=0` (geen effect op Fable 5). `Ctrl+O` voor verbose thinking.

## Env vars voor alias-mapping

| Variabele | Mapt |
|-----------|------|
| `ANTHROPIC_DEFAULT_FABLE_MODEL` | `fable` (en Fable 5-herkenning voor fallback) |
| `ANTHROPIC_DEFAULT_OPUS_MODEL` | `opus`, en `opusplan` in plan mode |
| `ANTHROPIC_DEFAULT_SONNET_MODEL` | `sonnet`, en `opusplan` buiten plan mode |
| `ANTHROPIC_DEFAULT_HAIKU_MODEL` | `haiku`, en background-functionaliteit |
| `CLAUDE_CODE_SUBAGENT_MODEL` | Alle subagents/teams (`inherit` voor normale resolutie) |

Companion-suffixen `_NAME`, `_DESCRIPTION`, `_SUPPORTED_CAPABILITIES` overschrijven display en declareren capabilities (`effort`, `xhigh_effort`, `max_effort`, `thinking`, `adaptive_thinking`, `interleaved_thinking`) op third-party providers.

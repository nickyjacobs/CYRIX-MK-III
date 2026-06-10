---
title: Claude Code — Routines
source-url: https://code.claude.com/docs/en/routines
ingest-date: 2026-06-09
review-date: 2026-09-10
tags: [reference, claude-code, automation]
category: 40-references
status: active
---

# Claude Code — Routines

> Bron: https://code.claude.com/docs/en/routines · Research preview

Routines zijn opgeslagen Claude Code configuraties (prompt + repos + connectors) die automatisch draaien in Anthropic's cloud-infrastructuur. Werken ook als laptop uit staat.

## Triggers

Een routine kan combineren:

- **Scheduled** — uur/dag/week cadens of one-off timestamp (min interval: 1 uur)
- **API** — HTTP POST naar per-routine endpoint met bearer token, optionele `text` body
- **GitHub** — reageert op pull_request of release events met filters (author, label, base/head branch, regex)

## Beschikbaarheid

- Vereist Pro/Max/Team/Enterprise plan met Claude Code on the web ingeschakeld
- Beheer via [claude.ai/code/routines](https://claude.ai/code/routines) of CLI `/schedule`
- Team/Enterprise admins kunnen routines uitschakelen voor de hele organisatie

## CLI

- `/schedule` — start interactieve setup voor scheduled routine
- `/schedule daily PR review at 9am` — directe natural-language input
- `/schedule list` — overzicht
- `/schedule update` / `/schedule run` — beheer

Voor API/GitHub triggers gebruik je de web UI; CLI ondersteunt alleen scheduled routines.

## Cloud-omgeving

Routines draaien in een cloud environment dat je configureert:

- **Network access** — Default (Trusted allowlist), Custom (eigen domains), of Full
- **Environment variables** — API keys, tokens
- **Setup script** — dependencies installeren (resultaat wordt gecached)

MCP connector traffic gaat via Anthropic's servers — connectors werken zonder hun hosts te whitelisten.

## Branch permissions

- Default: routine pusht alleen naar `claude/*`-prefixed branches (beschermt main)
- Optioneel: "Allow unrestricted branch pushes" per repository inschakelen

## Limits en kosten

- Routines tellen tegen je subscription usage (zelfde als interactieve sessies)
- Daily run cap per account
- Overage via usage credits (Team/Enterprise)
- One-off runs tellen NIET tegen de daily cap

## Use cases voor CYRIX MK-III

- `wiki-librarian` daily/weekly/monthly audits (gepland, zie `docs/routines.md`)
- Toekomstige: PR-review op publieke template, weekly threat-intel scan, periodic re-ingest van doc-references

## Troubleshooting

- `/schedule` returns "Unknown command" → check geen `ANTHROPIC_API_KEY` env var, CLI v2.1.81+, niet ingelogd via Bedrock/Vertex
- Routines disabled by policy → admin toggle op claude.ai/admin-settings/claude-code

## Gerelateerd in Claude Code

- `/loop` voor in-session scheduling
- Desktop scheduled tasks voor lokale taken
- GitHub Actions voor CI-pipeline events

---
title: CYRIX MK-III — Verificatie fase 2 (auto-sessie pipeline + hernoeming)
created: 2026-06-09
updated: 2026-06-09
tags: [verification, fase-2]
category: docs
status: active
---

# Verificatie fase 2

> Status: 2026-06-09 · Repo: https://github.com/nickyjacobs/CYRIX-MK-III · 20 commits op main

## Cluster A — Fase 1 wrap-up

### A1: session-start.sh awk-fix gecommit
- Commit: `4aa2832` op main
- Hook draait nu zonder exit-code 1 op niet-bestaande "Top prioriteiten" header
- ✅ **PASS**

### A2: statusline-template feature
- `scripts/statusline.example.sh` aanwezig, executable, 247 regels
- README.md heeft sectie "Optional features" met global + per-project install-instructies
- Twee-regel layout: project + branch + sessienaam | model + bar + tokens + rate-limits + hints
- ✅ **PASS** (test met fake JSON-input toont juiste output: `CYRIX-MK-III` projectnaam, model, context-bar)

## Cluster B — Hernoeming naar CYRIX-MK-III

### B1: GitHub repo hernoemd
- `gh repo view nickyjacobs/CYRIX-MK-III` toont: name=CYRIX-MK-III, URL=https://github.com/nickyjacobs/CYRIX-MK-III
- Description bijgewerkt: "CYRIX MK-III — Personal executive assistant template for Claude Code with wiki-LLM pattern, auto-session pipeline and doc-ingest"
- Oude URL redirect automatisch
- ✅ **PASS**

### B2: Lokale folder hernoemd
- Folder: `~/Desktop/Agentic AI Workflows/My/CYRIX-MK-III/` (was `cyrix-mk-iii/`)
- git remote bijgewerkt naar nieuwe URL
- Git status, log, fetch werken vanuit nieuwe pad
- ✅ **PASS**

### B3: Geen lowercase refs
- Sweep: 0 files met `cyrix-mk-iii` (na fix van session-curator.md voorbeelden)
- Append-only logs (`wiki/50-decisions/log.md`, `wiki/40-references/log.md`) behouden historische verwijzingen — bewust
- ✅ **PASS**

## Cluster C — Auto-sessie pipeline

### C0: Privacy/safety fundament
- **`.gitignore`**: uitgebreid met defensief patterns (secrets/credentials folders, raw sessions lokaal, refined obsidian patterns)
- **`scripts/validate.py`**: 17 HARD-patterns (AI providers, source control, cloud/SaaS, certs, DB connection strings, lokale paden) + 5 SOFT-patterns (entropy, IPs, emails, ovpn, vault tokens). `--staged` mode voor pre-commit.
- **`scripts/anonymize.py`**: placeholder-substitution helper met dry-run preview, `--inplace` en `--output` modes
- **`.claude/hooks/pre-commit-secret-scan.sh`**: gate die SessionEnd-hook aanroept vóór auto-commit. HARD-findings → block + log naar `wiki/60-audits/`
- ✅ **PASS** (alle scripts uitvoerbaar, JSON valid, tests succesvol)

**Known limitations:**
- `ALLOWED_MARKERS` skip te breed bij "example" substring — `db.example.com` connection strings worden gemist (edge-case, fixbaar in fase 3)

### C1: SessionStart auto-naming
- **`.claude/hooks/session-name.sh`**: genereert JSON met `hookSpecificOutput.sessionTitle`
- Strategie: branch-naam → "Volgende concrete stap" → fallback
- Tweede SessionStart hook naast bestaande context-dump
- Matcher `"startup"` (geen rename bij resume)
- ✅ **PASS** (output is geldige JSON, slug wordt correct gegenereerd)

### C2+C7: SessionEnd hook + settings activation
- **`.claude/hooks/session-end.sh`**: parsing van transcript via Python (eerste user-prompt, tool-uses), RAW + processed logs schrijven, pre-commit safety, auto-stage + auto-commit met brede scope, ingest-marker
- **`.claude/settings.json`**: `SessionEnd` matcher `clear|resume|logout|other`, timeout 60s
- Substantialiteit-check (skip <3 tool-uses zonder content changes)
- NIET auto-pushen — eigenaar beslist
- ✅ **PASS** (test toonde dat hook correct triggert, files schrijft, commit maakt met juiste scope)

### C3: session-curator agent
- **`.claude/agents/session-curator.md`**: distilleert raw logs naar 5 buckets (knowledge, decisions, project-update, memory, archives)
- Verplichte dry-run mode met apply-flag voor schrijven
- Heuristiek-mapping per content-categorie
- Tools: Read, Write, Edit, Glob, Grep (geen Bash voor git/file-moves)
- ✅ **PASS** (agent-definitie compleet, scope helder afgebakend)

### C4: /process-sessions skill
- **`.claude/skills/process-sessions/SKILL.md`**: leest `/tmp/cyrix-ingest-backlog.txt` of scant `wiki/30-sessions/raw/`
- Per log: agent in dry-run, per-bucket akkoord, commit per groep
- `--since`, `--dry-run`, `--auto-apply`, `--log` flags
- Verplaatst verwerkte logs naar `raw/processed/`
- ✅ **PASS**

### C5: /einde-sessie positionering
- Frontmatter description bijgewerkt: nu handmatige override naast SessionEnd hook
- Nieuwe sectie "Verhouding tot auto-pipeline" met tabel
- ✅ **PASS**

## Open items voor jouw verificatie in een verse `claude` sessie

In MK-III: `cd ~/Desktop/Agentic\ AI\ Workflows/My/CYRIX-MK-III && claude`

1. ☐ **SessionStart auto-naming** — krijgt nieuwe sessie automatisch een zinvolle naam (zichtbaar in statusline of via `/rename` om huidige naam te zien)?
2. ☐ **SessionEnd auto-pipeline** — sluit sessie via `/clear`, controleer:
   - Raw log in `wiki/30-sessions/raw/`
   - Processed log in `wiki/30-sessions/`
   - Auto-commit gemaakt op `main`
   - Ingest-marker in `/tmp/cyrix-ingest-backlog.txt`
3. ☐ **/process-sessions skill** — roep aan, krijg je preview per raw-log met per-bucket akkoord?
4. ☐ **session-curator agent** — `@session-curator` op een raw log levert classificatie + plan?
5. ☐ **Pre-commit safety** — maak een test-file met `ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` (fake PAT), stage, sluit sessie → hook MOET blokkeren en audit-log schrijven

## Bekende beperkingen / fase 3 polish

- `check_verboden_woorden.py` vangt geen NL-verbuigingen (`proactieve` mist)
- `wiki-librarian._tracking.md` escalation niet praktisch getest
- `ALLOWED_MARKERS` "example" substring te breed (zie C0 known limitation)
- Bento-grid CSS alleen actief bij snippet activatie in Obsidian
- session-curator's classificatie-heuristiek heeft eerste maand observatie nodig om finetuning te kunnen doen

## Roadmap fase 3 (later)

- Cloud routine die `/process-sessions` periodiek triggert (zie `docs/routines.md`)
- Externe workspaces (Pentest/THM/homelab) aansluiten op gedeelde wiki via Obsidian MCP
- Skills + agents publiceren als Claude Code plugin
- NL-stemmer voor `check_verboden_woorden.py`
- Verfijning ALLOWED_MARKERS per-pattern check

# CYRIX MK-III

<!--
  Image hosted on GitHub user-attachments — for permanent stability, download
  manually via browser and replace src with assets/cyrix-logo.png
-->
<img width="1024" height="1024" alt="CYRIX" src="https://github.com/user-attachments/assets/34e4122b-3419-4260-9ee4-0f3c6d845c26" />

![Claude Code](https://img.shields.io/badge/Claude_Code-Integrated-5C4EE5)
![CYRIX](https://img.shields.io/badge/CYRIX-MK--III-0f0f0f)
![License](https://img.shields.io/badge/License-MIT-green)
![Template](https://img.shields.io/badge/GitHub-Template-blue)
![Status](https://img.shields.io/badge/Status-Active-success)
![Wiki-LLM](https://img.shields.io/badge/Pattern-Wiki--LLM-7E57C2)
![Auto-Session](https://img.shields.io/badge/Auto--Session-Pipeline-FF8A65)

> Personal executive assistant template for [Claude Code](https://code.claude.com), built around a Karpathy-style wiki-LLM pattern, automated session-closure, and disciplined doc-ingest workflows.

**Status:** active development (fase 1 deliverables landed 2026-06-09). Template-safe — fork it, run `scripts/setup.sh`, fill in your context.

## What is CYRIX

CYRIX is a Claude Code workspace that helps you plan, organise, research, write and streamline both personal and professional workflows. It's optimised for security professionals (SOC, pentest, certifications) but the framework itself is general-purpose.

Core ideas:

- **Wiki-LLM pattern** — Obsidian-compatible vault as a subdirectory, lazy-lookup via `wiki/index.md` first (max 5 pages per question, grep fallback).
- **Auto session-closure** — Stop-hook triggers `/einde-sessie` when substantial work happened, writing knowledge to wiki + merging into `MEMORY.md` without manual ceremony.
- **Doc-ingest** — `/ingest <URL>` crawls multi-page docs into structured local references with master-index, frontmatter, and review-date.
- **Wiki audits** — daily/weekly/monthly cloud routines lint the wiki for broken links, stale references, missing frontmatter, archives candidates.
- **Tavily quota-fallback** — `/search` skill degrades gracefully to WebFetch + WebSearch instead of erroring.
- **DutchQuill integration** — Dutch writing style guides imported as references (MIT), applied via `/dutch-write` skill.

## Quick start

After "Use this template":

```bash
# 1. Clone your fork
git clone https://github.com/<you>/CYRIX-MK-III.git
cd CYRIX-MK-III

# 2. Run setup (interactive)
bash scripts/setup.sh

# 3. Fill in your data
#    - wiki/00-context/me.md, work.md, team.md, current-priorities.md, goals.md
#    - .env (Tavily, GitHub, optional Home Assistant keys)
#    - CLAUDE.local.md (your name, preferences)

# 4. Open Obsidian → "Open folder as vault" → wiki/

# 5. Start a Claude Code session
claude
```

SessionStart hook automatically injects your MEMORY, current priorities, and last session summary.

## Architecture in one diagram

```
CYRIX-MK-III/
├── CLAUDE.md              public template instructions
├── CLAUDE.local.md        your identity + @imports (gitignored)
├── MEMORY.md              persistent insights (auto-managed by /einde-sessie)
├── .claude/
│   ├── rules/             5 public rules (writing, security, commits, comms)
│   ├── rules-private/     personal overrides (gitignored)
│   ├── skills/            /search, /ingest, /einde-sessie, /dutch-write
│   ├── agents/            security-reviewer, wiki-librarian
│   ├── hooks/             SessionStart, Stop, pre/post-edit secret scans
│   └── settings.json      hook configuration
├── wiki/                  Obsidian-compatible vault (lazy-lookup)
│   ├── 00-context/        profile, work, team, priorities, goals
│   ├── 10-projects/       active projects
│   ├── 20-knowledge/      knowledge notes (Zettelkasten-style)
│   ├── 30-sessions/       auto-generated session logs (gitignored)
│   ├── 40-references/     doc-ingest output
│   ├── 50-decisions/      append-only decisions log
│   ├── 60-audits/         wiki-librarian audit reports
│   └── 90-archives/       superseded/old content (never delete)
├── docs/                  routines setup, verification checklist
├── integrations/          external integrations (e.g. dutchquill/)
└── scripts/               validate.py, check_verboden_woorden.py, setup.sh, statusline.example.sh
```

## Skills

| Skill | Purpose |
|---|---|
| `/search <query>` | Tavily → WebFetch → WebSearch fallback chain |
| `/ingest <URL\|text>` | Crawl docs into wiki/40-references/ with master-index |
| `/einde-sessie` | Close session: write log, merge MEMORY, append decisions |
| `/dutch-write <text>` | Rewrite Dutch text per DutchQuill rules |

## Agents

| Agent | Trigger | Purpose |
|---|---|---|
| `security-reviewer` | post-edit hook + manual | Read-only secret-scan (Haiku) |
| `wiki-librarian` | manual `@wiki-librarian daily\|weekly\|monthly` or cloud routine | Wiki audits with escalation |

## Hooks

- **SessionStart** — injects MEMORY + priorities + recent sessions
- **Stop (smart-trigger)** — runs `/einde-sessie` automatically when substantial work happened (content changes OR ≥10 tool-uses)
- **PreToolUse (Edit\|Write\|MultiEdit)** — hard-blocks secrets in new content
- **PostToolUse (Edit\|Write\|MultiEdit)** — re-scans disk, runs Dutch style advisory on relevant files

## Optional features

### Statusline (recommended)

CYRIX MK-III ships with a statusline template at [`scripts/statusline.example.sh`](scripts/statusline.example.sh). It shows on two lines:

- **Line 1:** project folder · git branch (green/yellow if dirty) · session name
- **Line 2:** model · effort · context-bar with percentage · tokens · 5h/7d rate-limits · compact/clear hint at ≥70% context

**Activate globally** (all Claude Code sessions):

```bash
cp scripts/statusline.example.sh ~/.claude/statusline-command.sh
chmod +x ~/.claude/statusline-command.sh
# Add to ~/.claude/settings.json:
#   "statusLine": { "type": "command", "command": "bash ~/.claude/statusline-command.sh" }
```

**Activate per-project** (only in this repo):

```bash
cp scripts/statusline.example.sh .claude/statusline.sh
chmod +x .claude/statusline.sh
# Add to .claude/settings.json:
#   "statusLine": { "type": "command", "command": "bash .claude/statusline.sh" }
```

The hint thresholds and color codes are easy to tweak — edit the `_rl_color` function and the `used_pct_int` checks at the bottom of the script.

## Cloud routines (optional)

Setup three scheduled audits via Claude Code routines — see [`docs/routines.md`](docs/routines.md):

- Daily 09:00 — light lint
- Weekly Sunday 18:00 — structure audit
- Monthly 1st 18:00 — deep audit

## Roadmap

- **Fase 1** ✅ (week 1) — repo skeleton, wiki, core skills, hooks, context migration, first doc-ingest, privacy fix.
- **Fase 2** — wiki-librarian cloud routines, external workspace integration (Pentest / TryHackMe / homelab share the same vault), bento-grid CSS polish.
- **Fase 3** — publish skills as a Claude Code plugin, template validation via testfork, learnings → MK-IV planning.

## Documentation

- [`docs/routines.md`](docs/routines.md) — cloud routine setup
- [`docs/verificatie-fase1.md`](docs/verificatie-fase1.md) — fase 1 verification checklist
- [`integrations/dutchquill/README.md`](integrations/dutchquill/README.md) — DutchQuill integration details

## License

MIT — see [`LICENSE`](LICENSE).

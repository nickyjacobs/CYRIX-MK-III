# CYRIX MK-III

> Personal executive assistant template for [Claude Code](https://code.claude.com), built around a Karpathy-style wiki-LLM pattern, auto-session-closure, and doc-ingest workflows.

**Status:** in active development (fase 1). Not yet ready as a clean template fork — see [the roadmap](#roadmap).

## What it is

CYRIX is a Claude Code workspace that helps you plan, organise, research, write and streamline both personal and professional workflows. It's optimised for security professionals (SOC, pentest, certifications) but the framework is general-purpose.

Core ideas:

- **Wiki-LLM pattern** — Obsidian-compatible vault as a subdirectory, lazy lookup via `index.md` first, max 5 pages per query.
- **Auto session-closure** — your knowledge gets captured into the wiki and `MEMORY.md` without manual ceremony.
- **Doc-ingest** — drop a URL, get a structured local reference with master-index, frontmatter and review-date.
- **Wiki audits** — daily/weekly/monthly cloud routines lint the wiki and flag stale or broken content.
- **Tavily quota-fallback** — search degrades gracefully to WebFetch + WebSearch instead of erroring.
- **DutchQuill integration** — Dutch writing style guides imported as references, applied via a dedicated skill.

## Architecture

See [`docs/architecture.md`](docs/architecture.md) (coming in fase 1).

## Quick start

> Not yet — once fase 1 lands, a `scripts/setup.sh` will walk you through it.

## Roadmap

- **Fase 1** (week 1) — repo skeleton, wiki vault, core skills (`/search`, `/ingest`, `/einde-sessie`, `/dutch-write`), hooks, MK-II context migration, first doc-ingest.
- **Fase 2** (week 2-3) — `wiki-librarian` routine, daily audit snapshot, external workspace integration (Pentest / TryHackMe / homelab).
- **Fase 3** (month 2+) — publish CYRIX skills as a Claude Code plugin, template validation via testfork, MK-IV planning.

## License

MIT — see [`LICENSE`](LICENSE).

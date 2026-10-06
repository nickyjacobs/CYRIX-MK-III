---
title: Knowledge: overzicht
category: 20-knowledge
status: active
tags: [index, knowledge]
---

# Knowledge

Gestructureerde kennis-notes in Zettelkasten-stijl. In de **publieke template** staat alleen deze index. Echte notes zijn persoonlijk en blijven **lokaal** (gitignored).

## Structuur

- Gebruik `_templates/knowledge-note.md` als basis voor een concept-note (bv. onderzoek,
  inzicht).
- Gebruik `_templates/knowledge-tool.md` voor een tool, techniek, procedure of algemene
  vaardigheid (bv. een pentest-tool, een enumeratie-techniek, een herbruikbare
  methodologie, of basis-CLI-gereedschap zoals een terminal-multiplexer of editor).
  Frontmatter krijgt dan een `kind:`-veld: `tool` | `techniek` | `procedure` |
  `vaardigheid` (`vaardigheid` = algemeen CLI-gereedschap, niet pentest-specifiek, bv.
  `tmux`/`vim`). Geen submappen per categorie, alles plat in `20-knowledge/`,
  gegroepeerd via `kind:` en `tags:` in plaats van paden.
- Frontmatter (beide templates): `title`, `created`, `updated`, `tags`, `category`, `status`
  (+ optioneel `sources`, `related`, `kind`).
- Eén note = één concept. Link liberaal met `[[wikilinks]]` naar gerelateerde notes.

## Bronnen

Kennis komt binnen via `/ingest` (externe bronnen → `40-references/`) of distillatie van sessies via `/process-sessions` (→ hier).

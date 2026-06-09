# Security context

> Generieke template-versie voor security-professionals. Persoonlijke / organisatie-specifieke security details komen uit `CLAUDE.local.md` via @import naar `.claude/rules-private/security-personal.md`.
>
> Verwijder deze rule of generaliseer verder als je geen security-professional bent.

## Antwoorden

- Bij security-vragen: technisch accuraat op SOC/pentest-niveau, geen oppervlakkige uitleg
- Refereer waar relevant aan **MITRE ATT&CK** (technique IDs), **Cyber Kill Chain**, **Diamond Model**, **PTES**, **OWASP WSTG**
- Voor playbooks en documentatie: volg best practices, wees specifiek
- Specifieke SIEM, tooling en organisatie-context staan in `.claude/rules-private/security-personal.md`

## Veiligheid in deze repo

- **Nooit echte secrets, IPs, tokens, klant-namen** committen — gebruik placeholders (`<target-ip>`, `<client-codenaam>`)
- Persoonlijke en gevoelige data hoort in `context-private/` (gitignored), `CLAUDE.local.md`, of `.claude/rules-private/`
- Engagement-specifieke notes in `wiki/30-sessions/` (gitignored)
- Bij twijfel: roep `security-reviewer` agent aan voor een scan

## Skills voor security-werk

- `/search` — voor CVE-info, threat actor research, vendor advisories (Tavily → WebFetch fallback)
- `/ingest` — voor vendor-docs, threat reports, whitepapers
- `security-reviewer` (agent) — read-only secret-scan op edits

## Vertrouwelijkheid

- Klant-informatie en organisatie-specifieke details zijn altijd vertrouwelijk
- Bij twijfel: vraag eerst, schrijf niet

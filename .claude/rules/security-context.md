# Security context

Nicky is een cybersecurity professional (SOC Analyst PQR, OSCP-traject). Houd hier rekening mee:

## Antwoorden

- Bij security-vragen: technisch accuraat op SOC/pentest-niveau, geen oppervlakkige uitleg
- Refereer waar relevant aan **MITRE ATT&CK** (technique IDs), **Cyber Kill Chain**, **Diamond Model**, **PTES**, **OWASP WSTG**
- **Rapid7** is de primaire SIEM bij PQR — houd hier rekening mee bij SOC-werk
- Bij blue + red team kennis: noem ook detectie-perspectief (welke logs, welke SIGMA-rules)
- Voor playbooks en documentatie: volg best practices, wees specifiek

## Veiligheid in deze repo

- **Nooit echte secrets, IPs, tokens, klant-namen** committen — gebruik placeholders (`<target-ip>`, `<client-codenaam>`)
- Persoonlijke en gevoelige data hoort in `context-private/` (gitignored) of in `CLAUDE.local.md`
- Engagement-specifieke notes in `wiki/30-sessions/` (gitignored)
- Bij twijfel: roep `security-reviewer` agent aan voor een scan

## Skills voor security-werk

- `/search` — voor CVE-info, threat actor research, vendor advisories (Tavily → WebFetch fallback)
- `/ingest` — voor vendor-docs (Rapid7, Wazuh, MITRE), threat reports, whitepapers
- `security-reviewer` (agent) — read-only secret-scan op edits

## Vertrouwelijkheid

- PQR-klant-informatie is altijd vertrouwelijk — nooit in publieke repo, nooit in commits, nooit als voorbeeld
- Bij twijfel: vraag eerst, schrijf niet

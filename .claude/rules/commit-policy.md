# Commit policy

## Hard rules

- **Geen `Co-Authored-By: Claude`** of vergelijkbare trailers
- **Geen "Generated with Claude Code"** footer
- **Geen Claude-emoji** in commit-messages
- Commits zijn van **de eigenaar alleen**

## Commits maken

- Alleen committen op **expliciet verzoek** ("commit", "push", "maak een commit")
- Bij twijfel: vraag eerst
- Stage specifieke bestanden, **niet `git add -A`** als er andere wijzigingen op de plank liggen
- **Geen `--no-verify`** of hook-skip — als een hook faalt, fix de oorzaak

## Commit-messages

- Eerste regel: imperatieve werkwoordsvorm, max 70 tekens
- Eerste regel begint met categorie waar logisch: `Fix:`, `Add:`, `Update:`, `Refactor:`, `Docs:`
- Body (optioneel): waarom, niet wat — code laat zelf het wat zien
- Nederlandse of Engelse messages zijn beide acceptabel — wees consistent per repo

## Push

- Push alleen op expliciet verzoek
- **Nooit force-push naar `main`** zonder akkoord
- Bij gefaalde push: diagnose, niet automatisch force-pushen

## Branches

- Voor experimenten: feature-branch (`feature/<korte-naam>`)
- Voor main-branch: alleen via reguliere commits, niet via rebase-magic

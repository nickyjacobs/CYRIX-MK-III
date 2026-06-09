# Nederlandse schrijfregels

Bij het schrijven van Nederlandse teksten voor extern gebruik (documentatie, rapportages, GitHub READMEs, mails, blog posts):

## Basis

- Gebruik de DutchQuill-gidsen in `wiki/40-references/dutchquill/` als primaire bron
- Aanvullende regels (jouw eigen voorkeuren) staan in `.claude/rules/writing-cyrix.md`
- Voor zware tekstwerk: gebruik `/dutch-write <tekst>` voor de volledige stijl-pipeline

## Taalregels

- 't ex-kofschip voor -d/-t uitgangen
- Correcte dt-regels en werkwoordvervoeging
- Gebruik actieve schrijfstijl waar mogelijk
- Passieve vorm acceptabel om persoonlijke voornaamwoorden te vermijden
- Vervang omslachtige constructies door directe formuleringen
- Correcte signaalwoorden voor oorzaak, contrast, opsomming en conclusie

## Verboden in extern werk

Zie `wiki/40-references/dutchquill/schrijfstijl.md` voor de volledige lijst. Kernpunten:

- **Woorden**: cruciaal, essentieel, robuust, baanbrekend, naadloos, transformatief, faciliteert, demonstreert, stroomlijnen, scala aan, proactief, integraal (+ 14 anderen)
- **Openers**: "In de huidige samenleving...", "In een wereld waar...", "Het is belangrijk om te benadrukken..."
- **Em dashes (—)** en gedachtestreepjes — gebruik komma, punt of splits de zin
- **Platitudes**: "de toekomst ziet er rooskleurig uit"
- **Meta-commentaar / chatbot-formuleringen**

## Validatie

`PostToolUse` hook draait `check_verboden_woorden.py` op `.md` files in `docs/`, `wiki/`, root README. Waarschuwingen zijn non-blocking — fix bij gelegenheid.

---
name: cert
description: Cert-studiesessie voor een certificeringstraject (cpts, crtp, oscp). Verwerkt de _inbox/ (ruwe notes plus screenshots) naar nette module-notes, attachments en voortgang in de wiki, en laadt de cert-status. Wordt alleen door de gebruiker aangeroepen met /cert gevolgd door de cert-naam (bv. /cert cpts), zodat cert-context niet in andere gesprekken meekomt.
argument-hint: "[cert-slug]"
disable-model-invocation: true
---

# /cert

## Wanneer gebruiken

- Aan het begin van een studie- of lab-sessie voor een certificeringstraject (CPTS, later CRTP, OSCP): laadt de context en gaat in cert-sessie-modus.
- Na een sessie: verwerkt de inbox (ruwe notes plus screenshots) naar nette module-notes en attachments, en werkt de voortgang bij.
- Alleen op expliciete aanroep, zodat cert-context niet in losse gesprekken meekomt (context-scheiding).

## Argument

De cert-slug komt uit `$ARGUMENTS` (bv. `cpts`), corresponderend met `wiki/10-projects/certifications/$ARGUMENTS.md`. In de rest van deze skill is `<slug>` die waarde.

- Leeg `$ARGUMENTS`? Toon de beschikbare certs (`ls wiki/10-projects/certifications/*.md`) en vraag welke, of pak de enige met `status: active`. Gebruik die als `<slug>`.

## Mapconventie (per cert)

```
wiki/10-projects/certifications/
  <slug>.md              # cert-hoofdpagina: status, examen-feiten, roadmap-tabel
  <slug>/
    _inbox/              # dumpzone: ruwe notes (.md/.txt) EN screenshots door elkaar
    modules/             # per-module notes (markdown), vaste structuur
    attachments/         # screenshots, hernoemd en gelinkt vanuit de module-notes
```

## Hoe het werkt

### Stap 1: Context laden en "waar was ik"

Lees `certifications/<slug>.md`, in het bijzonder:

- Het **"Huidige status"-blok** (bezig met, laatst gedaan, volgende stap, open punten). Dit is het geheugen van de vorige sessie.
- De roadmap-tabel (afgevinkte modules, voortgang).
- De module-note van de huidige module (`modules/<module>.md`) als die bestaat.

Open met een korte recap: "Je was hier gebleven: ... Volgende stap: ...". Vanaf hier ben je in cert-sessie-modus tot de gebruiker van onderwerp wisselt.

### Stap 2: Inbox verwerken

Check `certifications/<slug>/_inbox/`:

- **Leeg?** Meld dat, blijf in sessie-modus klaar om notes/screenshots te verwerken die de gebruiker live in de chat deelt.
- **Gevuld?** Sorteer elk item:
  - **Tekst** (.md, .txt, geplakte notes): bepaal de module via (a) expliciete hint (bestandsnaam of een `module:`-regel bovenaan), (b) de inhoud (tools en technieken), (c) vraag bij twijfel. Distilleer naar `modules/<module>.md` volgens de vaste structuur. Merge of append, overschrijf nooit bestaande inhoud.
  - **Afbeeldingen** (.png, .jpg, .jpeg, ...): verplaats naar `attachments/`, hernoem `<module>-<kort-onderwerp>-NN.ext`, en link op de juiste plek in de module-note met `![](../attachments/<bestand>)`.
- Na verwerking: maak de inbox leeg door verwerkte bestanden naar `_inbox/processed/` te verplaatsen (niet zomaar verwijderen).

### Stap 3: State bijwerken (VERPLICHT, niet overslaan)

Dit is het geheugen voor de volgende sessie. Werk altijd bij als er gewerkt of iets geleerd is, ook bij een lege inbox:

- [ ] **Huidige status-blok** in `<slug>.md`: bezig met, laatst gedaan, volgende stap, open punten. Met datum.
- [ ] **Roadmap-tabel**: afgeronde modules afvinken (⬜ wordt ✅), voortgang opnieuw tellen.
- [ ] **Frontmatter** `updated:`-datum.

Toon daarna expliciet wat je gewijzigd hebt, zodat de gebruiker kan corrigeren.

### Stap 4: Rapporteer

Kort: wat verwerkt is en waarheen, de nieuwe voortgang (X/totaal), en waar de gebruiker de volgende keer oppakt (uit het bijgewerkte status-blok).

## Module-note structuur

```markdown
# <Module>

**Tier:** <0/I/II> · **Status:** bezig/af · **Tijd:** <ingeschat>

## Doel
## Commando's en technieken
## Output en bevindingen
## Geleerd
## Herbruikbare technieken
## Screenshots
```

## Note-taking principes

- Markdown primair, screenshots als bewijs en aanvulling.
- Volledig genoeg om in het SysReptor-report te recyclen: commando's letterlijk, output samengevat.
- Eén note per module. Herbruikbare technieken ook als losse regel onder "Herbruikbare technieken".

## Integriteit

Tijdens leren: helpen en uitleggen mag. Op het examen doet de gebruiker de pentest zelf; AI alleen voor report-structuur en taal. Volledige afspraak: zie "Toegestane hulpmiddelen en integriteit" in `<slug>.md`.

## Gedrag

- **On-demand:** laadt alleen bij aanroep. Geen cert-context in andere gesprekken.
- **Niet-destructief:** merge in module-notes, overschrijf nooit; inbox-bestanden worden verplaatst, niet gewist.
- **Gitignored:** alle `certifications/<slug>/`-content is lokaal (gitignore `wiki/10-projects/*`). Niet committen.
- **State als geheugen:** de voortgang leeft in `<slug>.md` (status-blok plus tabel), niet in het sessiegeheugen. Is er gewerkt, voer dan altijd stap 3 uit. Puur context laden zonder dat er iets gebeurde vereist geen schrijf.

## Voorbeeld

```
> /cert cpts
CPTS: 3/28 modules af (laatst: Network Enumeration With Nmap), bezig met Footprinting.
Inbox: 2 notes + 5 screenshots.
Verwerkt naar modules/footprinting.md, 5 screenshots in attachments/.
Voortgang nu 3/28. Volgende: Footprinting afronden (Tier II, ~2d).
```

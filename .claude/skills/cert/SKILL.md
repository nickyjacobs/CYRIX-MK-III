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
    attachments/         # screenshots + officiële cheatsheet-PDF's
    walkthroughs/        # officiële HTB-walkthroughs, bewaard voor naslag
    checklists/          # scenario → techniek-checklists (cert-agnostisch bruikbaar)

wiki/20-knowledge/       # cert-agnostische tool-/techniek-/procedure-notes, zie onder
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
  - **Tekst** (.md, .txt, geplakte notes): bepaal de module via (a) expliciete hint (bestandsnaam of een `module:`-regel bovenaan), (b) de inhoud (tools en technieken), (c) vraag bij twijfel. Distilleer naar `modules/<module>.md`, gebaseerd op `wiki/_templates/cert-module.md`. Theorie zonder eigen target: samenvatten in eigen woorden (checklist-stijl), niet verbatim overnemen — een pure theorie-module gebruikt de "Kernstof (samengevat)"-variant van het template en laat "Output en bevindingen"/"Screenshots" weg. Merge of append, overschrijf nooit bestaande inhoud.
  - **Afbeeldingen** (.png, .jpg, .jpeg, ...): verplaats naar `attachments/`, hernoem `<module>-<kort-onderwerp>-NN.ext`, en link op de juiste plek in de module-note met `![](../attachments/<bestand>)`.
- Na verwerking: maak de inbox leeg door verwerkte bestanden naar `_inbox/processed/` te verplaatsen (niet zomaar verwijderen).
- **Officiële cheatsheet-PDF's in `attachments/`** horen ook bij deze stap: lees ze door
  op nuggets die niet al letterlijk in de module-tekst stonden (een extra flag-variant,
  een tool die alleen in de PDF genoemd wordt) vóór je naar Stap 2b gaat.

### Stap 2b: Knowledge-notes bijwerken (tools/technieken/procedures/vaardigheden)

Voor elke generieke (niet box-/CVE-specifieke) tool, techniek of procedure in de
zojuist verwerkte module: maak of vul een note aan in `wiki/20-knowledge/`. Dit is
cert-agnostisch (CRTP/OSCP hergebruiken dezelfde notes) en staat los van de
module-note, die blijft het leerlogboek.

- **Structuur en voorbeeld:** zie "Knowledge-note structuur" hieronder.
- **Eén note per onderdeel**, geen submappen: plat in `20-knowledge/`, gegroepeerd via
  het `kind:`-frontmatter-veld (`tool` | `techniek` | `procedure` | `vaardigheid`) en
  `tags:`, niet via paden.
- **Wat wél:** een service-enumeratie-methode (bv. SMB, SNMP), een los staand tool
  (bv. Nmap, CeWL), een herbruikbare procedure (bv. credential-reuse-chaining,
  reverse-shell-opzetten), of een algemene CLI-vaardigheid uit de module (`kind:
  vaardigheid`, bv. tmux/vim).
- **Wat niet:** een CVE-specifieke exploit-chain voor één box, flags, of IP's/poorten
  van een specifieke spawn — dat blijft in de module-note onder "Output en
  bevindingen", niet generiek genoeg voor een knowledge-note.
- **Bestaande note?** Aanvullen (nieuwe `[!example]-`-groep, extra rij in de
  bronnentabel), nooit overschrijven. Check eerst of het onderwerp al als note of als
  sub-groep in een verwante note bestaat (bv. CT-logs hoort bij `dns-enumeratie`, niet
  een eigen note) vóór je een nieuwe aanmaakt.
- **Inline cross-links:** als de lopende tekst van een note een tool/techniek noemt
  waar al een andere `20-knowledge`-note voor bestaat, maak het woord dan een wikilink
  naar die note (`[[andere-note|Woord]]`). Maximaal één keer per doel-note per
  bestand (eerste zinvolle vermelding), nooit in codeblocks of de bronnentabel, en
  alleen op een herkenbare eigennaam (geen generieke woorden als "exploit" of "web").
- **Backlinks terug:** de module-note (sectie "Herbruikbare technieken") en de
  relevante checklist(s) in `<slug>/checklists/` krijgen een link naar de
  nieuwe/bijgewerkte knowledge-note(s).
- **Geen em dashes** (—), ook hier: komma, punt, of `:` i.p.v. een gedachtestreepje.

### Stap 3: State bijwerken (VERPLICHT, niet overslaan)

Dit is het geheugen voor de volgende sessie. Werk altijd bij als er gewerkt of iets geleerd is, ook bij een lege inbox:

- [ ] **Huidige status-blok** in `<slug>.md`: bezig met, laatst gedaan, volgende stap, open punten. Met datum.
- [ ] **Roadmap-tabel**: afgeronde modules afvinken (⬜ wordt ✅), voortgang opnieuw tellen.
- [ ] **Frontmatter** `updated:`-datum.

Toon daarna expliciet wat je gewijzigd hebt, zodat de gebruiker kan corrigeren.

### Stap 4: Rapporteer

Kort: wat verwerkt is en waarheen, welke `20-knowledge/`-notes nieuw of bijgewerkt zijn, de nieuwe voortgang (X/totaal), en waar de gebruiker de volgende keer oppakt (uit het bijgewerkte status-blok).

## Module-note structuur

Basis: `wiki/_templates/cert-module.md` (frontmatter + zes secties, met een
theorie-variant voor modules zonder eigen hands-on target). Niet los dupliceren hier,
het template is de bron van waarheid.

## Knowledge-note structuur (wiki/20-knowledge/)

Basis: `wiki/_templates/knowledge-tool.md`. Niet los dupliceren hier, het template is
de bron van waarheid. Vaste opbouw, in deze volgorde:

1. **Frontmatter** met `kind:` (`tool` | `techniek` | `procedure` | `vaardigheid`).
2. **Cheat Sheet-callout** direct onder de H1-titel, vervangt wat bij het
   cert-module-template "Wat en wanneer" heet: `> [!cheatsheet] Cheat Sheet`, 2-3
   zinnen, **niet** foldable (geen `+`/`-` erachter). Rendert rood met een
   vlam-icoon via de CSS-snippet `wiki/.obsidian/snippets/cheatsheet-callout.css`
   (al geactiveerd in `appearance.json`, niets aan te passen).
3. **Kerncommando's**: één `[!example]-` callout per subtechniek/groep, **standaard
   ingeklapt** (de `-`, nooit `+`). Binnen elke callout: één commando per codeblock
   (nooit meerdere commando's of een inline `#`-comment in dezelfde blok, dat kopieert
   anders mee bij het klikken op het kopieer-icoontje), met de uitleg als platte tekst
   er direct boven.
4. **Gotchas**: eigen ervaring, afwijkingen tussen eigen aanpak en walkthrough,
   veelgemaakte fouten.
5. **Meer methodes en bronnen**: een tabel (`| Bron | Toelichting |`), niet een
   bullet-lijst. Bron = link naar officiële docs/man page/GitHub-repo/RFC/HackTricks
   e.d., Toelichting = kort en krachtig.
6. **Gerelateerd**: wikilinks naar de bron-module-note, de bijpassende checklist(s),
   en andere knowledge-notes.

Gitignored net als de rest van `10-projects/certifications/`, met uitzondering van
`20-knowledge/index.md` (die blijft wel gecommit, publiek, en beschrijft deze
structuur generiek voor wie de repo leest).

## Note-taking principes

- Markdown primair, screenshots als bewijs en aanvulling.
- Volledig genoeg om in het SysReptor-report te recyclen: commando's letterlijk, output samengevat.
- Eén note per module. Herbruikbare technieken ook als losse regel onder "Herbruikbare technieken".

## Integriteit

Tijdens leren: helpen en uitleggen mag. Op het examen doet de gebruiker de pentest zelf; AI alleen voor report-structuur en taal. Volledige afspraak: zie "Toegestane hulpmiddelen en integriteit" in `<slug>.md`.

## Gedrag

- **On-demand:** laadt alleen bij aanroep. Geen cert-context in andere gesprekken.
- **Niet-destructief:** merge in module-notes, overschrijf nooit; inbox-bestanden worden verplaatst, niet gewist.
- **Gitignored:** alle `certifications/<slug>/`-content is lokaal (gitignore `wiki/10-projects/*`), en `wiki/20-knowledge/*.md` eveneens (behalve `index.md`). Niet committen.
- **State als geheugen:** de voortgang leeft in `<slug>.md` (status-blok plus tabel), niet in het sessiegeheugen. Is er gewerkt, voer dan altijd stap 3 uit. Puur context laden zonder dat er iets gebeurde vereist geen schrijf.

## Voorbeeld

```
> /cert cpts
CPTS: 3/28 modules af (laatst: Network Enumeration With Nmap), bezig met Footprinting.
Inbox: 2 notes + 5 screenshots.
Verwerkt naar modules/footprinting.md, 5 screenshots in attachments/.
Knowledge-notes: smb-enumeratie.md en snmp-enumeratie.md nieuw, nmap.md aangevuld.
Voortgang nu 3/28. Volgende: Footprinting afronden (Tier II, ~2d).
```

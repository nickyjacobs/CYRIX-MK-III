# MEMORY

> Persistente inzichten en voorkeuren die over sessies heen relevant blijven.
> Beheerd door `/einde-sessie` (merge, geen blind append).
>
> **Dit is de committable template.** De echte `MEMORY.md` is lokaal (gitignored) omdat
> inzichten werk- en klant-context kunnen bevatten. Kopieer dit bestand naar `MEMORY.md`
> om te starten.

## Format

Per inzicht:

```markdown
## <korte titel>
**Datum:** YYYY-MM-DD
**Categorie:** voorkeur | feit | constraint | beslissing
**Inhoud:** wat het inzicht is, kort, één à twee zinnen.
**Bron:** (optioneel) sessie-log of bron-pagina.
```

Houd deze file scherp. Dubbele inzichten worden bij merge gededupliceerd. Verouderde inzichten worden naar `wiki/90-archives/memory-archive.md` verplaatst tijdens de maandelijkse audit.

---

<!-- Begin van de inzichten -->

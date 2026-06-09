# MEMORY

> Persistente inzichten en voorkeuren die over sessies heen relevant blijven.
> Beheerd door `/einde-sessie` (merge, geen blind append).

## Format

Per inzicht:

```markdown
## <korte titel>
**Datum:** YYYY-MM-DD
**Categorie:** voorkeur | feit | constraint | beslissing
**Inhoud:** wat het inzicht is — kort, één à twee zinnen.
**Bron:** (optioneel) sessie-log of bron-pagina.
```

Houd deze file scherp. Dubbele inzichten worden bij merge gededupliceerd. Verouderde inzichten worden naar `wiki/90-archives/memory-archive.md` verplaatst tijdens de maandelijkse audit.

---

<!-- Begin van de inzichten -->

## LLM-benchmark-bronhygiëne
**Datum:** 2026-06-10
**Categorie:** constraint
**Inhoud:** Anthropic publiceert geen cross-model benchmark-tabellen in de officiële modeldocs; vergelijkende scores komen van third-party aggregators (llm-stats, morphllm) en zijn deels via verschillende harnesses gemeten. Behandel zulke cross-model cijfers altijd als indicatief en geef een bron-disclaimer mee.
**Bron:** sessie-log 2026-06-10-0025

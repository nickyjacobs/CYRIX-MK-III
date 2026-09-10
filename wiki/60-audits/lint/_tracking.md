---
title: Wiki-audit tracking
type: audit-tracking
category: 60-audits
status: active
tags: [audit, tracking, wiki-librarian]
beheerd-door: wiki-librarian
---

# Wiki-audit tracking

State-bestand van de `wiki-librarian` agent. Bewaart per finding wanneer die voor het eerst
gezien is, zodat het escalatiemechanisme tussen cadansen werkt en cloud-routines hun state
tussen runs behouden.

## Escalatie

| Situatie | Gevolg |
|---|---|
| Meer dan 7 dagen open in daily | Hard finding in de eerstvolgende weekly |
| Meer dan 30 dagen open in weekly | Hard finding in de eerstvolgende monthly |

## Conventie

Eén regel per finding, met `first-seen` in ISO-formaat. Bij oplossing verhuist de regel naar
"Opgelost", die blijft staan als audit-trail. Verwijder niets.

## Open findings

_(nog geen; dit bestand is aangemaakt bij de audit van 2026-09-10)_

| Finding | Pagina | first-seen | Cadans | Status |
|---|---|---|---|---|

## Opgelost

| Finding | Pagina | first-seen | opgelost-op |
|---|---|---|---|

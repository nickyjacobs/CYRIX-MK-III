#!/usr/bin/env python3
"""
Check Nederlandse markdown-files tegen DutchQuill verboden-woorden lijst.
Advisory only — geeft exit 0 zelfs bij hits, schrijft warnings naar stderr.

Geïnspireerd op DutchQuill AI's check_verboden_woorden.py (MIT).
Gebruikt regels uit wiki/40-references/dutchquill/schrijfstijl.md (lokale kopie).
"""
import argparse
import re
import sys
from pathlib import Path

VERBODEN_WOORDEN = [
    "cruciaal", "essentieel", "robuust", "baanbrekend", "naadloos",
    "transformatief", "katalysator", "speerpunt", "faciliteert", "demonstreert",
    "onderstreept", "weerspiegelt", "stroomlijnen", "duiken in", "scala aan",
    "betekenisvol", "diepgaand", "genuanceerd", "uitgebreid", "proactief",
    "integraal", "zodoende", "passie", "verheugd", "fosteren", "testament aan",
]

VERBODEN_OPENERS = [
    "in de huidige samenleving",
    "in een wereld waar",
    "in het huidige tijdperk",
    "het is belangrijk om te benadrukken dat",
    "in het kader van",
    "het is belangrijker dan ooit",
]


def _inflect_pattern(word: str) -> str:
    """Bouw een regex die het woord plus veelvoorkomende NL-verbuigingen vangt.

    Dekt de hoofd-uitgangen (bijvoeglijk + werkwoord). Advisory, dus enige
    onvolledigheid is acceptabel; doel is geen valse negatieven op simpele
    verbuigingen als 'cruciale', 'essentiële', 'stroomlijnt'.
    """
    # Meerdere woorden (bv. 'duiken in', 'scala aan'): letterlijk matchen.
    if " " in word:
        return rf"\b{re.escape(word)}\b"

    # Bijvoeglijke naamwoorden met klinker-verandering bij verbuiging.
    adj_rules = [
        ("aal", ("aal", "ale")),         # cruciaal / cruciale, integraal / integrale
        ("eel", ("eel", "ele", "ële")),  # essentieel / essentiële
        ("oos", ("oos", "oze")),         # naadloos / naadloze
        ("ief", ("ief", "ieve")),        # proactief / proactieve, transformatief
    ]
    for ending, variants in adj_rules:
        if word.endswith(ending):
            stem = re.escape(word[: -len(ending)])
            return rf"\b{stem}(?:{'|'.join(variants)})\b"

    # Werkwoorden op -eert (faciliteert, demonstreert): stam + vervoeging + ge-...-eerd.
    if word.endswith("eert"):
        stem = re.escape(word[:-4])
        return rf"\b(?:ge)?{stem}eer(?:t|en|de|d)?\b"

    # Infinitief op -en (stroomlijnen, fosteren): stam + vervoeging + ge-...-d.
    if word.endswith("en") and len(word) > 4:
        stem = re.escape(word[:-2])
        return rf"\b(?:ge)?{stem}(?:en|t|de|d)?\b"

    # Algemene fallback: woord + optionele veelvoorkomende uitgang.
    return rf"\b{re.escape(word)}(?:en|e|er|ere|s|t)?\b"


VERBODEN_PATTERNS = [
    (word, re.compile(_inflect_pattern(word))) for word in VERBODEN_WOORDEN
]


def scan(path: Path) -> int:
    if not path.exists() or not path.is_file():
        return 0
    try:
        content = path.read_text(encoding="utf-8", errors="replace")
    except Exception:
        return 0

    hits: list[tuple[int, str, str]] = []
    in_code_block = False

    for i, line in enumerate(content.splitlines(), 1):
        # Skip fenced code blocks
        if line.lstrip().startswith("```"):
            in_code_block = not in_code_block
            continue
        if in_code_block:
            continue
        # Skip frontmatter (--- to ---)
        if i == 1 and line.strip() == "---":
            in_code_block = True
            continue

        lowered = line.lower()

        for word, pattern in VERBODEN_PATTERNS:
            m = pattern.search(lowered)
            if m:
                vorm = m.group(0)
                label = f"woord: '{word}'" if vorm == word else f"woord: '{word}' (als '{vorm}')"
                hits.append((i, label, line.strip()[:90]))

        for opener in VERBODEN_OPENERS:
            if lowered.lstrip().startswith(opener):
                hits.append((i, f"opener: '{opener}...'", line.strip()[:90]))

        # Em-dash (—) of hyphen-met-spaties als gedachtestreepje
        if "—" in line:
            hits.append((i, "em-dash (—)", line.strip()[:90]))

    if hits:
        print(f"\n[NL-STIJL] Advisory-waarschuwingen in {path}:", file=sys.stderr)
        for line_no, issue, snippet in hits:
            print(f"  {path}:{line_no} — {issue}", file=sys.stderr)
            print(f"    > {snippet}", file=sys.stderr)
        print(
            f"\nTotaal: {len(hits)} stijl-issue(s). Non-blocking. "
            "Fix met /dutch-write of handmatig wanneer relevant.\n",
            file=sys.stderr,
        )
    return 0


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("path", help="Bestand om te scannen")
    args = ap.parse_args()
    return scan(Path(args.path))


if __name__ == "__main__":
    sys.exit(main())

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

        for word in VERBODEN_WOORDEN:
            if re.search(rf"\b{re.escape(word)}\b", lowered):
                hits.append((i, f"woord: '{word}'", line.strip()[:90]))

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

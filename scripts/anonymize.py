#!/usr/bin/env python3
"""
Anonymizer voor CYRIX MK-III.

Vervangt gedetecteerde secrets en gevoelige data door placeholders.
Gebruikt dezelfde patroon-bibliotheek als scripts/validate.py.

Gebruik:
  anonymize.py --file <path>            # scan + toon diff (geen wijziging)
  anonymize.py --file <path> --inplace  # vervangt in-place (gevaarlijk!)
  anonymize.py --stdin                  # lees stdin, schrijf naar stdout
  anonymize.py --file <path> --output <new>  # schrijf gescrubde versie naar nieuw bestand

LET OP: Anonymize maakt heuristische beslissingen. ALTIJD diff reviewen vóór accepteren.
Niet bedoeld om volautomatisch te draaien — handmatige tool voor scrubbing.
"""
import argparse
import re
import sys
from pathlib import Path

# Replacements per patroontype (kort + duidelijk)
REPLACEMENTS = {
    "anthropic_key":  ("sk-ant-[a-zA-Z0-9_-]{40,}",                    "sk-ant-<redacted>"),
    "openai_key":     ("sk-(?!ant-|proj-)[a-zA-Z0-9]{40,}",            "sk-<redacted>"),
    "openai_proj":    ("sk-proj-[a-zA-Z0-9_-]{40,}",                   "sk-proj-<redacted>"),
    "tavily_key":     ("tvly-[a-zA-Z0-9]{20,}",                        "tvly-<redacted>"),
    "google_api":     (r"\bAIza[0-9A-Za-z_-]{35}\b",                   "AIza<redacted>"),
    "github_pat":     ("ghp_[a-zA-Z0-9]{36}",                          "ghp_<redacted>"),
    "github_oauth":   ("gho_[a-zA-Z0-9]{36}",                          "gho_<redacted>"),
    "gitlab_pat":     ("glpat-[a-zA-Z0-9_-]{20}",                      "glpat-<redacted>"),
    "aws_access":     (r"\bAKIA[A-Z0-9]{16}\b",                        "AKIA<redacted>"),
    "slack_bot":      ("xoxb-[a-zA-Z0-9-]{40,}",                       "xoxb-<redacted>"),
    "slack_user":     ("xoxp-[a-zA-Z0-9-]{40,}",                       "xoxp-<redacted>"),
    "stripe_live":    (r"\b(sk|pk|rk)_live_[a-zA-Z0-9]{20,}\b",        r"\1_live_<redacted>"),
    "sendgrid":       (r"\bSG\.[a-zA-Z0-9_-]{22}\.[a-zA-Z0-9_-]{43}\b", "SG.<redacted>.<redacted>"),
    "jwt":            (r"\beyJ[A-Za-z0-9_-]{20,}\.eyJ[A-Za-z0-9_-]{20,}\.[A-Za-z0-9_-]{20,}\b", "<jwt-token>"),
    "db_postgres":    (r"postgres(?:ql)?://[^:\s]+:[^@\s]+@",          "postgres://<user>:<password>@"),
    "db_mysql":       (r"mysql://[^:\s]+:[^@\s]+@",                    "mysql://<user>:<password>@"),
    "db_mongo":       (r"mongodb(?:\+srv)?://[^:\s]+:[^@\s]+@",        "mongodb://<user>:<password>@"),
    "db_redis":       (r"redis://[^:@\s]*:[^@\s]+@",                   "redis://<user>:<password>@"),
    "users_path":     (r"/Users/[a-zA-Z][a-zA-Z0-9_-]+/",              "/Users/<name>/"),
    "home_path":      (r"/home/[a-zA-Z][a-zA-Z0-9_-]+/",               "/home/<name>/"),
    "private_key":    (r"-----BEGIN (RSA |OPENSSH |EC |DSA |PGP |ENCRYPTED )?PRIVATE KEY-----.*?-----END (RSA |OPENSSH |EC |DSA |PGP |ENCRYPTED )?PRIVATE KEY-----",
                       "-----BEGIN <REDACTED> PRIVATE KEY-----\n<redacted>\n-----END <REDACTED> PRIVATE KEY-----"),
}

# Soft (alleen op verzoek)
SOFT_REPLACEMENTS = {
    "email":          (r"\b[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b", "<email>"),
    "ip_v4_public":   (r"\b(?!10\.|192\.168\.|172\.(?:1[6-9]|2[0-9]|3[0-1])\.|127\.|169\.254\.|0\.)(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b", "<public-ip>"),
}


def anonymize(content: str, include_soft: bool = False) -> tuple[str, list[tuple[str, int]]]:
    """Returns (new_content, [(pattern_name, count), ...])."""
    counts: list[tuple[str, int]] = []
    out = content

    patterns = list(REPLACEMENTS.items())
    if include_soft:
        patterns += list(SOFT_REPLACEMENTS.items())

    for name, (pattern, replacement) in patterns:
        new_out, n = re.subn(pattern, replacement, out, flags=re.DOTALL if "private_key" in name else 0)
        if n > 0:
            counts.append((name, n))
            out = new_out

    return out, counts


def show_diff(original: str, anonymized: str, path: str) -> None:
    import difflib
    diff = difflib.unified_diff(
        original.splitlines(keepends=True),
        anonymized.splitlines(keepends=True),
        fromfile=f"{path} (original)",
        tofile=f"{path} (anonymized)",
        n=2,
    )
    sys.stdout.writelines(diff)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--file", help="Bestand om te anonimiseren")
    ap.add_argument("--stdin", action="store_true", help="Lees stdin, schrijf naar stdout")
    ap.add_argument("--output", help="Schrijf gescrubde versie naar dit bestand")
    ap.add_argument("--inplace", action="store_true", help="Overschrijf het bestand (let op: maakt backup .bak)")
    ap.add_argument("--include-soft", action="store_true", help="Inclusief soft replacements (emails, public IPs)")
    args = ap.parse_args()

    if args.stdin:
        content = sys.stdin.read()
        out, counts = anonymize(content, args.include_soft)
        sys.stdout.write(out)
        if counts:
            for name, n in counts:
                print(f"[anonymize] {name}: {n} hit(s)", file=sys.stderr)
        return 0

    if not args.file:
        ap.print_help()
        return 1

    path = Path(args.file)
    if not path.exists():
        print(f"Bestand niet gevonden: {path}", file=sys.stderr)
        return 1

    content = path.read_text(encoding="utf-8", errors="replace")
    out, counts = anonymize(content, args.include_soft)

    if not counts:
        print(f"Geen secrets gedetecteerd in {path}", file=sys.stderr)
        return 0

    print(f"Gevonden in {path}:", file=sys.stderr)
    for name, n in counts:
        print(f"  - {name}: {n} hit(s)", file=sys.stderr)

    if args.inplace:
        backup = path.with_suffix(path.suffix + ".bak")
        backup.write_text(content, encoding="utf-8")
        path.write_text(out, encoding="utf-8")
        print(f"\nIn-place overschreven. Backup: {backup}", file=sys.stderr)
    elif args.output:
        Path(args.output).write_text(out, encoding="utf-8")
        print(f"\nGeschreven naar {args.output}", file=sys.stderr)
    else:
        print(f"\n--- Diff preview (geen wijziging gemaakt) ---", file=sys.stderr)
        show_diff(content, out, str(path))

    return 0


if __name__ == "__main__":
    sys.exit(main())

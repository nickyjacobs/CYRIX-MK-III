#!/usr/bin/env python3
"""
Secret-scanner voor CYRIX MK-III hooks.

Gebruik:
  validate.py --file <path>           # scan een file op disk
  validate.py --stdin --path <path>   # scan stdin-content, gebruik path voor context

Exit codes:
  0 = OK (geen hits)
  2 = HARD findings (block)
"""
import argparse
import re
import sys
from pathlib import Path

PATTERNS = {
    "anthropic_key": r"sk-ant-[a-zA-Z0-9_-]{40,}",
    "openai_key":    r"sk-[a-zA-Z0-9]{40,}",
    "tavily_key":    r"tvly-[a-zA-Z0-9]{20,}",
    "github_pat":    r"ghp_[a-zA-Z0-9]{36}",
    "github_oauth":  r"gho_[a-zA-Z0-9]{36}",
    "slack_bot":     r"xoxb-[a-zA-Z0-9-]{40,}",
    "aws_access":    r"\bAKIA[A-Z0-9]{16}\b",
    "private_key":   r"-----BEGIN (RSA |OPENSSH |EC |DSA |PGP |ENCRYPTED )?PRIVATE KEY-----",
    "jwt":           r"\beyJ[A-Za-z0-9_-]{20,}\.eyJ[A-Za-z0-9_-]{20,}\.[A-Za-z0-9_-]{20,}\b",
    "users_path":    r"/Users/[a-zA-Z][a-zA-Z0-9_-]+/",
    "home_path":     r"/home/[a-zA-Z][a-zA-Z0-9_-]+/",
}

# Lines containing these substrings are skipped (placeholders / examples)
ALLOWED_MARKERS = [
    "your-token-here", "your_token_here", "your-key-here", "your_key_here",
    "ghp_your_", "tvly-your_", "sk-ant-your_", "sk-your_",
    "example", "placeholder", "<token>", "<api-key>", "<api_key>",
    "<your-", "xxxxxxxx", "fake", "dummy",
]


def scan_content(content: str, source: str) -> list[tuple[int, str, str]]:
    hits = []
    for i, line in enumerate(content.splitlines(), 1):
        lowered = line.lower()
        if any(marker in lowered for marker in ALLOWED_MARKERS):
            continue
        for name, pattern in PATTERNS.items():
            if re.search(pattern, line):
                snippet = line.strip()[:100]
                hits.append((i, name, snippet))
    return hits


def report(hits: list[tuple[int, str, str]], path: str) -> int:
    if not hits:
        return 0
    print(f"\n[SECURITY] Hard-block hits in {path}:", file=sys.stderr)
    for line_no, name, snippet in hits:
        print(f"  {path}:{line_no} — {name}: {snippet}", file=sys.stderr)
    print("\nResolve before continuing. Use placeholders like <api-key> or your_token_here.\n", file=sys.stderr)
    return 2


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--file", help="Scan a file on disk")
    ap.add_argument("--stdin", action="store_true", help="Scan content from stdin")
    ap.add_argument("--path", default="<stdin>", help="Source path label (for stdin mode)")
    args = ap.parse_args()

    if args.stdin:
        content = sys.stdin.read()
        return report(scan_content(content, args.path), args.path)

    if args.file:
        p = Path(args.file)
        if not p.exists() or not p.is_file():
            return 0
        if p.suffix not in {".md", ".json", ".yml", ".yaml", ".sh", ".py"}:
            return 0
        try:
            content = p.read_text(encoding="utf-8", errors="replace")
        except Exception:
            return 0
        return report(scan_content(content, str(p)), str(p))

    ap.print_help()
    return 0


if __name__ == "__main__":
    sys.exit(main())

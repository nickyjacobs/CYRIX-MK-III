#!/usr/bin/env python3
"""
Secret-scanner voor CYRIX MK-III hooks.

Gebruik:
  validate.py --file <path>           # scan een file op disk
  validate.py --stdin --path <path>   # scan stdin-content, gebruik path voor context
  validate.py --staged                # scan alle git-staged files (voor pre-commit)

Exit codes:
  0 = OK (geen HARD findings, mogelijk wel soft warnings)
  2 = HARD findings (block)
"""
import argparse
import re
import subprocess
import sys
from pathlib import Path

# Hard-block patronen — bij hit: exit 2 (block commit)
HARD_PATTERNS = {
    # AI / API providers
    "anthropic_key":  r"sk-ant-[a-zA-Z0-9_-]{40,}",
    "openai_key":     r"sk-[a-zA-Z0-9]{40,}",
    "openai_proj":    r"sk-proj-[a-zA-Z0-9_-]{40,}",
    "tavily_key":     r"tvly-[a-zA-Z0-9]{20,}",
    "google_api":     r"\bAIza[0-9A-Za-z_-]{35}\b",

    # Source control
    "github_pat":     r"ghp_[a-zA-Z0-9]{36}",
    "github_oauth":   r"gho_[a-zA-Z0-9]{36}",
    "github_app":     r"\b(ghu_|ghs_|ghr_)[a-zA-Z0-9]{36}\b",
    "gitlab_pat":     r"glpat-[a-zA-Z0-9_-]{20}",

    # Cloud / SaaS
    "aws_access":     r"\bAKIA[A-Z0-9]{16}\b",
    "aws_secret":     r"\baws_secret_access_key\s*[:=]\s*['\"]?[a-zA-Z0-9/+]{40}['\"]?",
    "slack_bot":      r"xoxb-[a-zA-Z0-9-]{40,}",
    "slack_user":     r"xoxp-[a-zA-Z0-9-]{40,}",
    "stripe_live":    r"\b(sk|pk|rk)_live_[a-zA-Z0-9]{20,}\b",
    "cloudflare":     r"\bcf-token-[a-zA-Z0-9_-]{40,}\b",
    "sendgrid":       r"\bSG\.[a-zA-Z0-9_-]{22}\.[a-zA-Z0-9_-]{43}\b",

    # Crypto / certs
    "private_key":    r"-----BEGIN (RSA |OPENSSH |EC |DSA |PGP |ENCRYPTED )?PRIVATE KEY-----",
    "ssh_cert":       r"-----BEGIN OPENSSH CERTIFICATE-----",
    "pgp_msg":        r"-----BEGIN PGP MESSAGE-----",

    # Tokens / JWT
    "jwt":            r"\beyJ[A-Za-z0-9_-]{20,}\.eyJ[A-Za-z0-9_-]{20,}\.[A-Za-z0-9_-]{20,}\b",

    # Connection strings met embedded credentials
    "db_postgres":    r"postgres(?:ql)?://[^:\s]+:[^@\s]+@",
    "db_mysql":       r"mysql://[^:\s]+:[^@\s]+@",
    "db_mongo":       r"mongodb(?:\+srv)?://[^:\s]+:[^@\s]+@",
    "db_redis":       r"redis://[^:@\s]*:[^@\s]+@",

    # Lokale paden (privacy)
    "users_path":     r"/Users/[a-zA-Z][a-zA-Z0-9_-]+/",
    "home_path":      r"/home/[a-zA-Z][a-zA-Z0-9_-]+/",
}

# Soft warnings — niet blokkerend, wel rapporteren
SOFT_PATTERNS = {
    "high_entropy":   r"['\"]([A-Za-z0-9+/=_-]{40,})['\"]",
    "email":          r"\b[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b",
    "ip_v4_public":   r"\b(?!10\.|192\.168\.|172\.(?:1[6-9]|2[0-9]|3[0-1])\.|127\.|169\.254\.|0\.)(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b",
    "ovpn_ref":       r"\b\w+\.ovpn\b",
    "vault_token":    r"\bhvs\.[a-zA-Z0-9_-]{24,}\b",
}

# Regels waarvan we SOFT-hits onderdrukken (placeholders, examples)
ALLOWED_MARKERS = [
    "your-token-here", "your_token_here", "your-key-here", "your_key_here",
    "ghp_your_", "tvly-your_", "sk-ant-your_", "sk-your_",
    "example", "placeholder", "<token>", "<api-key>", "<api_key>",
    "<your-", "<your_", "xxxxxxxx", "fake", "dummy", "noreply@",
    "n.v.t.", "test@example.com", "user@example.com",
]


def _is_allowed(line: str) -> bool:
    lowered = line.lower()
    return any(marker in lowered for marker in ALLOWED_MARKERS)


def scan_content(content: str, source: str) -> tuple[list, list]:
    """Returns (hard_hits, soft_hits)."""
    hard_hits: list[tuple[int, str, str]] = []
    soft_hits: list[tuple[int, str, str]] = []

    for i, line in enumerate(content.splitlines(), 1):
        if _is_allowed(line):
            continue

        snippet = line.strip()[:100]

        for name, pattern in HARD_PATTERNS.items():
            if re.search(pattern, line):
                hard_hits.append((i, name, snippet))

        if not any(h[0] == i for h in hard_hits):
            for name, pattern in SOFT_PATTERNS.items():
                if re.search(pattern, line):
                    soft_hits.append((i, name, snippet))

    return hard_hits, soft_hits


def report(hard_hits: list, soft_hits: list, path: str) -> int:
    exit_code = 0

    if hard_hits:
        print(f"\n[SECURITY HARD] Block-findings in {path}:", file=sys.stderr)
        for line_no, name, snippet in hard_hits:
            print(f"  {path}:{line_no} — {name}: {snippet}", file=sys.stderr)
        exit_code = 2

    if soft_hits:
        print(f"\n[SECURITY SOFT] Waarschuwingen in {path}:", file=sys.stderr)
        for line_no, name, snippet in soft_hits[:10]:
            print(f"  {path}:{line_no} — {name}: {snippet}", file=sys.stderr)
        if len(soft_hits) > 10:
            print(f"  ... en {len(soft_hits) - 10} meer", file=sys.stderr)

    if hard_hits:
        print(
            "\nResolve HARD-findings vóór commit. Gebruik placeholders of "
            "scripts/anonymize.py om gevoelige data te scrubben.\n",
            file=sys.stderr,
        )

    return exit_code


def scan_file(path: Path) -> int:
    if not path.exists() or not path.is_file():
        return 0
    if path.suffix not in {".md", ".json", ".yml", ".yaml", ".sh", ".py", ".js", ".ts", ".env"}:
        return 0
    try:
        content = path.read_text(encoding="utf-8", errors="replace")
    except Exception:
        return 0
    hard, soft = scan_content(content, str(path))
    return report(hard, soft, str(path))


def scan_staged() -> int:
    """Scan alle git-staged files."""
    try:
        result = subprocess.run(
            ["git", "diff", "--cached", "--name-only", "--diff-filter=ACM"],
            capture_output=True, text=True, check=True,
        )
    except subprocess.CalledProcessError:
        print("[SECURITY] Geen git repo of geen staged files", file=sys.stderr)
        return 0

    files = [Path(f.strip()) for f in result.stdout.splitlines() if f.strip()]
    if not files:
        return 0

    worst = 0
    for f in files:
        rc = scan_file(f)
        if rc > worst:
            worst = rc
    return worst


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--file", help="Scan a file on disk")
    ap.add_argument("--stdin", action="store_true", help="Scan content from stdin")
    ap.add_argument("--path", default="<stdin>", help="Source path label (for stdin mode)")
    ap.add_argument("--staged", action="store_true", help="Scan all git-staged files")
    args = ap.parse_args()

    if args.staged:
        return scan_staged()

    if args.stdin:
        content = sys.stdin.read()
        hard, soft = scan_content(content, args.path)
        return report(hard, soft, args.path)

    if args.file:
        return scan_file(Path(args.file))

    ap.print_help()
    return 0


if __name__ == "__main__":
    sys.exit(main())

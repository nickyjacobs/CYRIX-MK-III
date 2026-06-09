#!/usr/bin/env bash
# CYRIX MK-III — statusline template
#
# Twee-regel statusbalk voor Claude Code, geoptimaliseerd voor:
# - Multi-project workflows (toont projectmap + branch)
# - Lange sessies (context-bar met compact/clear hints)
# - Claude.ai Max/Pro gebruikers (toont 5u + 7d rate-limit verbruik)
#
# === Activatie ===
#
# Optie A — globaal (alle Claude Code sessies):
#   cp scripts/statusline.example.sh ~/.claude/statusline-command.sh
#   chmod +x ~/.claude/statusline-command.sh
#   # Voeg toe aan ~/.claude/settings.json:
#   #   "statusLine": { "type": "command", "command": "bash ~/.claude/statusline-command.sh" }
#
# Optie B — alleen voor dit project:
#   # Voeg toe aan .claude/settings.json in deze repo:
#   #   "statusLine": { "type": "command", "command": "bash .claude/statusline.sh" }
#   # En kopieer naar .claude/statusline.sh (of laat 'm op deze locatie staan en pas command-pad aan)
#
# === Layout ===
#
# Regel 1: projectmap  ⎇ branch[*]  · sessienaam
# Regel 2: model [effort]  [bar] pct%  Xk/Yk tokens  · 5u/7d rate-limits  · compact-hint
#
# === JSON-velden gebruikt (Claude Code stuurt deze via stdin) ===
#
#   session_id, session_name
#   workspace.current_dir (fallback: cwd)
#   model.display_name
#   effort.level (fallback: output_style.name)
#   context_window.used_percentage, total_input_tokens, context_window_size
#   rate_limits.five_hour.used_percentage, rate_limits.seven_day.used_percentage

input=$(cat)

# =============================================================
# REGEL 1: projectmap · git-branch · sessienaam
# =============================================================

# --- Projectmap ---
proj_dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
if [ -n "$proj_dir" ]; then
  proj_name=$(basename "$proj_dir")
else
  proj_name="?"
fi

# --- Git-branch met caching (cache per session_id, max 5 seconden) ---
session_id=$(echo "$input" | jq -r '.session_id // empty')
git_branch=""
git_dirty=0

if [ -n "$proj_dir" ]; then
  cache_file=""
  cache_valid=0

  if [ -n "$session_id" ]; then
    cache_file="/tmp/statusline-git-${session_id}"
    if [ -f "$cache_file" ]; then
      # macOS: stat -f%m; GNU/Linux: stat -c%Y
      cache_mtime=$(stat -f%m "$cache_file" 2>/dev/null || stat -c%Y "$cache_file" 2>/dev/null || echo 0)
      now=$(date +%s)
      age=$(( now - cache_mtime ))
      if [ "$age" -le 5 ]; then
        cache_valid=1
      fi
    fi
  fi

  if [ "$cache_valid" -eq 1 ]; then
    # Lees uit cache: eerste regel = branch, tweede regel = dirty (0/1)
    git_branch=$(sed -n '1p' "$cache_file")
    git_dirty=$(sed -n '2p' "$cache_file")
  else
    # Haal git-info op in subshell zodat cwd van het script niet wijzigt
    git_info=$(cd "$proj_dir" 2>/dev/null && \
      git -C . branch --show-current 2>/dev/null && \
      git -C . status --porcelain 2>/dev/null | head -1)
    if [ -n "$git_info" ]; then
      git_branch=$(echo "$git_info" | head -1)
      dirty_line=$(echo "$git_info" | tail -n +2 | head -1)
      [ -n "$dirty_line" ] && git_dirty=1 || git_dirty=0
    fi
    # Schrijf naar cache (ook als leeg — dan weten we dat het geen git-repo is)
    if [ -n "$cache_file" ]; then
      printf '%s\n%s\n' "$git_branch" "$git_dirty" > "$cache_file"
    fi
  fi
fi

# --- Bouw regel 1 op ---
line1="$proj_name"

if [ -n "$git_branch" ]; then
  if [ "$git_dirty" -eq 1 ] 2>/dev/null; then
    # Geel voor dirty branch
    line1="${line1}  $(printf '\033[33m')⎇ ${git_branch}*$(printf '\033[0m')"
  else
    # Groen voor clean branch
    line1="${line1}  $(printf '\033[32m')⎇ ${git_branch}$(printf '\033[0m')"
  fi
fi

session_name=$(echo "$input" | jq -r '.session_name // empty')
if [ -n "$session_name" ]; then
  line1="${line1}  · ${session_name}"
fi

printf '%s\n' "$line1"

# =============================================================
# REGEL 2: model · effort · bar · context% · tokens · rate-limits · hint
# =============================================================

# --- Model ---
model_raw=$(echo "$input" | jq -r '.model.display_name // empty')
# Strip eventuele "Claude "-prefix voor compacte weergave
model="${model_raw#Claude }"

# --- Effort / output-style label ---
effort=$(echo "$input" | jq -r '.effort.level // empty')
if [ -z "$effort" ]; then
  effort=$(echo "$input" | jq -r '.output_style.name // empty')
fi
if [ -n "$effort" ]; then
  effort_label=" [${effort}]"
else
  effort_label=""
fi

# --- Context percentage ---
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')

if [ -z "$used_pct" ] || [ "$used_pct" = "null" ]; then
  if [ "$ctx_size" -gt 0 ] 2>/dev/null; then
    used_pct=$(echo "$total_input $ctx_size" | awk '{printf "%.0f", ($1/$2)*100}')
  else
    used_pct=0
  fi
fi
used_pct_int=$(printf "%.0f" "$used_pct" 2>/dev/null || echo 0)

# --- Progressbar (20 blokken) ---
BAR_LEN=20
filled=$(( used_pct_int * BAR_LEN / 100 ))
if [ "$filled" -gt "$BAR_LEN" ]; then filled=$BAR_LEN; fi
empty=$(( BAR_LEN - filled ))

bar=""
# Guard op > 0: BSD seq (macOS) telt "seq 1 0" als 1..0 = twee iteraties.
if [ "$filled" -gt 0 ]; then printf -v _fill "%${filled}s"; bar="${_fill// /▓}"; fi
if [ "$empty" -gt 0 ];  then printf -v _pad  "%${empty}s";  bar="${bar}${_pad// /░}"; fi

# --- Token-teller in k ---
if [ "$ctx_size" -gt 0 ] 2>/dev/null; then
  used_k=$(echo "$total_input" | awk '{printf "%.0f", $1/1000}')
  total_k=$(echo "$ctx_size"   | awk '{printf "%.0f", $1/1000}')
  token_str="${used_k}k / ${total_k}k tokens"
else
  token_str=""
fi

# --- Rate limits (Claude.ai Max/Pro — alleen aanwezig na eerste API-response) ---
# Kleur: geel >= 70%, rood >= 90%
_rl_color() {
  local pct=$1
  if [ "$pct" -ge 90 ] 2>/dev/null; then
    printf '\033[31m'   # rood
  elif [ "$pct" -ge 70 ] 2>/dev/null; then
    printf '\033[33m'   # geel
  fi
}

five_raw=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_raw=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

rate_str=""
if [ -n "$five_raw" ]; then
  five_int=$(printf "%.0f" "$five_raw" 2>/dev/null || echo 0)
  col=$(_rl_color "$five_int")
  if [ -n "$col" ]; then
    rate_str="${rate_str} · ${col}5u ${five_int}%\033[0m"
  else
    rate_str="${rate_str} · 5u ${five_int}%"
  fi
fi
if [ -n "$seven_raw" ]; then
  seven_int=$(printf "%.0f" "$seven_raw" 2>/dev/null || echo 0)
  col=$(_rl_color "$seven_int")
  if [ -n "$col" ]; then
    rate_str="${rate_str} · ${col}7d ${seven_int}%\033[0m"
  else
    rate_str="${rate_str} · 7d ${seven_int}%"
  fi
fi

# --- Context-waarschuwingshint ---
hint=""
if [ "$used_pct_int" -ge 85 ] 2>/dev/null; then
  hint="$(printf ' \033[31m· /clear of /compact\033[0m')"
elif [ "$used_pct_int" -ge 70 ] 2>/dev/null; then
  hint="$(printf ' \033[33m· overweeg /compact\033[0m')"
fi

# --- Samengestelde regel ---
printf "%s%s   [%s] %d%%  %s%b%s\n" \
  "$model" \
  "$effort_label" \
  "$bar" \
  "$used_pct_int" \
  "$token_str" \
  "$rate_str" \
  "$hint"

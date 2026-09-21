#!/usr/bin/env bash
# Claude Code status line: RGB gradient, dynamic emoji, cost, code velocity, token count

input=$(cat)

# Colors
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
MAGENTA='\033[35m'
DIM='\033[2m'
BOLD='\033[1m'
RESET='\033[0m'

# Truecolor helper
rgb() { printf '\033[38;2;%d;%d;%dm' "$1" "$2" "$3"; }

# Parse JSON fields
model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
total_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
lines_add=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_del=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')

# Git info
branch=""
repo=""
if [ -n "$cwd" ]; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
  repo=$(basename "$(git -C "$cwd" --no-optional-locks rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null)
fi

# Token count: format as "45.2k/200k"
tokens_part=""
if [ -n "$total_in" ] && [ -n "$ctx_size" ]; then
  used_k=$(echo "$total_in $ctx_size" | awk '{printf "%.1fk/%dk", $1/1000, $2/1000}')
  tokens_part="${DIM}${used_k}${RESET}"
fi

# Context bar: RGB gradient, full blocks only
BAR_WIDTH=20

if [ -n "$used" ]; then
  used_int=$(printf '%.0f' "$used")

  filled=$(( (used_int * BAR_WIDTH + 50) / 100 ))

  bar=""
  for (( i=0; i<BAR_WIDTH; i++ )); do
    pos=$(( i * 100 / (BAR_WIDTH - 1) ))

    if [ "$pos" -le 50 ]; then
      r=$(( 0 + 220 * pos / 50 ))
      g=200
      b=$(( 80 - 80 * pos / 50 ))
    else
      adj=$(( pos - 50 ))
      r=220
      g=$(( 200 - 160 * adj / 50 ))
      b=$(( 0 + 20 * adj / 50 ))
    fi

    if [ "$i" -lt "$filled" ]; then
      bar="${bar}$(rgb $r $g $b)█"
    else
      bar="${bar}\033[38;2;60;60;60m░"
    fi
  done
  bar="${bar}${RESET}"

  if [ "$used_int" -ge 90 ]; then status_emoji="🚨"
  elif [ "$used_int" -ge 70 ]; then status_emoji="🔥"
  elif [ "$used_int" -ge 20 ]; then status_emoji="⚡"
  else status_emoji="🟢"; fi

  if [ "$used_int" -ge 90 ]; then pct_color="$RED"
  elif [ "$used_int" -ge 70 ]; then pct_color="$YELLOW"
  else pct_color="$GREEN"; fi

  ctx_part="${status_emoji} ${bar} ${pct_color}${used_int}%${RESET}"
else
  ctx_part="🟢 \033[38;2;60;60;60m░░░░░░░░░░░░░░░░░░░░${RESET} --%"
fi

# Cost
cost_part="${YELLOW}$(printf '$%.2f' "$cost")${RESET}"

# Code velocity
velocity="${GREEN}+${lines_add}${RESET} ${RED}-${lines_del}${RESET}"

# Build single line
out=""
[ -n "$repo" ] && out="${BOLD}${YELLOW}${repo}${RESET}"
[ -n "$branch" ] && out="${out:+$out }${BOLD}${CYAN}🌿 (${branch})${RESET}"
out="${out:+$out ${DIM}|${RESET} }${ctx_part}"
[ -n "$tokens_part" ] && out="${out} ${DIM}|${RESET} ${tokens_part}"
out="${out} ${DIM}|${RESET} ${cost_part}"
out="${out} ${DIM}|${RESET} ${velocity}"
out="${out} ${DIM}|${RESET} ${MAGENTA}🤖 ${model}${RESET}"

printf '%b' "$out"

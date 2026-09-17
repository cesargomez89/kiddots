function deepcode() {
  : "${DEEPSEEK_API_KEY:?Set DEEPSEEK_API_KEY first}"

  # Canonical slugs (https://api-docs.deepseek.com/quick_start/pricing):
  #   deepseek-flash  -> DeepSeek-V4.1-Flash, 1M context, cheap, vision-capable
  #   deepseek-v4-pro -> DeepSeek-V4-Pro, 1M context, reasoning-heavy
  # Mirrors the server-side mapping (https://api-docs.deepseek.com/quick_start/agent_integrations/claude_code/):
  #   claude-opus-*         -> deepseek-v4-pro
  #   claude-sonnet/haiku-* -> deepseek-flash
  # The [1m] suffix is a Claude Code client-side hint to budget the full 1M
  # context window. It is stripped before the API call. Without it Claude Code
  # falls back to a 200K budget and under-uses available context.
  local opus="${DEEPSEEK_OPUS_MODEL:-deepseek-v4-pro[1m]}"
  local flash="${DEEPSEEK_FLASH_MODEL:-deepseek-flash[1m]}"
  local main="${DEEPSEEK_MODEL:-$flash}"

  env \
    ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic" \
    ANTHROPIC_AUTH_TOKEN="$DEEPSEEK_API_KEY" \
    ANTHROPIC_API_KEY="$DEEPSEEK_API_KEY" \
    ANTHROPIC_MODEL="$main" \
    ANTHROPIC_DEFAULT_OPUS_MODEL="$opus" \
    ANTHROPIC_DEFAULT_SONNET_MODEL="$flash" \
    ANTHROPIC_DEFAULT_HAIKU_MODEL="$flash" \
    CLAUDE_CODE_SUBAGENT_MODEL="$flash" \
    CLAUDE_CODE_EFFORT_LEVEL="${CLAUDE_CODE_EFFORT_LEVEL:-high}" \
    CLAUDE_CODE_AUTO_COMPACT_WINDOW="${CLAUDE_CODE_AUTO_COMPACT_WINDOW:-786432}" \
    command claude "$@"
}

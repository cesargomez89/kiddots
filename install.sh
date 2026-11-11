#!/usr/bin/env bash
# KIDDOTS installer. Safe to rerun:
#   - an existing checkout is reused, never deleted
#   - existing configs are moved to a timestamped backup, never destroyed
#   - symlinks are refreshed in place
#   - anything already installed is skipped
# Dry run: DRY_RUN=1 ./install.sh
set -euo pipefail

REPO_URL="${DOTFILES_REPO:-https://github.com/cesargomez89/kiddots.git}"
BACKUP_ROOT="$HOME/.dotfiles-backups"
STAMP="$(date +%Y%m%d-%H%M%S)"
DRY_RUN="${DRY_RUN:-0}"
BACKUPS=0

step() { printf '\n==> %s\n' "$*"; }
ok()   { printf '  ok: %s\n' "$*"; }
info() { printf '  %s\n' "$*"; }
warn() { printf '  warning: %s\n' "$*" >&2; }
die()  { printf '\nERROR: %s\n' "$*" >&2; exit 1; }
run()  {
  if [ "$DRY_RUN" = 1 ]; then
    printf '  [dry-run] %s\n' "$*"
  else
    "$@"
  fi
}

# Move a real file/dir/symlink out of the way, once per run timestamp.
# Backups mirror the original absolute path, so same-named files never collide.
backup_path() {
  local target="$1" dest
  if [ ! -e "$target" ] && [ ! -L "$target" ]; then
    return 0
  fi
  dest="$BACKUP_ROOT/$STAMP$target"
  info "backup: $target -> $dest"
  BACKUPS=$((BACKUPS + 1))
  run mkdir -p "$(dirname "$dest")"
  run mv "$target" "$dest"
}

# Idempotent symlink: skip when correct, back up real files and foreign links.
link_path() {
  local src="$1" dest="$2" old=""
  if [ ! -e "$src" ]; then
    warn "source missing, skipping: $src"
    return 0
  fi
  if [ -L "$dest" ]; then
    old="$(readlink "$dest")"
    if [ "$old" = "$src" ]; then
      ok "$dest"
      return 0
    fi
    case "$old" in
      "$DOTFILES"/*) info "relink: $dest (was $old)" ;;
      *) backup_path "$dest" ;;
    esac
  elif [ -e "$dest" ]; then
    backup_path "$dest"
  fi
  run mkdir -p "$(dirname "$dest")"
  run ln -sfn "$src" "$dest"
  ok "$dest -> $src"
}

# Clone on first run, fast-forward afterwards.
clone_or_update() {
  local url="$1" dest="$2" depth="${3:-}" dir
  dir="$(dirname "$dest")"
  if [ -d "$dest/.git" ]; then
    if git -C "$dest" pull --ff-only --quiet; then
      ok "$dest (updated)"
    else
      warn "could not fast-forward $dest, keeping current version"
    fi
    return 0
  fi
  run mkdir -p "$dir"
  if [ -n "$depth" ]; then
    run git clone --depth="$depth" "$url" "$dest"
  else
    run git clone "$url" "$dest"
  fi
  ok "$dest (cloned)"
}

# ---------------------------------------------------------------------------
# 1. Locate the dotfiles checkout
# ---------------------------------------------------------------------------
SCRIPT_DIR=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
fi

if [ -n "${DOTFILES_DIR:-}" ]; then
  DOTFILES="$DOTFILES_DIR"
  LOCAL_CHECKOUT=1
elif [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR/.git" ]; then
  DOTFILES="$SCRIPT_DIR"
  LOCAL_CHECKOUT=1
else
  DOTFILES="$HOME/.dotfiles"
  LOCAL_CHECKOUT=0
fi

step "Dotfiles checkout: $DOTFILES"
if [ -d "$DOTFILES/.git" ]; then
  if [ "$LOCAL_CHECKOUT" = 1 ]; then
    ok "$DOTFILES (local checkout, left untouched)"
  elif git -C "$DOTFILES" pull --ff-only --quiet; then
    ok "$DOTFILES (updated)"
  else
    warn "could not fast-forward $DOTFILES, keeping current version"
  fi
else
  if [ -e "$DOTFILES" ]; then
    die "$DOTFILES exists but is not a git checkout. Move it away and rerun."
  fi
  info "cloning $REPO_URL"
  run git clone "$REPO_URL" "$DOTFILES"
fi

# ---------------------------------------------------------------------------
# 2. Third-party tools
# ---------------------------------------------------------------------------
step "antidote"
clone_or_update https://github.com/mattmc3/antidote.git "${ZDOTDIR:-$HOME}/.antidote" 1

step "tmux plugin manager"
clone_or_update https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

step "starship"
if command -v starship >/dev/null 2>&1; then
  ok "already installed: $(starship --version | head -n1)"
else
  run sh -c 'curl -fsSL https://starship.rs/install.sh | sh -s -- -y'
  ok "installed"
fi

# ---------------------------------------------------------------------------
# 3. Link configs (never overwrite silently)
# ---------------------------------------------------------------------------
step "Linking dotfiles"
run mkdir -p "$HOME/.config"
run mkdir -p "$HOME/.claude" "$HOME/.gemini/antigravity-cli" "$HOME/.gemini/config" \
  "$HOME/.pi/agent" "$HOME/.tmux/plugins"

link_path "$DOTFILES/zsh/zshrc"                     "$HOME/.zshrc"
link_path "$DOTFILES/zsh/zsh_plugins.txt"           "$HOME/.zsh_plugins.txt"
link_path "$DOTFILES/tmux/tmux.conf"                "$HOME/.tmux.conf"
link_path "$DOTFILES/nvim"                          "$HOME/.config/nvim"
link_path "$DOTFILES/kitty"                         "$HOME/.config/kitty"
link_path "$DOTFILES/git/gitconfig"                 "$HOME/.gitconfig"
link_path "$DOTFILES/starship/starship.toml"        "$HOME/.config/starship.toml"
link_path "$DOTFILES/fum"                           "$HOME/.config/fum"

link_path "$DOTFILES/claude/statusline.sh"          "$HOME/.claude/statusline.sh"
link_path "$DOTFILES/claude/settings.json"          "$HOME/.claude/settings.json"
link_path "$DOTFILES/agents/AGENTS.md"              "$HOME/.claude/CLAUDE.md"

link_path "$DOTFILES/antigravity/settings.json"     "$HOME/.gemini/antigravity-cli/settings.json"
link_path "$DOTFILES/agents/AGENTS.md"              "$HOME/.gemini/config/AGENTS.md"
link_path "$DOTFILES/antigravity/mcp_config.json"   "$HOME/.gemini/config/mcp_config.json"
link_path "$DOTFILES/agents/AGENTS.md"              "$HOME/.gemini/GEMINI.md"
link_path "$DOTFILES/agents/AGENTS.md"              "$HOME/.pi/agent/AGENTS.md"

# local, machine-specific shell additions (never truncate an existing file)
run touch "$HOME/.zshrc_profile"

# ---------------------------------------------------------------------------
# 4. tmux plugins (needs ~/.tmux.conf linked first, so keep after section 3)
# ---------------------------------------------------------------------------
step "tmux plugins"
if command -v tmux >/dev/null 2>&1 && [ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
  if run "$HOME/.tmux/plugins/tpm/bin/install_plugins"; then
    ok "tpm plugins installed"
  else
    warn "tpm plugin install failed, run it later from tmux with prefix + I"
  fi
else
  warn "tmux not found, skipping tpm plugin install"
fi

# ---------------------------------------------------------------------------
# 5. Fonts
# ---------------------------------------------------------------------------
step "Fonts"
if [ -f "$DOTFILES/fonts/download.sh" ]; then
  run bash "$DOTFILES/fonts/download.sh"
else
  warn "fonts/download.sh not found"
fi

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
step "Done"
if [ "$BACKUPS" -gt 0 ]; then
  info "$BACKUPS previous file(s) saved in $BACKUP_ROOT/$STAMP/ (original paths kept)"
else
  info "nothing needed a backup, setup was already in place"
fi
info "open a new terminal, or run: exec zsh"

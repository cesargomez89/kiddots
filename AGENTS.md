# AGENTS.md - KIDD🌀TS Dotfiles

## Overview

This is a dotfiles repository containing configuration files for:
- **Neovim** - Lua-based editor configuration
- **Zsh** - Shell aliases and functions
- **Kitty** - Terminal emulator
- **Tmux** - Terminal multiplexer
- **Starship** - Cross-shell prompt
- **Git** - Version control configuration

---

## Build/Lint/Test Commands

This is a **configuration repository**, not a software project. There are no traditional build/lint/test commands.

### Testing Config Changes

For Neovim configuration changes:
```bash
# Check Neovim config syntax
nvim --headless -c "lua vim.fn.stdpath('config')" -c "quit" 2>&1

# Verify Lua syntax
luac -p ~/.config/nvim/lua/*.lua
luac -p ~/.config/nvim/lua/**/*.lua
```

For Zsh configuration:
```bash
# Check zshrc syntax
zsh -n ~/.zshrc
zsh -n ~/.dotfiles/zsh/zshrc

# Check all zsh files
for f in ~/.dotfiles/zsh/**/*.zsh; do zsh -n "$f"; done
```

For Git configuration:
```bash
# Verify gitconfig syntax
git config --list --show-origin | head -20
```

### Reloading Configurations

```bash
# Reload Neovim config (from within Neovim)
:source ~/.config/nvim/init.lua

# Reload Zsh config
source ~/.zshrc

# Reload Starship
eval "$(starship init zsh)"
```

---

## Code Style Guidelines

### Neovim Lua Configuration

#### General Principles
- Use **single quotes** for strings in Lua (`'string'`)
- Use **double quotes** only when necessary (e.g., `"string with 'nested' quotes"`)
- Always use **2 spaces** for indentation (enforced in `nvim/lua/options.lua`)
- Use **trailing commas** in table definitions for easier diffs

#### Plugin Structure

Follow this pattern for plugin configs in `nvim/lua/plugins/*.lua`:

```lua
return {
  {
    "owner/repo",
    lazy = false,  -- or true if lazy-loaded
    dependencies = {
      "other/plugin",
    },
    config = function()
      require("module").setup({})
    end,
  },
  -- Additional plugins in same file as separate table entries
}
```

#### Keymaps

Use `vim.keymap.set()` for keybindings with descriptive `desc`:

```lua
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
```

Use `noremap = true, silent = true` for most mappings.

#### Options

Set Neovim options in `nvim/lua/options.lua`:
```lua
vim.opt.option_name = true
vim.g.mapleader = " "
```

Use `vim.api.nvim_set_keymap` for complex mappings requiringnoremap.

#### Imports

```lua
-- Local modules
require("options")
require("plugins.name")

-- External plugins
local cmp = require('cmp')
local lspkind = require('lspkind')
```

### Zsh Shell Scripts

#### General Principles
- Use **double quotes** for strings in zsh
- Use **2 spaces** for indentation
- Add comments for non-obvious configurations
- Use `local` for variables in functions

#### Aliases

Define aliases in separate files under `zsh/aliases/`:
- `shell.zsh` - General shell aliases
- `git.zsh` - Git aliases
- `docker.zsh` - Docker aliases

Alias format (from ALIASES.md):
```zsh
alias short="full command"
alias g="git"
alias gc="git commit --verbose"
```

#### Functions

Place functions in `zsh/functions/`:
```zsh
function name() {
  # function body
}
```

### Git Configuration

Follow INI format in `git/gitconfig`:
```ini
[section]
  key = value
```

Use 2-space indentation for readability.

### Starship Configuration

Follow TOML format in `starship/starship.toml`:
```toml
[property]
key = "value"
```

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Files (Lua) | snake_case | `lsp_config.lua` |
| Files (Zsh) | snake_case | `shell.zsh` |
| Functions | kebab-case | `my-function()` |
| Aliases | Short, memorable | `gc`, `gco`, `gp` |
| Neovim leader keys | Descriptive | `<leader>gd` for "go definition" |
| Variables (Lua) | snake_case | `local config = {}` |
| Variables (Zsh) | lowercase | `local_var="value"` |

---

## Error Handling

### Neovim

- Wrap `config` functions in `pcall` when loading may fail:
  ```lua
  config = function()
    local ok, module = pcall(require, "module")
    if ok then
      module.setup({})
    end
  end
  ```

- Use `vim.defer_fn` for plugins that need delayed initialization

### Zsh

- Use `set -e` at script top for strict error handling (optional)
- Check command existence before running:
  ```zsh
  if (( $+commands[git] )); then
    alias g="git"
  fi
  ```

---

## Directory Structure

```
.dotfiles/
├── AGENTS.md              # This file
├── README.md              # Project documentation
├── ALIASES.md             # Shell alias reference
├── install.sh             # Installation script
├── nvim/
│   ├── init.lua           # Neovim entry point
│   └── lua/
│       ├── options.lua    # Editor options
│       └── plugins/       # Plugin configurations
├── zsh/
│   ├── zshrc              # Zsh main config
│   ├── aliases/           # Alias definitions
│   └── functions/         # Shell functions
├── git/
│   ├── gitconfig          # Git configuration
│   └── gitignore          # Global gitignore
├── kitty/                 # Kitty terminal config
├── tmux/                  # Tmux config
├── starship/              # Starship prompt config
└── fum/                   # Fum (session manager) config
```

---

## Common Tasks

### Adding a New Neovim Plugin

1. Create `nvim/lua/plugins/<name>.lua`
2. Follow the plugin structure pattern
3. Run `:Lazy sync` in Neovim to install

### Adding a New Alias

1. Edit appropriate file in `zsh/aliases/`
2. Update ALIASES.md with the new alias
3. Source zshrc: `source ~/.zshrc`

### Adding a New Zsh Function

1. Create `zsh/functions/<name>.zsh`
2. Source in zshrc if not auto-loaded
3. Test: `source ~/.zshrc && name`

---

## Testing Your Changes

Before committing changes:

1. **Neovim**: Open Neovim and verify no errors on startup
2. **Zsh**: Run `zsh -n ~/.zshrc` to check syntax
3. **Starship**: Run `starship config` to validate TOML
4. **Git**: Test with `git config --list` to verify settings

---

## Important Notes

- This repository uses **Lazy.nvim** for Neovim plugin management
- Neovim uses **nvim-cmp** for completion with multiple AI sources
- The prompt uses **Starship** with Eza for modern `ls`
- All shell configurations are loaded dynamically from the `zsh/` directory

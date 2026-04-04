# Minuet AI + Blink CMP Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add Minuet AI as a completion source to blink.cmp, using local llama-server with Qwen3.5 9B (Q4_K_M) for AI-powered code autocompletion.

**Architecture:** Minuet AI connects to llama-server via OpenAI FIM-compatible API at `http://localhost:8080/v1/completions`. Blink.cmp displays completions from Minuet alongside LSP and other sources.

**Tech Stack:** Neovim, blink.cmp, minuet-ai.nvim, llama.cpp (llama-server)

---

### Task 1: Create llama-server startup function

**Files:**
- Create: `zsh/functions/llama-serve.zsh`

- [ ] **Step 1: Create llama-serve.zsh function**

```zsh
function llama-serve() {
  local model="unsloth/Qwen3.5-9B-GGUF:Q4_K_M"
  local port="${1:-8080}"

  llama-server \
    -hf "$model" \
    --port "$port" \
    --jinja \
    -ngl 99 \
    -c 131072 \
    -n 16384 \
    -fa on \
    -ctk q4_0 \
    -ctv q4_0 \
    -b 2048 \
    -ub 512 \
    --temp 1.0 --top-k 20 --top-p 0.99
}
```

- [ ] **Step 2: Verify file loads**

Run: `zsh -n ~/.dotfiles/zsh/functions/llama-serve.zsh`
Expected: No syntax errors

---

### Task 2: Add minuet-ai.nvim plugin

**Files:**
- Create: `nvim/lua/plugins/minuet.lua`

- [ ] **Step 1: Create minuet plugin config**

```lua
return {
  {
    "milanglacier/minuet-ai.nvim",
    dependencies = {
      "plenary.nvim",
      "saghen/blink.cmp",
    },
    -- Enable blink.cmp integration
    opts = {
      blink = {
        enable_auto_complete = true,
      },
      provider = "openai_fim_compatible",
      n_completions = 1,
      context_window = 512,
      request_timeout = 3,
      provider_options = {
        openai_fim_compatible = {
          api_key = "TERM",
          name = "Llama.cpp",
          end_point = "http://localhost:8080/v1/completions",
          model = "PLACEHOLDER",
          optional = {
            max_tokens = 56,
            top_p = 0.9,
          },
          template = {
            prompt = function(context_before_cursor, context_after_cursor, _)
              return "<|fim_prefix|>"
                .. context_before_cursor
                .. "<|fim_suffix|>"
                .. context_after_cursor
                .. "<|fim_middle|>"
            end,
            suffix = false,
          },
        },
      },
    },
    config = function(_, opts)
      require("minuet").setup(opts)
    end,
  },
}
```

- [ ] **Step 2: Verify Lua syntax**

Run: `luac -p ~/.dotfiles/nvim/lua/plugins/minuet.lua`
Expected: No errors

---

### Task 3: Update blink.cmp to include minuet source

**Files:**
- Modify: `nvim/lua/plugins/blink.lua:1-34`

- [ ] **Step 1: Add minuet to dependencies and sources**

Update the plugin spec to include minuet:

```lua
return {
  "saghen/blink.cmp",
  version = "*",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "Huijiro/blink-cmp-supermaven",
    "milanglacier/minuet-ai.nvim",
  },
  opts = {
    snippets = {
      preset = "luasnip",
    },
    sources = {
      default = { "supermaven", "lsp", "snippets", "buffer", "path", "minuet" },
      providers = {
        supermaven = {
          name = "supermaven",
          module = "blink-cmp-supermaven",
        },
        minuet = {
          name = "minuet",
          module = "minuet.blink",
          async = true,
          timeout_ms = 3000,
          score_offset = 50,
        },
      },
    },
    keymap = {
      preset = "default",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
  },
  config = function(_, opts)
    require("luasnip.loaders.from_vscode").lazy_load()
    require("blink.cmp").setup(opts)
  end,
}
```

- [ ] **Step 2: Verify config loads**

Run: `nvim --headless -c "lua vim.fn.stdpath('config')" -c "quit" 2>&1`
Expected: No Lua errors

---

### Task 4: Test the integration

**Files:**
- Manual testing

- [ ] **Step 1: Install plugins**

Run Neovim and execute `:Lazy sync`

- [ ] **Step 2: Start llama-server**

```bash
llama-serve
```

- [ ] **Step 3: Verify completions work**

Open a code file in Neovim and type code to trigger completions. You should see minuet suggestions appear in the completion menu.

---

## Summary

| Task | File | Action |
|------|------|--------|
| 1 | `zsh/functions/llama-serve.zsh` | Create |
| 2 | `nvim/lua/plugins/minuet.lua` | Create |
| 3 | `nvim/lua/plugins/blink.lua` | Modify |
| 4 | Manual testing | Verify |

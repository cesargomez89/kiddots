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

return {
  "saghen/blink.cmp",
  version = "*",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "Huijiro/blink-cmp-supermaven",
  },
  opts = {
    snippets = {
      preset = "luasnip",
    },
    sources = {
      default = { "supermaven", "lsp", "snippets", "buffer", "path" },
      providers = {
        supermaven = {
          name = "supermaven",
          module = "blink-cmp-supermaven",
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

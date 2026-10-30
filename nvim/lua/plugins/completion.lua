return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require 'luasnip'.filetype_extend("ruby", { "rails" })
        require 'luasnip'.filetype_extend("ruby", { "rdoc" })
        require 'luasnip'.filetype_extend("eruby", { "rails" })
        require 'luasnip'.filetype_extend("eruby", { "html" })
      end,
    },
    config = function()
      require("luasnip").config.set_config({
        history = true,
        delete_check_events = "TextChanged",
      })
    end,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "L3MON4D3/LuaSnip" },
    opts = {
      keymap = {
        preset = "none",
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-Space>"] = { "show", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = false } },
        menu = { border = "rounded" },
        documentation = { auto_show = true, window = { border = "rounded" } },
      },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "snippets", "lsp", "buffer", "path" },
        providers = {
          snippets = { max_items = 3 },
          -- no fallbacks so buffer words show next to LSP items, like the old nvim-cmp setup
          lsp = { max_items = 3, fallbacks = {} },
          buffer = { max_items = 5 },
        },
      },
      cmdline = {
        sources = function()
          local type = vim.fn.getcmdtype()
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          return {}
        end,
      },
    },
  },
}

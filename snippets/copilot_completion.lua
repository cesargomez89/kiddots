-- Enable copilot completion by appending the commented lines to your existing completion.lua
-- or just replace the full content and uncomment the lines.
return {
  "nvim-cmp",
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      -- "zbirenbaum/copilot-cmp",
      "onsails/lspkind.nvim",
      -- dependencies = "copilot.lua",
      "L3MON4D3/LuaSnip",
      dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
      },
    },
  },
  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    -- require("copilot_cmp").setup()
    require("luasnip.loaders.from_vscode").lazy_load()

    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
      local line, col = unpack(vim.api.nvim_win_get_cursor(1))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
    end

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp", group_index = 2 },
        { name = "path", group_index = 2 },
        { name = "buffer", group_index = 2 },
        -- { name = "copilot", group_index = 2 },
        { name = "luasnip", group_index = 2 },
      }),
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol',
          maxwidth = {
            menu = 50,
            abbr = 50,
          },
          symbol_map = { Copilot = "" },
          ellipsis_char = '...',
          show_labelDetails = true,
          before = function (entry, vim_item)
            return vim_item
          end
        })
      },
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })
  end,
}

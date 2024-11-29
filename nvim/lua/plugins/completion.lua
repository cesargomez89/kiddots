return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require'luasnip'.filetype_extend("ruby", {"rails"})
        require'luasnip'.filetype_extend("ruby", {"rdoc"})
        require'luasnip'.filetype_extend("eruby", {"rails"})
        require'luasnip'.filetype_extend("eruby", {"html"})
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
    "nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')

      vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

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
        performance = {
          fetching_timeout = 2000,
        },
        sources = cmp.config.sources({
          { name = "codeium", group_index = 2 },
          { name = "luasnip", group_index = 2 },
          { name = "lsp", group_index = 2 },
          { name = "buffer", group_index = 2 },
          { name = "path", group_index = 2 },
        }),
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<Tab>'] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          ['<S-Tab>'] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
          }),
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = {
              menu = 50,
              abbr = 50,
            },
            symbol_map = { Copilot = "", Codeium = ""},
            ellipsis_char = '...',
            show_labelDetails = true,
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
  },
}

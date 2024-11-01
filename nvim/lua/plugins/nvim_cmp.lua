return {
  "nvim-cmp",
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "zbirenbaum/copilot-cmp",
      dependencies = "copilot.lua",
    },
  },
  config = function()
    local cmp = require('cmp')

    cmp.setup({
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "path", group_index = 2 },
        { name = "buffer", group_index = 2 },
      }),
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
    })

    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    require('lspconfig')['rubocop, ruby_lsp'].setup({
      capabilities = capabilities
    })
  end,
}

return {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = { "rubocop", "ruby_lsp", "erb-formatter", "erb-lint", "html" },
    }

    require('lspconfig').html.setup({
      filetypes = { "html", "erb" },
    })

    require('lspconfig').ruby_lsp.setup{}
    require('lspconfig').rubocop.setup{}
    require('lspconfig').erb_formatter.setup({})
    require('lspconfig').erb_lint.setup({})
  end,
}

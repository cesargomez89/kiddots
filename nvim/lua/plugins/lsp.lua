return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {desc = "Hover definition"})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {desc = "Go to definition"})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {desc = "Show references"})
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {desc= "Format code"})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
    end,
  },
}

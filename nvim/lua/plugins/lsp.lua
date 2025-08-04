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
      automatic_installation = true,
      ensure_installed = {
        "lua_ls",
        "gopls",
        "ruby_lsp",
        "rubocop",
        "eslint",
        "stimulus_ls",
        "ts_ls",
        "astro",
        "prismals",
        "dockerls",
      }
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.ruby_lsp.setup({ capabilities = capabilities })
      lspconfig.rubocop.setup({ capabilities = capabilities })
      lspconfig.stimulus_ls.setup({ capabilities = capabilities })
      lspconfig.eslint.setup({ capabilities = capabilities })
      lspconfig.ts_ls.setup({ capabilities = capabilities })
      lspconfig.astro.setup({ capabilities = capabilities })
      lspconfig.prismals.setup({ capabilities = capabilities })
      lspconfig.dockerls.setup({ capabilities = capabilities })
      lspconfig.lua_ls.setup({ capabilities = capabilities })

      lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            staticcheck = true,
          }
        }
      })

      vim.diagnostic.config({
        update_in_insert = false,
        virtual_text = {
          prefix = "",
          spacing = 1,
        },
      })

      for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
        vim.fn.sign_define("DiagnosticSign" .. diag, {
          text = "",
          texthl = "DiagnosticSign" .. diag,
          linehl = "",
          numhl = "DiagnosticSign" .. diag,
        })
      end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {desc = "Hover definition"})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {desc = "Go to definition"})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {desc = "Show references"})
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {desc= "Format code"})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          vim.lsp.buf.format { async = true }
        end
      })
    end,
  },
}

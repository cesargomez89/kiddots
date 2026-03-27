return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				ruby = { "rubocop" },
				python = { "isort", "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				go = { "gofmt", "goimports" },
			},
			format_on_save = {
				timeout_ms = 2000,
				lsp_fallback = true,
			},
		})

		vim.keymap.set({ "n", "v" }, "gq", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, { desc = "Format buffer" })
	end,
}

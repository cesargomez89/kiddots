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
		snippets = { preset = "luasnip" },
		sources = {
			default = { "minuet", "supermaven", "lsp", "snippets", "buffer", "path" },
			providers = {
				supermaven = {
					name = "Supermaven",
					module = "blink-cmp-supermaven",
					score_offset = 100,
				},
				minuet = {
					name = "Minuet",
					module = "minuet.blink",
					score_offset = 90,
					async = true,
					timeout_ms = 500,
					enabled = function()
						local handle = io.popen("nc -z localhost 8081 > /dev/null 2>&1 && echo 'up' || echo 'down'")
						local res = handle:read("*a"):gsub("%s+", "")
						handle:close()
						return res == "up"
					end,
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

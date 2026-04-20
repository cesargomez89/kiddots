return {
	"saghen/blink.cmp",
	version = "*",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		"Huijiro/blink-cmp-supermaven",
		-- "milanglacier/minuet-ai.nvim",
		"giuxtaposition/blink-cmp-copilot",
	},
	opts = {
		snippets = { preset = "luasnip" },
		completion = {
			ghost_text = {
				enabled = true,
			},
		},
		sources = {
			default = { "copilot", "supermaven", "lsp", "snippets", "buffer", "path" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-cmp-copilot",
					score_offset = 100,
					async = true,
				},
				supermaven = {
					name = "supermaven",
					module = "blink-cmp-supermaven",
					score_offset = 80,
					async = true,
				},
				-- minuet = {
				-- 	name = "minuet",
				-- 	module = "minuet.blink",
				-- 	timeout_ms = 500,
				-- 	async = true,
				-- 	score_offset = 50,
				-- 	enabled = function()
				-- 		local handle = io.popen("nc -z localhost 8081 > /dev/null 2>&1 && echo 'up' || echo 'down'")
				-- 		local res = handle:read("*a"):gsub("%s+", "")
				-- 		handle:close()
				-- 		local local_running = res == "up"
				--
				-- 		local api_key = os.getenv("OPENROUTER_API_KEY")
				-- 		local has_api_key = api_key and api_key ~= ""
				--
				-- 		return local_running or has_api_key
				-- 	end,
				-- },
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

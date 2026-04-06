return {
	"saghen/blink.cmp",
	version = "*",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		"Huijiro/blink-cmp-supermaven",
		"milanglacier/minuet-ai.nvim",
		"giuxtaposition/blink-cmp-copilot",
	},
	opts = {
		snippets = { preset = "luasnip" },
		sources = {
			default = { "minuet", "copilot", "supermaven", "lsp", "snippets", "buffer", "path" },
			providers = {
				supermaven = {
					name = "Supermaven",
					module = "blink-cmp-supermaven",
					score_offset = 100,
				},
				copilot = {
					name = "copilot",
					module = "blink-cmp-copilot",
					score_offset = 100,
					async = true,
					transform_items = function(_, items)
						local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
						local kind_idx = #CompletionItemKind + 1
						CompletionItemKind[kind_idx] = "Copilot"
						for _, item in ipairs(items) do
							item.kind = kind_idx
						end
						return items
					end,
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
		appearance = {
			-- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
			kind_icons = {
				Copilot = "",
				Text = "󰉿",
				Method = "󰊕",
				Function = "󰊕",
				Constructor = "󰒓",

				Field = "󰜢",
				Variable = "󰆦",
				Property = "󰖷",

				Class = "󱡠",
				Interface = "󱡠",
				Struct = "󱡠",
				Module = "󰅩",

				Unit = "󰪚",
				Value = "󰦨",
				Enum = "󰦨",
				EnumMember = "󰦨",

				Keyword = "󰻾",
				Constant = "󰏿",

				Snippet = "󱄽",
				Color = "󰏘",
				File = "󰈔",
				Reference = "󰬲",
				Folder = "󰉋",
				Event = "󱐋",
				Operator = "󰪚",
				TypeParameter = "󰬛",
			},
		},
	},
	config = function(_, opts)
		require("luasnip.loaders.from_vscode").lazy_load()
		require("blink.cmp").setup(opts)
	end,
}

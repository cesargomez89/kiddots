return {
	{
		"milanglacier/minuet-ai.nvim",
		dependencies = {
			"plenary.nvim",
			"saghen/blink.cmp",
		},
		opts = {
			blink = {
				enable_auto_complete = true,
			},
			provider = "openai_compatible",
			n_completions = 2,
			context_window = 4096,
			request_timeout = 5,
			provider_options = {
				openai_compatible = {
					api_key = "OPENROUTER_API_KEY",
					name = "OpenRouter",
					end_point = "https://openrouter.ai/api/v1/chat/completions",
					model = "openai/gpt-oss-20b:free",
					optional = {
						max_tokens = 128,
						top_p = 0.9,
					},
				},
			},
			-- provider = "openai_fim_compatible",
			-- n_completions = 2,
			-- context_window = 512,
			-- request_timeout = 3,
			-- provider_options = {
			-- 	openai_fim_compatible = {
			-- 		api_key = "TERM",
			-- 		name = "Llama.cpp",
			-- 		end_point = "http://localhost:8081/v1/completions",
			-- 		model = "PLACEHOLDER",
			-- 		optional = {
			-- 			max_tokens = 56,
			-- 			top_p = 0.9,
			-- 			stop = { "<|endoftext|>", "<|fim_prefix|>", "<|fim_suffix|>", "<|fim_middle|>" },
			-- 		},
			-- 		template = {
			-- 			prompt = function(context_before_cursor, context_after_cursor, _)
			-- 				return "<|fim_prefix|>"
			-- 					.. context_before_cursor
			-- 					.. "<|fim_suffix|>"
			-- 					.. context_after_cursor
			-- 					.. "<|fim_middle|>"
			-- 			end,
			-- 			suffix = false,
			-- 		},
			-- 	},
			-- },
		},
		config = function(_, opts)
			require("minuet").setup(opts)
		end,
	},
}

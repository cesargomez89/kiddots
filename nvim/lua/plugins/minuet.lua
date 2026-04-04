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
      provider = "openai_fim_compatible",
      n_completions = 1,
      context_window = 512,
      request_timeout = 3,
      provider_options = {
        openai_fim_compatible = {
          api_key = "TERM",
          name = "Llama.cpp",
          end_point = "http://localhost:8080/v1/completions",
          model = "PLACEHOLDER",
          optional = {
            max_tokens = 56,
            top_p = 0.9,
          },
          template = {
            prompt = function(context_before_cursor, context_after_cursor, _)
              return "<|fim_prefix|>"
                .. context_before_cursor
                .. "<|fim_suffix|>"
                .. context_after_cursor
                .. "<|fim_middle|>"
            end,
            suffix = false,
          },
        },
      },
    },
    config = function(_, opts)
      require("minuet").setup(opts)
    end,
  },
}
return {
  {
    'milanglacier/minuet-ai.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      require('minuet').setup({
        provider = "openai_fim_compatible",
        -- provider = "gemini",
        provider_options = {
          gemini = {
            model = 'gemini-1.5-pro-latest',
            system = default_system,
            few_shots = default_few_shots,
            stream = true,
            optional = {},
          },
        },
        openai_fim_compatible = {
          model = 'deepseek-coder',
          end_point = 'https://api.deepseek.com/beta/completions',
          name = 'Deepseek',
          api_key = os.getenv('DEEPSEEK_API_KEY'),
          stream = true,
          optional = {
            stop = nil,
            max_tokens = nil,
          },
        },
      })
    end
  },
}

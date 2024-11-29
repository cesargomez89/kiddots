return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local cmp = require('cmp')

    require("codecompanion").setup({
      display = {
        action_palette = {
          provider = "telescope"
        },
        chat = {
          window = {
            layout = "float",
            border = "rounded",
          },
        },
      },
      strategies = {
        chat = {
          adapter = "ollama",
          roles = {
            llm = " DeepSeek ",
            user = "Me",
          },
        },
        inline = {
          adapter = "ollama",
        },
        cmd= {
          adapter = "ollama",
        },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://api.deepseek.com/beta",
              api_key = os.getenv("DEEPSEEK_API_KEY"),
              chat_url = "/chat/completions",
            },
            schema = {
              model = {
                default = "deepseek-chat",
              },
            },
          })
        end,
      },
    })

    vim.api.nvim_set_keymap("n", "<leader>aa", ":CodeCompanionChat toggle<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>ai", ":CodeCompanion<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>ac", ":CodeCompanionCmd<CR>", { noremap = true, silent = true })
  end
}

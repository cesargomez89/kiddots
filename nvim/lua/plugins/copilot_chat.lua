return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "zbirenbaum/copilot.lua" },
    },
    build = "make tiktoken",
    opts = {
      debug = true,
    },
  },
}

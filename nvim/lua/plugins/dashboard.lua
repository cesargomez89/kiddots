return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("dashboard").setup({
        theme = "hyper",
        config = {
          week_header = { enable = true },
          shortcut = {
            {
              desc = "Update plugins",
              group = "@property",
              action = "Lazy update",
              key = "u",
            },
            {
              icon = "󰈔 ",
              icon_hl = "@variable",
              desc = "Find files",
              group = "Label",
              action = "Telescope find_files",
              key = "f",
            },
            {
              icon = "󰊢 ",
              icon_hl = "@variable",
              desc = "Git files",
              group = "Label",
              action = "Telescope git_files",
              key = "g",
            },
            {
              icon = "󰈙 ",
              icon_hl = "@variable",
              desc = "Buffers",
              group = "Label",
              action = "Telescope buffers",
              key = "b",
            },
            {
              icon = "󰈗 ",
              icon_hl = "@variable",
              desc = "Recent files",
              group = "Label",
              action = "Telescope oldfiles",
              key = "r",
            },
            {
              icon = "󰒋 ",
              icon_hl = "@variable",
              desc = "Avante AI",
              group = "Label",
              action = "AvanteAsk",
              key = "a",
            },
          },
          project = { enable = true, limit = 8, icon = "󰉖 ", label = "", action = "Telescope find_files cwd=" },
          mru = { enable = true, limit = 10, icon = "󰈙 ", label = "", cwd_only = false },
        },
      })
    end,
  },
}

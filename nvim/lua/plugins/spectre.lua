return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>rS",
      function()
        require("spectre").open()
      end,
      desc = "Search & replace in project",
    },
    {
      "<leader>rw",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Replace word under cursor",
      mode = { "v", "x" },
    },
  },
}

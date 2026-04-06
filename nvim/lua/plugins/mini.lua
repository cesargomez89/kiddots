return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      require("mini.comment").setup({})
      require("mini.indentscope").setup({})
      require("mini.surround").setup({})
      require("mini.pairs").setup({})
      require("mini.bracketed").setup({})
      require("mini.splitjoin").setup({})
    end,
  },
}
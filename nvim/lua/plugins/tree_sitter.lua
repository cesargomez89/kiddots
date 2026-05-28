return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    dependencies = { "neovim-treesitter/treesitter-parser-registry" },
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install {
        "go",
        "ruby",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "yaml",
        "toml",
      }
    end,
  }
}

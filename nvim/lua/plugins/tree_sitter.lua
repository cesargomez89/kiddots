local parsers = {
  "go",
  "ruby",
  "javascript",
  "typescript",
  "html",
  "css",
  "json",
  "yaml",
  "toml",
  "lua",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = function()
      require("nvim-treesitter").install(parsers)
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = parsers,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  }
}

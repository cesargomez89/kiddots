return {
  "mrjones2014/smart-splits.nvim",
  -- must not be lazy loaded: the kitty backend needs it to set IS_NVIM on startup
  lazy = false,
  dependencies = {
    { "smart-splits-nvim/backend-kitty", main = "smart-splits-backend-kitty" },
  },
  opts = {
    mux = { backend = "smart-splits-backend-kitty" },
  },
  keys = {
    { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move left a Split", mode = { "n" } },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move down a Split", mode = { "n" } },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move up a Split", mode = { "n" } },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move right a Split", mode = { "n" } },
  },
}

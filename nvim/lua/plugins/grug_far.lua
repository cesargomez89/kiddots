return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    { "<leader>S", function() require("grug-far").open() end, desc = "Grug far: search & replace in project" },
    {
      "<leader>Sw",
      function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end,
      desc = "Grug far: replace word under cursor",
    },
  },
  opts = {},
}

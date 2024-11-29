return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
      enable_cmp_source = true,
      virtual_text = {
        enabled = true,
        key_bindings = {
          accept = "<Tab>",
        }
      },
    })

    require('codeium.virtual_text').set_statusbar_refresh(function()
      require('lualine').refresh()
    end)
  end
}

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
    {
      'nvim-pack/nvim-spectre',
      config = function()
        local spectre = require('spectre')

        spectre.setup()

        vim.keymap.set('n', '<leader>S', spectre.open, { desc = 'Spectre: search & replace in project' })
        vim.keymap.set('n', '<leader>Sw', function()
          spectre.open_visual({ select_word = true })
        end, { desc = 'Spectre: replace word under cursor' })
      end
    },
  },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
  end
}

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true

vim.api.nvim_set_keymap('v', '<S-y>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-y>', 'v"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '0', '^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '$', 'g_', { noremap = true, silent = true })

vim.cmd([[
  cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
]])

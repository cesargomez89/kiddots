vim.opt.updatetime = 1500

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true

vim.keymap.set('v', '<S-y>', '"+y', { silent = true })
vim.keymap.set('n', '<S-y>', 'v"+y', { silent = true })
vim.keymap.set('n', '0', '^', { silent = true })
vim.keymap.set('n', '$', 'g_', { silent = true })

vim.cmd([[
  cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
]])

vim.keymap.set('n', 'yp', function()
  vim.fn.setreg('+', vim.fn.expand('%') .. ':' .. vim.fn.line('.'))
end, { silent = true })

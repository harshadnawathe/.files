-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.g.mapleader = " "
vim.g.autoformat = false

vim.opt.colorcolumn = "120"
vim.opt.cursorcolumn = false
vim.opt.cursorline = false
vim.opt.number = true
vim.opt.spell = false
vim.opt.wrap = false

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

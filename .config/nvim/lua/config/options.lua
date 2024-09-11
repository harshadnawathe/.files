-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.g.mapleader = " "
vim.g.autoformat = false
vim.g.loaded_netrwPlugin = 0
vim.g.trouble_lualine = true

vim.o.shell = "/opt/homebrew/bin/fish"

vim.opt.colorcolumn = "120"
vim.opt.cursorcolumn = false
vim.opt.cursorline = false
vim.opt.number = true
vim.opt.spell = false
vim.opt.wrap = false

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldmethod = 'expr'

-- Lazy extra - Python
--
-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "pyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.g.autoformat = false
vim.g.trouble_lualine = true

-- `shell` is left at the system default on purpose: it backs :!, :make, system()
-- and plugin job control, much of which emits POSIX-only syntax. fish is set for
-- the interactive terminal instead, in the snacks spec.

vim.opt.colorcolumn = "120"

vim.g.lazyvim_python_lsp = "basedpyright"

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.g.autoformat = false
vim.g.trouble_lualine = true

-- `shell` is left at the system default on purpose: it backs :!, :make, system()
-- and plugin job control. That default is now the same zsh the snacks terminal
-- opens, so `:!` and the terminal finally agree on a shell -- they did not while
-- the terminal was overridden to fish.

vim.o.winborder = "rounded"

vim.g.lazyvim_python_lsp = "basedpyright"

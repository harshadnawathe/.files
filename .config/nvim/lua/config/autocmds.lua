-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Colorcolumn only in real file buffers, so it doesn't paint in terminals,
-- help, Trouble, the dashboard and other special windows.
-- TermOpen is needed as well: :terminal sets buftype after BufWinEnter fires.
vim.api.nvim_create_autocmd({ "BufWinEnter", "TermOpen" }, {
  group = vim.api.nvim_create_augroup("colorcolumn", { clear = true }),
  callback = function(ev)
    vim.opt_local.colorcolumn = vim.bo[ev.buf].buftype == "" and "120" or ""
  end,
})

-- Toggle between a Go source file and its test file (replaces go.nvim's :GoAlt).
-- Buffer-local so it doesn't leak into other filetypes that use <leader>t<CR>.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("go_alt", { clear = true }),
  pattern = "go",
  callback = function(ev)
    vim.keymap.set("n", "<leader>t<CR>", function()
      local file = vim.api.nvim_buf_get_name(ev.buf)
      local alt = file:match("_test%.go$") and (file:gsub("_test%.go$", ".go")) or (file:gsub("%.go$", "_test.go"))
      vim.cmd.edit(vim.fn.fnameescape(alt))
    end, { buffer = ev.buf, desc = "Switch test/code (Go)" })
  end,
})

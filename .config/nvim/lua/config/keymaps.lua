-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local keymap = vim.keymap

-- Increment/decrement
keymap.set("n", "+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" })

-- Resize window
keymap.set("n", "<Cw>left", "<C-w><")
keymap.set("n", "<C-w>right", "<C-w>>")
keymap.set("n", "<C-w>up", "<C-w>+")
keymap.set("n", "<C-w>down", "<C-w>-")

-- Resize window using <option> arrow keys (repeatable)
keymap.set("n", "<A-Up>", "<cmd>resize -2<cr>", { desc = "Increase window height" })
keymap.set("n", "<A-Down>", "<cmd>resize +2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Select all (press twice if C-a is tmux prefix)
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Helix like moves 
keymap.set("n", "gh", "^", {desc = "Move to start", remap = true})
keymap.set("n", "gl", "$", {desc = "Move to end", remap = true})

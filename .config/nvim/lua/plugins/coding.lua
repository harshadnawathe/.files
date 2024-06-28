return {
  {
    "Exafunction/codeium.nvim",
    cond = function()
      return vim.env.DISABLE_CODEIUM == nil
    end,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      { "<leader>%", ":TSJToggle<CR>", desc = "args: Split or Join" },
    },
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gSa", -- Add surrounding in Normal and Visual modes
        delete = "gSd", -- Delete surrounding
        find = "gSf", -- Find surrounding (to the right)
        find_left = "gSF", -- Find surrounding (to the left)
        highlight = "gSh", -- Highlight surrounding
        replace = "gSr", -- Replace surrounding
        update_n_lines = "gSn", -- Update `n_lines`
      },
    },
  },
}

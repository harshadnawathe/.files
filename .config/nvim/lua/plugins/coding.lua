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
}

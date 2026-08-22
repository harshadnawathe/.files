return {
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      { "<leader>cj", "<cmd>TSJToggle<cr>", desc = "Split or Join args" },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<Tab>"] = {
          function(cmp)
            return cmp.snippet_active() and cmp.accept() or cmp.select_next()
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            return cmp.snippet_active() and cmp.accept() or cmp.select_prev()
          end,
          "snippet_backward",
          "fallback",
        },
      },
    },
  },
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "ast-grep",
      },
    },
  },
}

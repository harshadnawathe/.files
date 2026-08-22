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
        -- Inside a snippet Tab jumps placeholders, otherwise it walks the menu.
        -- The direction filter matters: a bare snippet_active() is still true on
        -- the last placeholder, where there is nothing left to jump to.
        ["<Tab>"] = {
          function(cmp)
            return cmp.snippet_active({ direction = 1 }) and cmp.snippet_forward() or cmp.select_next()
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            return cmp.snippet_active({ direction = -1 }) and cmp.snippet_backward() or cmp.select_prev()
          end,
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

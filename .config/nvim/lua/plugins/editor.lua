return {

  --   "dinhhuy258/git.nvim",
  --   event = "BufReadPre",
  --   opts = {
  --     default_mappings = false,
  --   },
  --   keys = {
  --     { "<leader>gp", "<CMD>lua require('git.browse').pull_request()<CR>", desc = "Open pull request" },
  --     { "<leader>gP", "<CMD>lua require('git.browse').create_pull_request()<CR>", desc = "Create new pull request" },
  --   },
  -- },
  {
    "tpope/vim-rsi",
  },
  {
    "folke/flash.nvim",
    keys = {
      {
        "<A-S-k>",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter({
            -- flash reads keys with getcharstr(), so these have to be declared
            -- here rather than remapped. <c-space>/<BS> stay as a fallback in
            -- case the terminal encodes <A-S-k> differently.
            actions = {
              ["<A-S-k>"] = "next",
              ["<A-S-j>"] = "prev",
              ["<c-space>"] = "next",
              ["<BS>"] = "prev",
            },
          })
        end,
        desc = "Incremental selection",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    dependencies = {
      "mason.nvim",
      opts = {
        ensure_installed = {
          "xmlformatter",
        },
      },
    },
    opts = {
      formatters_by_ft = {
        xml = { "xmlformatter" },
      },
    },
  },
}

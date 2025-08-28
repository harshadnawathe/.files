return {
  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      default_mappings = false,
    },
    keys = {
      { "<leader>gp", "<CMD>lua require('git.browse').pull_request()<CR>", desc = "Open pull request" },
      { "<leader>gP", "<CMD>lua require('git.browse').create_pull_request()<CR>", desc = "Create new pull request" },
    },
  },
  {
    "tpope/vim-rsi",
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

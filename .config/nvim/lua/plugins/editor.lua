return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        hijack_netrw_behavior = "open_current",
      },
    },
  },
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
    "ibhagwan/fzf-lua",
    opts = {
      grep = {
        rg_glob = true,
      },
    },
  },
}

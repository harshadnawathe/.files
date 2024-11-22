return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        filesystem = {
          hijack_netrw_behavior = "open_current",
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        pickers = {
          yank_history = {
            theme = "dropdown",
            previewer = false,
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
          },
          find_files = {
            theme = "dropdown",
            previewer = false,
          },
          git_files = {
            theme = "dropdown",
            previewer = false,
          },
          diagnostics = {
            theme = "ivy",
            layout_config = {
              height = 0.3,
            },
          },
          lsp_references = {
            theme = "ivy",
            layout_config = {
              height = 0.3,
            },
          },
        },
      })
    end,
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
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function(_, opts)
      local harpoon = require("harpoon")
      harpoon:setup(opts)

      local extensions = require("harpoon.extensions")
      harpoon:extend(extensions.builtins.navigate_with_number())
    end,
  },
}

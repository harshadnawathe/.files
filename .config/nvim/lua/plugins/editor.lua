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
      local actions = require("telescope.actions")
      return vim.tbl_deep_extend("force", opts, {
        defaults = {
          path_display = { "smart" },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
        pickers = {
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
            initial_mode = "normal",
            layout_config = {
              height = 0.3,
            },
          },
          lsp_references = {
            theme = "ivy",
            initial_mode = "normal",
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
      { "<leader>gB", "<CMD>lua require('git.blame').blame()<CR>", desc = "Open Git Blame" },
      { "<leader>gO", "<CMD>lua require('git.browse').open(false)<CR>", desc = "Open repo in browser" },
      { "<leader>gO", ":<C-u> lua require('git.browse').open(false)<CR>", desc = "Open repo in browser", mode = "x" },
      { "<leader>gP", "<CMD>lua require('git.browse').create_pull_request()<CR>", desc = "Create new pull request" },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = true,
  },
  {
    "tpope/vim-rsi",
  },
  {
    "folke/edgy.nvim",
    opts = {
      wo = {
        winfixwidth = false,
      },
      keys = {
        -- increase width
        ["<A-Right>"] = function(win)
          win:resize("width", 2)
        end,
        -- decrease width
        ["<A-Left>"] = function(win)
          win:resize("width", -2)
        end,
        -- increase height
        ["<A-Up>"] = function(win)
          win:resize("height", 2)
        end,
        -- decrease height
        ["<A-Down>"] = function(win)
          win:resize("height", -2)
        end,
      },
    },
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

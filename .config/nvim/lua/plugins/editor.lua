local Util = require("lazyvim.util")

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
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>fe", false },
      { "<leader>fE", false },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>?",
        "<leader>sG",
        desc = "Grep (cwd)",
        remap = true,
      },
      {
        "<leader>;",
        "<leader>sR",
        desc = "Resume last Telescope search",
        remap = true,
      },
    },
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
    "stevearc/oil.nvim",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      default_file_explorer = false,
      view_options = {
        show_hidden = true,
      },
      float = {
        override = function(conf)
          conf.row = conf.row + math.floor(conf.height * 0.15)
          conf.col = conf.col + math.floor(conf.width * 0.15)
          conf.width = math.floor(conf.width * 0.7)
          conf.height = math.floor(conf.height * 0.7)
          return conf
        end,
      },
      keymaps = {
        ["<ESC>"] = "actions.close",
        ["<C-s>"] = false,
        ["<C-h>"] = false,
      },
    },
    keys = {
      {
        "<leader>fe",
        function()
          require("oil").toggle_float(Util.root())
        end,
        desc = "Explorer (root dir)",
      },
      {
        "<leader>fE",
        function()
          require("oil").toggle_float()
        end,
        desc = "Explorer (cwd)",
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
}

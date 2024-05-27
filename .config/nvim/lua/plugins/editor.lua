local Util = require("lazyvim.util")

return {
  {
    "stevearc/aerial.nvim",
    keys = {
      {
        "<leader>cS",
        "<cmd>AerialToggle!<cr>",
        desc = "Document symbols view",
      },
    },
  },
  { "max397574/better-escape.nvim", event = "InsertCharPre", opts = { timeout = 300 } },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        filesystem = {
          hijack_netrw_behavior = "open_current",
        },
        window = {
          position = "right",
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
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "stevearc/aerial.nvim",
    },
    keys = {
      { "<leader>/", false },
      { "<leader>?", ":Telescope live_grep<cr>", desc = "Grep (root dir)", silent = true },
      {
        "<leader>sf",
        "<cmd>Telescope file_browser<cr>",
        desc = "Explorer Telescope (root dir)",
      },
      {
        "<leader>sF",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
        desc = "Explorer Telescope (cwd)",
      },
      {
        "<leader>s/",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Find in buffer",
      },
      {
        "<leader>cs",
        "<cmd>Telescope aerial<cr>",
        desc = "Search code symbols",
      },
      {
        "<leader>;",
        "<cmd>Telescope resume<cr>",
        desc = "Resume last Telescope search",
      },
    },
    opts = function(_, opts)
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("aerial")

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
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>fe",
        function()
          require("oil").open_float(Util.root())
        end,
        desc = "Explorer (root dir)",
      },
      {
        "<leader>fE",
        function()
          require("oil").open_float()
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
}

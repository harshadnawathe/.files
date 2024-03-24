local Util = require("lazyvim.util")

return {
  {
    "stevearc/aerial.nvim",
    opts = {
      buftype_exclude = {
        "nofile",
        "terminal",
      },
      filetype_exclude = {
        "help",
        "startify",
        "aerial",
        "alpha",
        "dashboard",
        "lazy",
        "neogitstatus",
        "NvimTree",
        "neo-tree",
        "Trouble",
      },
      context_patterns = {
        "class",
        "return",
        "function",
        "method",
        "^if",
        "^while",
        "jsx_element",
        "^for",
        "^object",
        "^table",
        "block",
        "arguments",
        "if_statement",
        "else_clause",
        "jsx_element",
        "jsx_self_closing_element",
        "try_statement",
        "catch_clause",
        "import_statement",
        "operation_type",
      },
      filter_kind = {
        "Array",
        "Class",
        "Constant",
        "Constructor",
        "Enum",
        "EnumMember",
        "Field",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Namespace",
        "Object",
        "Property",
        "Struct",
        "Variable",
      },
      show_trailing_blankline_indent = false,
      use_treesitter = true,
      char = "▏",
      context_char = "▏",
      show_current_context = true,
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
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
    },
    opts = function(_, opts)
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("aerial")

      local actions = require("telescope.actions")
      return vim.tbl_deep_extend("force", opts, {
        defaults = {
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
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
        ["<ESC>"] = "actions.close"
      }
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
      keymaps = {
        -- Open blame window
        blame = "<leader>gb",
        -- Open file/folder in git repository
        browse = "<leader>go",
      },
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = true,
  },
  {
    "tpope/vim-rsi",
  },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        options = {
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "█", right = "█" },
        },
      })
    end,
  },
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = {
              default = true,
              group = "StatusLine",
            },
            InclineNormalNC = {
              default = true,
              group = "StatusLineNC",
            },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      opts.config.header = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 10,
      open_mapping = [[<F7>]],
      shading_factor = 2,
      direction = "float",
      float_opts = {
        border = "curved",
        highlights = { border = "Normal", background = "Normal" },
      },
    },
    keys = {
      {
        "<leader>$",
        desc = "+terminal [F7]",
      },
      {
        "<leader>$f",
        "<cmd>ToggleTerm direction=float<cr>",
        desc = "ToggleTerm float",
      },
      {
        "<leader>$h",
        "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
        desc = "ToggleTerm horizontal split",
      },
      {
        "<leader>$v",
        "<cmd>ToggleTerm size=80 direction=vertical<cr>",
        desc = "ToggleTerm vertical split",
      },
    },
  },
}

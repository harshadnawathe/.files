return {
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
      local transparent = require("transparent")
      transparent.setup({
        extra_groups = {
          "NormalFloat",
          "NvimTreeNormal",
        },
      })
      transparent.clear_prefix("BufferLine")
      transparent.clear_prefix("NeoTree")
      -- transparent.clear_prefix("lualine")
    end,
    keys = {
      {
        "<leader>uB",
        "<Cmd>TransparentToggle<CR>",
        desc = "Toggle background transparency",
      },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "light",
        percentage = 0.9, -- percentage of the shade to apply to the inactive window
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}

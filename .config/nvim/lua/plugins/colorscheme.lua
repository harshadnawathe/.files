return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        dim_inactive = {
          enabled = true, -- dims the background color of inactive window
          shade = "light",
          percentage = 0.9, -- percentage of the shade to apply to the inactive window
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}

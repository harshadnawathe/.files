return {
  "mellow-theme/mellow.nvim",
  "EdenEast/nightfox.nvim",
  {
    "craftzdog/solarized-osaka.nvim",
    opts = {
      transparent = false,
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

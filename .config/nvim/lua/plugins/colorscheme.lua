return {
  -- LazyVim ships catppuccin by default.
  { "catppuccin/nvim", name = "catppuccin", enabled = false },
  {
    "folke/tokyonight.nvim",
    opts = {
      dim_inactive = true,
    },
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    -- Loaded on demand: lazy.nvim's ColorSchemePre handler pulls this in when
    -- `:colorscheme zenbones` runs, so it costs nothing until then.
    lazy = true,
    -- you can set set configuration options here
    -- config = function()
    --     vim.g.zenbones_darken_comments = 45
    --     vim.cmd.colorscheme('zenbones')
    -- end
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}

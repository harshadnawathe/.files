return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "latex", "svelte", "typst", "vue" } }, -- required for snacks.image
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "mmdc", "tectonic" } }, -- required for snacks.image
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>fz",
        function()
          Snacks.picker.zoxide()
        end,
        desc = "Zoxide directories",
      },
    },
    opts = {
      image = {
        enabled = true,
      },
      statuscolumn = {
        enabled = true,
        folds = {
          open = true,
        },
      },
      picker = {
        sources = {
          explorer = {
            layout = {
              layout = {
                position = "right",
              },
            },
          },
        },
      },
      terminal = {
        shell = "/opt/homebrew/bin/fish",
        win = {
          keys = {
            nav_h = false,
            nav_j = false,
            nav_k = false,
            nav_l = false,
          },
        },
      },
      words = {
        enabled = true,
      },
    },
  },
}

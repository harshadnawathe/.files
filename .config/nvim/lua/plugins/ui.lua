return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "█", right = "█" },
      },
    },
  },
  {
    -- Sticky header showing the enclosing function/class.
    -- Mirrors lazyvim.plugins.extras.ui.treesitter-context; kept as a plain spec
    -- so it lives alongside the other UI tweaks.
    "nvim-treesitter/nvim-treesitter-context",
    event = "LazyFile",
    opts = function()
      local tsc = require("treesitter-context")
      Snacks.toggle({
        name = "Treesitter Context",
        get = tsc.enabled,
        set = function(state)
          if state then
            tsc.enable()
          else
            tsc.disable()
          end
        end,
      }):map("<leader>ut")
      return { mode = "cursor", max_lines = 3 }
    end,
  },
  {
    "b0o/incline.nvim",
    event = "LazyFile",
    dependencies = { "nvim-mini/mini.icons" },
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
          local icon, color = require("mini.icons").get("file", filename)

          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          return { { icon, group = color }, { " " }, { filename } }
        end,
      })
    end,
  },
}

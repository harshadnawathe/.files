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
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    dependencies = { "echasnovski/mini.icons" },
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

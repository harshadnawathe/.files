local Util = require("lazyvim.util")

return {
  {
    "stevearc/conform.nvim",
    enabled = false,
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        -- xml/html
        nls.builtins.formatting.tidy,
        nls.builtins.formatting.xmllint,
        nls.builtins.diagnostics.tidy,
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = {
      ensure_installed = {
        -- lua
        "stylua",
        -- java formatter
        "google_java_format",
        -- golang formatters and lsp tools
        "gomodifytags",
        "gofumpt",
        "iferr",
        "impl",
        "goimports",
        "golangci_lint",
        -- json formatter
        "prettierd",
        -- typescript and javascript linting
        "eslint",
        -- c++
        "clang_format",
        -- kotlin
        "ktlint",
        -- shell
        "shellcheck",
      },
      automatic_installation = false,
      handlers = {
        ktlint = function()
          local nls = require("null-ls")
          local editorConfigPath = Util.root() .. ".editorconfig"
          nls.register(nls.builtins.diagnostics.ktlint.with({
            args = { "--log-level=none", "--relative", "--reporter=json", "**/*.kt", "**/*.kts" },
          }))
          nls.register(nls.builtins.formatting.ktlint.with({
            args = { "--log-level=none", "--format", "--stdin", "**/*.kt", "**/*.kts" },
          }))
        end,
      },
    },
    config = true,
    cmd = { "NoneLsInstall", "NoneLsUninstall" },
  },
}

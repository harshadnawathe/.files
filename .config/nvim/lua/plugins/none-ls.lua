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
        -- java formatter
        "google_java_format",
        -- golang formatters and lsp tools
        "golines",
        "iferr",
        "golangci_lint",
        -- c++
        "clang_format",
      },
      automatic_installation = false,
      handlers = {
        ktlint = function()
          local nls = require("null-ls")
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

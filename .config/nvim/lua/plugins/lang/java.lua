return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    opts = function(_, opts)
      -- java executable option for projects using JDK version older than 17
      table.insert(opts.cmd, "--java-executable=" .. vim.fn.expand("$HOME/.local/share/mise/installs/java/25/bin/java"))

      return vim.tbl_deep_extend("force", opts, {
        -- custom on_attach hook to register additional options
        on_attach = function()
          local wk = require("which-key")
          wk.add({
            {
              "<leader>tg",
              function()
                require("jdtls.tests").generate()
              end,
              desc = "Generate tests (JDTLS)",
            },
            {
              "<leader>t<CR>",
              function()
                require("jdtls.tests").goto_subjects()
              end,
              desc = "Goto subjects",
            },
          })
        end,
      })
    end,
  },
}

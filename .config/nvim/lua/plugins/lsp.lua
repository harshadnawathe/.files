return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    opts = function(_, opts)
      -- java executable option for projects using JDK version older than 17
      table.insert(opts.cmd, "--java-executable=" .. vim.fn.expand("$HOME/.local/share/mise/installs/java/21/bin/java"))

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
              "<leader>ts",
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
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    opts = {
      diagnostic = false,
    },
    config = function(_, opts)
      require("go").setup(opts)

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "gopls" then
            local wk = require("which-key")
            wk.add({
              { "<leader>cg", group = "generate" },
              { "<leader>cgc", ":GoFillSwitch<CR>", desc = "Fill switch (Go)" },
              { "<leader>cgd", ":GoCmt<CR>", desc = "Documentation comment (Go)" },
              { "<leader>cge", ":GoIfErr<CR>", desc = "If Err (Go)" },
              {
                "<leader>cgi",
                function()
                  vim.ui.input({ prompt = "Interface to implement: " }, function(input)
                    vim.cmd(":GoImpl " .. input)
                  end)
                end,
                desc = "Implment Interface (Go)",
              },
              { "<leader>cgp", ":GoFixPlurals<CR>", desc = "Fix Plurals (Go)" },
              { "<leader>cgr", ":GoGenReturn<CR>", desc = "Return Value (Go)" },
              { "<leader>cgs", ":GoFillStruct<CR>", desc = "Auto fill struct Value (Go)" },
              { "<leader>t", group = "test" },
              { "<leader>tT", ":GoTestFunc -s<CR>", desc = "Run Test (Go)" },
              { "<leader>tg", ":GoAddTest<CR>", desc = "Generate Test (Go)" },
              { "<leader>tr", ":GoTestFunc<CR>", desc = "Run Nearest Test (Go)" },
              { "<leader>ts", ":GoAlt<CR>", desc = "Goto Subjects (Go)" },
              { "<leader>tt", ":GoTestFile -v<CR>", desc = "Run All Test (Go)" },
            })
          end
        end,
      })
    end,
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<leader>cl", false }
      keys[#keys + 1] = { "<leader>cli", "<cmd>LspInfo<cr>", desc = "Lsp Info" }

      local wk = require("which-key")
      wk.register({
        ["<leader>cl"] = { name = "lsp" },
      })
    end,
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        format = {
          -- ktlint is slow
          timeout_ms = 3000,
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      registries = {
        "github:nvim-java/mason-registry",
        "github:mason-org/mason-registry",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        -- html & css
        "html",
        "cssls",
        "emmet_ls",
        -- angular
        "angularls",
        -- typescript & javascript
        "eslint",
        -- kotlin
        "kotlin_language_server",
        -- shell
        "bashls",
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- override jdtls command to work with projects using jdks older than 17
      return vim.tbl_deep_extend("force", opts, {
        cmd = {
          vim.fn.expand("$HOME/.local/share/mise/installs/java/17/bin/java"),
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dosgi.checkConfiguration=true",
          "-Dosgi.sharedConfiguration.area=" .. vim.fn.expand("$MASON/share/jdtls/config"),
          "-Dosgi.sharedConfiguration.area.readOnly=true",
          "-Dosgi.configuration.cascaded=true",
          "-Xms1G",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          vim.fn.expand("$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
        },
        on_attach = function()
          vim.keymap.set("n", "<leader>tg", function()
            require("jdtls.tests").generate()
          end, { desc = "Generate tests" })
          vim.keymap.set("n", "<leader>ts", "gS", { desc = "Goto Subjects", remap = true })
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
    config = function()
      require("go").setup()

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "gopls" then
            local wk = require("which-key")
            wk.register({
              ["gS"] = { ":GoAlt<CR>", "Goto Subjects" },
              ["<leader>t"] = {
                name = "+test",
                t = { ":GoTestFile -v<CR>", "Run All Test (Go)" },
                r = { ":GoTestFunc<CR>", "Run Nearest Test (Go)" },
                T = { ":GoTestFunc -s<CR>", "Run Test (Go)" },
                s = { "gS", "Goto Subjects (Go)", remap = true },
                g = { ":GoAddTest<CR>", "Generate Test (Go)" },
              },
              ["<leader>cg"] = {
                name = "+generate",
                s = { ":GoFillStruct<CR>", "Auto fill struct Value (Go)" },
                e = { ":GoIfErr<CR>", "If Err (Go)" },
                r = { ":GoGenReturn<CR>", "Return Value (Go)" },
                c = { ":GoFillSwitch<CR>", "Fill switch (Go)" },
                d = { ":GoCmt<CR>", "Documentation comment (Go)" },
                p = { ":GoFixPlurals<CR>", "Fix Plurals (Go)" },
                i = {
                  function()
                    vim.ui.input({ prompt = "Interface to implement: " }, function(input)
                      vim.cmd(":GoImpl " .. input)
                    end)
                  end,
                  "Implment Interface (Go)",
                },
              },
            })
          end
        end,
      })
    end,
  },
}

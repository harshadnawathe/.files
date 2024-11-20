return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<leader>cl", false }
      keys[#keys + 1] = { "<leader>cli", "<cmd>LspInfo<cr>", desc = "Lsp Info" }

      local wk = require("which-key")
      wk.add({
        { "<leader>cl", group = "lsp" },
      })
    end,
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        format = {
          -- ktlint is slow
          timeout_ms = 3000,
        },
        setup = {
          rust_analyzer = function()
            -- lsp configuration is managed by rustaceanvim
            return true
          end,
          jdtls = function()
            -- lsp configuration is managed by nvim-jdtls
            return true
          end,
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        registries = {
          "github:nvim-java/mason-registry",
          "github:mason-org/mason-registry",
        },
        ensure_installed = {
          "json-lsp",
          "markdownlint-cli2",
          "pyright",
          "ruff",
        },
      })
    end,
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
        -- go
        "gopls",
        -- lua
        "lua_ls",
        -- rust
        "rust_analyzer",
        --java
        "jdtls",
        --toml
        "taplo",
        --yaml
        "yamlls",
        --xml
        "lemminx",
        --cpp
        "clangd",
      },
      handlers = {
        ["rust_analyzer"] = function()
          -- lsp configuration is managed by rustaceanvim
        end,
        ["jdtls"] = function()
          -- lsp configuration is managed by nvim-jdtls
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    opts = function(_, opts)
      -- override jdtls command to work with projects using jdks older than 17
      return vim.tbl_deep_extend("force", opts, {
        cmd = {
          vim.fn.exepath("jdtls"),
          "--java-executable=" .. vim.fn.expand("$HOME/.local/share/mise/installs/java/21/bin/java"),
          string.format("--jvm-arg=-javaagent:%s", vim.fn.expand("$MASON/share/jdtls/lombok.jar")),
        },
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

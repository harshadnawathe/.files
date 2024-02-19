return {
  {
    "Exafunction/codeium.nvim",
    cond = function()
      return vim.env.DISABLE_CODEIUM == nil
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cond = function()
      return vim.env.ENABLE_COPILOT ~= nil
    end,
  },
  {
    "echasnovski/mini.comment",
    keys = {
      {
        "<leader>/",
        "gcc",
        mode = "n",
        desc = "Comment line",
        remap = true,
      },
      {
        "<leader>/",
        "gc",
        mode = "x",
        desc = "Comment selection",
        remap = true,
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {
        {
          "<C-L>",
          function()
            local ls = require("luasnip")
            if ls.choice_active() then
              ls.change_choice(1)
            end
          end,
          mode = { "i", "s" },
          desc = "LuaSnip: select next choice",
        },
        {
          "<C-H>",
          function()
            local ls = require("luasnip")
            if ls.choice_active() then
              ls.change_choice(-1)
            end
          end,
          mode = { "i", "s" },
          desc = "LuaSnip: select previous choice",
        },
      }
    end,
    init = function()
      local nvim_config_path = vim.fn.stdpath("config") .. "/snippets"
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { nvim_config_path .. "/vscode/" } })
      require("luasnip.loaders.from_lua").lazy_load({ paths = { nvim_config_path .. "/lua/" } })

      vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "*",
        callback = function()
          if
            ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
            and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
    },
    init = function()
      local cmp = require("cmp")

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      })
    end,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      { "<leader>%", ":TSJToggle<CR>", desc = "args: Split or Join" },
    },
  },
  -- Incremental rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      lightbulb = {
        enable = false,
      },
      beacon = {
        enable = false,
      },
      code_action = {
        show_server_name = true,
      },
      callhierarchy = {
        layout = "normal",
      },
      finder = {
        layout = "normal",
      },
    },
    keys = function()
      local wk = require("which-key")
      wk.register({
        ["]D"] = { ":Lspsaga diagnostic_jump_next<CR>", "Next diagnostic action (Lspsaga)" },
        ["[D"] = { ":Lspsaga diagnostic_jump_prev<CR>", "Next diagnostic action (Lspsaga)" },
        ["<leader>cl"] = {
          f = { ":Lspsaga finder<CR>", "Find references (Lspsaga)" },
          o = { ":Lspsaga outgoing_calls<CR>", "Outgoing calls (Lspsaga)" },
          S = { ":Lspsaga outline<CR>", "Document outline (Lspsaga)" },
        },
      })
    end,
  },
}

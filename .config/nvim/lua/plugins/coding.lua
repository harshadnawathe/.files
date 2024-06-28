return {
  {
    "Exafunction/codeium.nvim",
    cond = function()
      return vim.env.DISABLE_CODEIUM == nil
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
    opts = function(_, _)
      -- register custom snippets
      local nvim_config_path = vim.fn.stdpath("config") .. "/snippets"
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { nvim_config_path .. "/vscode/" } })
      require("luasnip.loaders.from_lua").lazy_load({ paths = { nvim_config_path .. "/lua/" } })
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

      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
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
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gSa", -- Add surrounding in Normal and Visual modes
        delete = "gSd", -- Delete surrounding
        find = "gSf", -- Find surrounding (to the right)
        find_left = "gSF", -- Find surrounding (to the left)
        highlight = "gSh", -- Highlight surrounding
        replace = "gSr", -- Replace surrounding
        update_n_lines = "gSn", -- Update `n_lines`
      },
    },
  },
}

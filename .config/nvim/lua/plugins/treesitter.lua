return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts, {
      ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "groovy",
        -- html & css support
        "html",
        "css",
        -- angular support
        "angular",
        -- kotlin support
        "kotlin",
        "latex",
      }),
      textobjects = {
        select = {
          keymaps = {
            ["a="] = { query = "@assignment.outer", desc = "around assignment" },
            ["i="] = { query = "@assignment.inner", desc = "inside assignment" },
            ["ai"] = { query = "@call.outer", desc = "around function call" },
            ["ii"] = { query = "@call.inner", desc = "inside function call" },
            ["ak"] = { query = "@block.outer", desc = "around block" },
            ["ik"] = { query = "@block.inner", desc = "inside block" },
            ["ac"] = { query = "@class.outer", desc = "around class" },
            ["ic"] = { query = "@class.inner", desc = "inside class" },
            ["a?"] = { query = "@conditional.outer", desc = "around conditional" },
            ["i?"] = { query = "@conditional.inner", desc = "inside conditional" },
            ["af"] = { query = "@function.outer", desc = "around function " },
            ["if"] = { query = "@function.inner", desc = "inside function " },
            ["al"] = { query = "@loop.outer", desc = "around loop" },
            ["il"] = { query = "@loop.inner", desc = "inside loop" },
            ["aa"] = { query = "@parameter.outer", desc = "around argument" },
            ["ia"] = { query = "@parameter.inner", desc = "inside argument" },
          },
        },
        move = {
          goto_next_start = {
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
            ["]i"] = { query = "@call.outer", desc = "Next function call start" },
            ["]?"] = { query = "@conditional.outer", desc = "Next conditional start" },
            ["]k"] = { query = "@block.outer", desc = "Next block start" },
            ["]f"] = { query = "@function.outer", desc = "Next function start" },
            ["]a"] = { query = "@parameter.inner", desc = "Next argument start" },
          },
          goto_next_end = {
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]I"] = { query = "@call.outer", desc = "Next function call end" },
            ["]K"] = { query = "@block.outer", desc = "Next block end" },
            ["]F"] = { query = "@function.outer", desc = "Next function end" },
            ["]A"] = { query = "@parameter.inner", desc = "Next argument end" },
          },
          goto_previous_start = {
            ["[c"] = { query = "@class.outer", desc = "Previous class start" },
            ["[i"] = { query = "@call.outer", desc = "Previous function call start" },
            ["[?"] = { query = "@conditional.inner", desc = "Previous conditional start" },
            ["[k"] = { query = "@block.outer", desc = "Previous block start" },
            ["[f"] = { query = "@function.outer", desc = "Previous function start" },
            ["[a"] = { query = "@parameter.inner", desc = "Previous argument start" },
          },
          goto_previous_end = {
            ["[C"] = { query = "@class.outer", desc = "Previous class end" },
            ["[I"] = { query = "@call.outer", desc = "Previous function call end" },
            ["[K"] = { query = "@block.outer", desc = "Previous block end" },
            ["[F"] = { query = "@function.outer", desc = "Previous function end" },
            ["[A"] = { query = "@parameter.inner", desc = "Previous argument end" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            [">K"] = { query = "@block.outer", desc = "Swap next block" },
            [">F"] = { query = "@function.outer", desc = "Swap next function" },
            [">A"] = { query = "@parameter.inner", desc = "Swap next argument" },
          },
          swap_previous = {
            ["<K"] = { query = "@block.outer", desc = "Swap previous block" },
            ["<F"] = { query = "@function.outer", desc = "Swap previous function" },
            ["<A"] = { query = "@parameter.inner", desc = "Swap previous argument" },
          },
        },
      },
    })
  end,
  keys = function()
    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
    return {
      { ";", ts_repeat_move.repeat_last_move_next, mode = { "n", "x", "o" } },
      { ",", ts_repeat_move.repeat_last_move_previous, mode = { "n", "x", "o" } },
    }
  end,
}

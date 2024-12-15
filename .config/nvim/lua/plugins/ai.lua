return {
  {
    "Exafunction/codeium.nvim",
    cond = function()
      return vim.env.DISABLE_CODEIUM == nil
    end,
  },
}

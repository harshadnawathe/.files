return {
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>Rc", "", desc = "+curl" },
      {
        "<leader>Rci",
        "<cmd>lua require('kulala').from_curl()<cr>",
        {
          noremap = true,
          silent = true,
        },
        desc = "Paste curl from clipboard as http request",
      },
      {
        "<leader>Rco",
        "<cmd>lua require('kulala').copy()<cr>",
        {
          noremap = true,
          silent = true,
        },
        desc = "Copy the current request as a curl command",
      },
    },
  },
}

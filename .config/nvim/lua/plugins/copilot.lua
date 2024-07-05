return {
  {
    "zbirenbaum/copilot.lua",
    version = "2.8.0",
    cond = function()
      return vim.env.ENABLE_COPILOT ~= nil
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      prompts = {
        Refactor = {
          prompt = "Please refactor the following code to improve its clarity and readability.",
        },
        BetterNamings = {
          prompt = "Please provide better names for the following variables and functions.",
        },
        SwaggerApiDocs = {
          prompt = "Please provide documentation for the following API using Swagger.",
        },
        SwaggerJsDocs = {
          prompt = "Please write JSDoc for the following API using Swagger.",
        },
        Summarize = {
          prompt = "Please summarize the following text.",
        },
        Spelling = {
          prompt = "Please correct any grammar and spelling errors in the following text.",
        },
        Wording = {
          prompt = "Please improve the grammar and wording of the following text.",
        },
        Concise = {
          prompt = "Please rewrite the following text to make it more concise.",
        },
        Tests = {
          prompt = "/COPILOT_GENERATE Please explain how the selected code works, then generate unit tests for it.",
        }
      },
    },
    cond = function()
      return vim.env.ENABLE_COPILOT ~= nil
    end,
    keys = {
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code", mode = { "n", "x" } },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests", mode = { "n", "x" } },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code", mode = { "n", "x" } },
      { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code", mode = { "n", "x" } },
      {
        "<leader>am",
        "<cmd>CopilotChatCommit<cr>",
        desc = "CopilotChat - Generate commit message for all changes",
      },
      {
        "<leader>aM",
        "<cmd>CopilotChatCommitStaged<cr>",
        desc = "CopilotChat - Generate commit message for staged changes",
      },
      { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
    },
  },
}

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
    version = "v2.8.0",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
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
      window = {
        width = 0.3,
      },
    },
    commands = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatClose",
      "CopilotChatToggle",
      "CopilotChatStop",
      "CopilotChatReset",
      "CopilotChatSave",
      "CopilotChatLoad",
    },
    cond = function()
      return vim.env.ENABLE_COPILOT ~= nil
    end,
    keys = {
      { "<leader>cp", desc = "Copilot" },
      {
        "<leader>cpq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      {
        "<leader>cph",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end,
        desc = "CopilotChat - Help actions",
      },
      {
        "<leader>cpp",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "CopilotChat - Prompt actions",
        mode = { "n", "x" },
      },
      { "<leader>cpe", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code", mode = { "n", "x" } },
      { "<leader>cpt", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests", mode = { "n", "x" } },
      { "<leader>cpr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code", mode = { "n", "x" } },
      { "<leader>cpR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code", mode = { "n", "x" } },
      {
        "<leader>cpm",
        "<cmd>CopilotChatCommit<cr>",
        desc = "CopilotChat - Generate commit message for all changes",
      },
      {
        "<leader>cpM",
        "<cmd>CopilotChatCommitStaged<cr>",
        desc = "CopilotChat - Generate commit message for staged changes",
      },
      { "<leader>cpf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
      { "<leader>cpl", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
      { "<leader>cpv", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
    },
  },
}

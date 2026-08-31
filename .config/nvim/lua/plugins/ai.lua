return {
  "folke/sidekick.nvim",
  dependencies = {
    {
      "coder/claudecode.nvim",
      opts = {
        terminal = {
          provider = "none",
        },
        diff_opts = {
          layout = "vertical",
          open_in_new_tab = true,
        },
        auto_start = true,
      },
      keys = {
        { "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude Diff" },
        { "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude Diff" },
      },
    },
  },
  -- Herdr has no upstream mux backend yet (folke/sidekick.nvim#333), so register
  -- our own. Outside Herdr this is a no-op and sidekick's tmux backend is used
  -- untouched, which keeps one config working under both Ghostty+tmux and Kitty+Herdr.
  config = function(_, opts)
    if require("mux.herdr").setup() then
      opts.cli = vim.tbl_deep_extend("force", opts.cli or {}, { mux = { backend = "herdr" } })
    end
    require("sidekick").setup(opts)
  end,
  opts = {
    nes = {
      enabled = false,
    },
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
        create = "split",
        split = {
          vertical = true,
          size = 0.4,
        },
      },
    },
    prompts = {
      -- ── Tuned action prompts ─────────────────────────────────────
      changes = "Review my changes for correctness, edge cases, and anything that doesn't match the surrounding code's conventions. Be concise and prioritize the most important issues.",
      diagnostics = "Help me fix the diagnostics in {file}. Briefly explain the root cause of each before fixing.\n{diagnostics}",
      diagnostics_all = "Help me fix these diagnostics. Briefly explain the root cause of each before fixing.\n{diagnostics_all}",
      document = "Add documentation to {function|line}, matching the existing doc style in this file.",
      explain = "Explain {this}",
      fix = "Fix {this}. Briefly explain what was wrong.",
      optimize = "How can {this} be optimized? Consider performance, memory, and readability, and note which you're prioritizing.",
      review = "Review {file} for bugs, edge cases, and improvements. Be concise and prioritize by importance.",
      tests = "Write tests for {this}, using the test framework and conventions already used in this project.",

      -- ── Git-aware ────────────────────────────────────────────────
      commit = "Look at the staged changes (git diff --cached) and write a commit message following Conventional Commits. Subject under 72 chars, then a body explaining the why if it's non-trivial. Output only the message.",
      commit_all = "Stage logically-grouped changes and propose one or more commits with messages. Show me the plan before committing anything.",
      pr = "Summarize the diff between this branch and the main branch into a PR description: a short summary, key changes as bullets, and any testing notes.",
      explain_diff = "Walk me through what changed in my uncommitted work and why it matters.",
      blame = "Use git log/blame to explain why {this} was written the way it is and how it evolved.",

      -- ── Code actions ─────────────────────────────────────────────
      refactor = "Refactor {this} for clarity and maintainability without changing behavior. Explain each change briefly and don't touch unrelated code.",
      types = "Add or tighten type annotations for {this}, matching the project's existing typing conventions.",
      edgecases = "What edge cases or failure modes does {this} miss? List them, then suggest handling for the important ones.",
      simplify = "Can {this} be simplified or made more idiomatic? Show before/after.",
      name = "Suggest better names for the variables/functions in {this} and explain the reasoning.",

      -- ── Repo / investigation (agentic CLI shines here) ───────────
      trace = "Trace how {this} is used across the codebase — who calls it and what depends on it.",
      impact = "If I change {this}, what else in the repo would I need to update? Search and list them.",
      todo = "Find the TODO/FIXME comments near {file} and tell me which look stale or risky.",
      onboard = "I'm new to this part of the code. Explain what {file} does and how it fits the larger project.",

      -- ── Quickfix-driven batch work ───────────────────────────────
      quickfix_fix = "Work through this quickfix list and fix each item. Explain each fix briefly and don't touch unrelated code.\n{quickfix}",
      quickfix_triage = "Here's my quickfix list. Group the items, tell me which are real problems vs noise, and suggest an order to tackle them.\n{quickfix}",

      -- ── Open-buffer scope ────────────────────────────────────────
      buffers_review = "Review my open buffers for inconsistencies, duplicated logic, or things that don't agree with each other.\n{buffers}",
      buffers_relate = "How do my open buffers relate? Explain the flow of data/control between them.\n{buffers}",

      -- ── Class / struct scope (Tree-sitter) ───────────────────────
      class_review = "Review {class} — responsibilities, cohesion, and any methods that don't belong here.",
      class_tests = "Write tests for {class}, using the test framework already used in this project.",
      class_doc = "Add documentation to {class}, matching the existing doc style in this file.",

      -- ── Selection-precise variants ───────────────────────────────
      sel_explain = "Explain this code:\n{selection}",
      sel_rewrite = "Rewrite this to be clearer and more idiomatic, same behavior:\n{selection}",
      sel_regex = "Turn this into a regex / explain what this regex does:\n{selection}",

      -- ── Simple context prompts (pure dumps — leave terse) ────────
      buffers = "{buffers}",
      file = "{file}",
      line = "{line}",
      position = "{position}",
      quickfix = "{quickfix}",
      selection = "{selection}",
      ["function"] = "{function}",
      class = "{class}",
    },
  },
}

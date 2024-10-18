return {
  {
    "epwalsh/obsidian.nvim",
    init = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>o", group = "obsidian", mode = { "n", "v" } },
        { "<leader>ol", group = "links", mode = { "n", "v" } },
      })
    end,
    opts = {
      workspaces = {
        {
          name = "notes",
          path = "~/Documents/smaranika/",
        },
      },
      disable_frontmatter = true,
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M:%S",
        substitutions = {
          today = function()
            return os.date("%Y-%m-%d")
          end,
          yesterday = function()
            return os.date("%Y-%m-%d", os.time() - 86400)
          end,
          tomorrow = function()
            return os.date("%Y-%m-%d", os.time() + 86400)
          end,
          day_of_week = function()
            return os.date("%A")
          end,
          month = function()
            return os.date("%B")
          end,
          month_num = function()
            return os.date("%m")
          end,
          year = function()
            return os.date("%Y")
          end,
          day = function()
            return os.date("%d")
          end,
        },
      },
      notes_subdir = "inbox",
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '20241015-my-new-note', and therefore the file name '20241015-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end

        return os.date("%Y%m%d") .. "_" .. suffix
      end,
      daily_notes = {
        folder = "inbox",
        template = "daily-note",
      },
      ui = {
        enable = false,
      },
    },
    keys = {
      {
        "<leader>on",
        function()
          vim.cmd("ObsidianNew")
          vim.cmd("normal! gg")
          vim.cmd("ObsidianTemplate new-note")
        end,
        desc = "obsidian new note",
      },
      {
        "<leader>of",
        "<CMD>ObsidianSearch<CR>",
        desc = "obsidian search",
      },
      {
        "<leader>or",
        "<CMD>ObsidianRename<CR>",
        desc = "obsidian rename",
      },
      {
        "<leader>ok",
        "<CMD>!obsidian_ok '%:p'<CR>",
        desc = "obsidian move note to archive",
      },
      {
        "<leader>ox",
        "<CMD>!rm '%:p'<CR>",
        desc = "obsidian remove note",
      },
      {
        "<leader>od",
        "<CMD>ObsidianDailies<CR>",
        desc = "obsidian dailies",
      },
      {
        "<leader>ot",
        "<CMD>ObsidianToday<CR>",
        desc = "obsidian today",
      },
      {
        "<leader>oy",
        "<CMD>ObsidianYesterday<CR>",
        desc = "obsidian yesterday",
      },
      {
        "<leader>oT",
        "<CMD>ObsidianTomorrow<CR>",
        desc = "obsidian tomorrow",
      },
      {
        "<leader>olf",
        "<CMD>ObsidianLinks<CR>",
        desc = "obsidian forward links",
      },
      {
        "<leader>olb",
        "<CMD>ObsidianBacklinks<CR>",
        desc = "obsidian back links",
      },
      {
        "<leader>oll",
        "<CMD>ObsidianLink<CR>",
        mode = "v",
        desc = "obsidian link",
      },
      {
        "<leader>oln",
        "<CMD>ObsidianLinkNew<CR>",
        mode = "v",
        desc = "obsidian link new",
      },
    },
  },
}

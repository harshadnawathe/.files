--- Herdr mux backend for sidekick.nvim.
---
--- sidekick only ships `tmux` and `zellij` backends, but `session.register()` is a
--- first-class extension point -- the plugin's own `sk/cli/opencode.lua` uses it --
--- so this lives here instead of in a fork. Remove this module and the `config`
--- hook in `lua/plugins/ai.lua` once folke/sidekick.nvim#333 lands.
---
--- Behaviours worth knowing, all verified against herdr 0.8.2:
---  * `pane split` creates a bare *shell* pane and `pane run` types into it, so we
---    have to wait for the prompt first -- see `wait_shell()`.
---  * Starting the tool with `exec` replaces that shell, so the pane dies with the
---    tool and `shell_pid` *is* the tool's pid, keeping `is_running()` free.
---  * `pane send-text` passes bytes through verbatim and adds no bracketed paste,
---    so we wrap payloads ourselves to match tmux's `paste-buffer -r -d`.
---  * Most herdr commands emit JSON, but `pane read` emits plain text -- don't feed
---    it through the `herdr()` helper below if a `dump()` is ever added here.

local Config = require("sidekick.config")
local Util = require("sidekick.util")

---@class sidekick.cli.muxer.Herdr: sidekick.cli.Session
---@field herdr_pane_id? string pane hosting the tool
---@field herdr_terminal_id? string
---@field herdr_pid? integer pid of the tool that owns the pane
local M = {}
M.__index = M

local PASTE_START, PASTE_END, FOCUS_IN = "\27[200~", "\27[201~", "\27[I"

--- Run a herdr CLI command and return its decoded `.result` payload.
---@param args string[]
---@param opts? {notify?:boolean}
---@return table?
local function herdr(args, opts)
  local _, out = Util.exec(vim.list_extend({ "herdr" }, args), opts)
  if not out then
    return nil
  elseif out == "" then
    return {} -- some commands (`pane run`) succeed with no payload
  end
  local ok, json = pcall(vim.json.decode, out)
  if not ok or type(json) ~= "table" then
    return nil
  end
  return json.result or {}
end

--- Herdr leaks `HERDR_ENV` and `HERDR_PANE_ID` into a tmux server started from one
--- of its panes, so `TMUX` has to win -- otherwise we would drive herdr panes while
--- actually running inside tmux.
function M.in_herdr()
  return vim.env.TMUX == nil and vim.env.HERDR_ENV == "1" and vim.fn.executable("herdr") == 1
end

function M:init()
  self.external = self.started or (M.in_herdr() and Config.cli.mux.create ~= "terminal")
  -- 10, matching tmux's external panes: our own Neovim runs inside a herdr pane, so
  -- `sessions()` also finds tools running in Neovim's embedded terminals. Those
  -- duplicates overlap on pids and have to lose to the terminal backend (100).
  self.priority = self.external and 10 or 50
end

--- `clear; exec env ... <tool cmd>`, to be typed into the pane's shell.
--- `pane run` types the command, so the shell echoes it; `clear` wipes that line
--- before the tool takes over the screen. `exec` then replaces the shell itself.
--- @return string
function M:exec_cmd()
  local parts = { "clear;", "exec" }
  local env = self.tool.env or {}
  if not vim.tbl_isempty(env) then
    parts[#parts + 1] = "env"
    for key, value in pairs(env) do
      if value == false then
        vim.list_extend(parts, { "-u", key }) -- herdr's `--env` cannot unset
      else
        parts[#parts + 1] = ("%s=%s"):format(key, vim.fn.shellescape(tostring(value)))
      end
    end
  end
  parts[#parts + 1] = table.concat(vim.tbl_map(vim.fn.shellescape, self.tool.cmd), " ")
  return table.concat(parts, " ")
end

--- Wait until the pane's shell is idle at its prompt. `pane run` types text, so
--- anything sent while the shell is still starting up is silently dropped.
---@return boolean
function M:wait_shell()
  return vim.wait(5000, function()
    local r = herdr({ "pane", "process-info", "--pane", self.herdr_pane_id }, { notify = false })
    local info = r and r.process_info
    local fg = info and info.foreground_processes or {}
    return #fg == 1 and fg[1].pid == info.shell_pid
  end, 50)
end

---@return sidekick.cli.terminal.Cmd?
function M:start()
  if not self.external then
    Util.warn({
      "The `herdr` backend needs Neovim to be running inside a Herdr pane.",
      ("`opts.cli.mux.create = %q` is not supported; using a split instead."):format(Config.cli.mux.create),
    })
    self.external = true
  end

  local create = Config.cli.mux.create
  local pane ---@type table?

  if create == "window" then
    local r = herdr({ "tab", "create", "--cwd", self.cwd, "--label", self.tool.name, "--no-focus" })
    pane = r and r.root_pane
  else
    local args = { "pane", "split", "--current", "--no-focus", "--cwd", self.cwd }
    -- sidekick's `vertical` means side-by-side panes (its tmux path maps it to -h)
    vim.list_extend(args, { "--direction", Config.cli.mux.split.vertical and "right" or "down" })
    local size = Config.cli.mux.split.size
    if size > 0 and size < 1 then
      -- herdr's --ratio sizes the *existing* pane, sidekick's size means the new
      -- one, so this is inverted on purpose. Verified: 0.4 -> agent gets 40%.
      vim.list_extend(args, { "--ratio", tostring(1 - size) })
    end
    for key, value in pairs(self.tool.env or {}) do
      if value ~= false then
        vim.list_extend(args, { "--env", ("%s=%s"):format(key, tostring(value)) })
      end
    end
    local r = herdr(args)
    pane = r and r.pane
  end

  if not (pane and pane.pane_id) then
    Util.error(("Failed to create a Herdr pane for **%s**"):format(self.tool.name))
    return
  end

  -- This id has to match what `sessions()` reports, or the same pane is seen twice.
  self.id = "herdr " .. pane.pane_id
  self.herdr_pane_id = pane.pane_id
  self.herdr_terminal_id = pane.terminal_id
  self.mux_session = pane.workspace_id
  self.started = true

  if not self:wait_shell() then
    Util.warn(
      ("Herdr pane `%s` never reached a shell prompt; starting **%s** anyway."):format(
        self.herdr_pane_id,
        self.tool.name
      )
    )
  end
  herdr({ "pane", "run", self.herdr_pane_id, self:exec_cmd() })

  -- `exec` keeps the pid, so the pane's `shell_pid` is now the tool itself.
  local r = herdr({ "pane", "process-info", "--pane", self.herdr_pane_id }, { notify = false })
  self.herdr_pid = r and r.process_info and r.process_info.shell_pid

  Util.info(("Started **%s** in a new Herdr %s"):format(self.tool.name, create == "window" and "tab" or "split"))
end

--- `pane send-text` adds no bracketed paste of its own, so we add the markers here:
--- agents then treat the payload as one atomic paste instead of a burst of keys.
---@param text string
function M:send(text)
  local payload = PASTE_START .. text .. PASTE_END
  if self.tool.mux_focus then
    payload = FOCUS_IN .. payload -- some TUIs ignore input while unfocused
  end
  Util.exec({ "herdr", "pane", "send-text", self.herdr_pane_id, payload })
end

function M:submit()
  Util.exec({ "herdr", "pane", "send-keys", self.herdr_pane_id, "enter" })
end

function M:is_running()
  return self.herdr_pid ~= nil and vim.api.nvim_get_proc(self.herdr_pid) ~= nil
end

---@return sidekick.cli.session.State[]
function M.sessions()
  local r = herdr({ "pane", "list" }, { notify = false })
  if not (r and r.panes) then
    return {}
  end

  local tools = Config.tools()
  local Procs = require("sidekick.cli.procs")
  local procs = Procs.new() -- one `ps` snapshot, reused for every pane
  local ret = {} ---@type sidekick.cli.session.State[]

  for _, pane in ipairs(r.panes) do
    local info = herdr({ "pane", "process-info", "--pane", pane.pane_id }, { notify = false })
    info = info and info.process_info
    if info and info.shell_pid then
      procs:walk(info.shell_pid, function(proc)
        for _, tool in pairs(tools) do
          if tool:is_proc(proc) then
            ret[#ret + 1] = {
              id = "herdr " .. pane.pane_id,
              -- herdr already knows the cwd; `proc.cwd` forks lsof on macOS
              cwd = pane.foreground_cwd or pane.cwd or proc.cwd,
              tool = tool,
              herdr_pane_id = pane.pane_id,
              herdr_terminal_id = pane.terminal_id,
              herdr_pid = proc.pid,
              mux_session = pane.workspace_id,
              pids = Procs.pids(proc.pid),
            }
            return true -- stop walking this pane
          end
        end
      end)
    end
  end

  return ret
end

--- Register the backend. Returns true when herdr is actually usable, so the caller
--- can point `cli.mux.backend` at it.
---@return boolean
function M.setup()
  if not M.in_herdr() then
    return false
  end

  -- `config.lua` hardcodes `M.validate("cli.mux.backend", { "tmux", "zellij" })`.
  -- validate() only notifies (its return value is discarded), so this shim is
  -- purely cosmetic; it goes away with #333.
  local validate = Config.validate
  ---@diagnostic disable-next-line: duplicate-set-field
  Config.validate = function(key, t)
    if key == "cli.mux.backend" and type(t) == "table" then
      t = vim.list_extend(vim.deepcopy(t), { "herdr" })
    end
    return validate(key, t)
  end

  require("sidekick.cli.session").register("herdr", M)
  return true
end

return M

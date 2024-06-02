act = require("wezterm").action

M = {}

function tmux_key_table(tmux_key)
  if type(tmux_key) == "table" then
    return tmux_key
  else
    return { key = tmux_key }
  end
end

M.key_table = function(mods, key, action)
	return {
		mods = mods,
		key = key,
		action = action,
	}
end

M.cmd_key = function(key, action)
	return M.key_table("SUPER", key, action)
end

M.cmd_to_tmux_prefix = function(key, tmux_key)
	return M.cmd_key(
		key,
		act.Multiple({
			act.SendKey({ mods = "CTRL", key = "a" }),
			act.SendKey(tmux_key_table(tmux_key)),
		})
	)
end

return M

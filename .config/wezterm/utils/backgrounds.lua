local function expand_home(path)
	local home = os.getenv("HOME")
	if not home then
		return path
	end
	return string.gsub(path, "^~", home)
end

return {
	["Darth-Vader-Rogue-One"] = {
		{
			source = {
				File = {
					path = expand_home(
						"~/.config/wezterm/wallpapers/darth-vader-red-lightsaber-star-wars-moewalls-com.gif"
					),
				},
			},
			horizontal_align = "Center",
			vertical_align = "Middle",
		},
		{
			source = {
				Color = "black",
			},
			width = "100%",
			height = "100%",
			opacity = 0.4,
		},
	},
	["Anime-Raid-in-the-dark"] = {
		{
			source = {
				File = {
					path = expand_home("~/.config/wezterm/wallpapers/raid-in-the-dark.png"),
				},
			},
			horizontal_align = "Center",
			vertical_align = "Middle",
		},
		{
			source = {
				Color = "black",
			},
			width = "100%",
			height = "100%",
			opacity = 0.7,
		},
	},
	["Batman-Logo-The-Dark-Knight"] = {
		{
			source = {
				File = {
					path = expand_home("~/.config/wezterm/wallpapers/batman-logo.jpg"),
				},
			},
			horizontal_align = "Center",
			vertical_align = "Middle",
		},
		{
			source = {
				Color = "black",
			},
			width = "100%",
			height = "100%",
			opacity = 0.6,
		},
	},
	["Black-Sand-Dunes"] = {
		{
			source = {
				File = {
					path = expand_home("~/.config/wezterm/wallpapers/pexels-adrien-olichon-1257089-2387793.jpg"),
				},
			},
			horizontal_align = "Center",
			vertical_align = "Middle",
		},
		{
			source = {
				Color = "black",
			},
			width = "100%",
			height = "100%",
			opacity = 0.2,
		},
	},
	["Iron-Man"] = {
		{
			source = {
				File = {
					path = expand_home("~/.config/wezterm/wallpapers/iron-man-wallhaven-j8xlpy.jpg"),
				},
			},
			horizontal_align = "Center",
			vertical_align = "Middle",
		},
		{
			source = {
				Color = "black",
			},
			width = "100%",
			height = "100%",
			opacity = 0.6,
		},
	},
}

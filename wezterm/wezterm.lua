local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("Cascadia Code", { weight = "Bold", stretch = "Normal", italic = false })

config.adjust_window_size_when_changing_font_size = false

config.wsl_domains = {
	{
		name = "WSL:Ubuntu",
		distribution = "Ubuntu",
		default_cwd = "~",
	},
}

config.default_domain = "WSL:Ubuntu"

local transparent_bg = "rgba(0, 0, 0, 0)"
local c8 = "#5ef1ff"
local c7 = "#5ea1ff"

config.color_scheme = "Catppuccin Frappe"
--
-- local cyberdream = {
-- 	foreground = "#ffffff",
-- 	background = "#16181a",
--
-- 	cursor_bg = "#ffffff",
-- 	cursor_fg = "#16181a",
-- 	cursor_border = "#ffffff",
--
-- 	selection_fg = "#ffffff",
-- 	selection_bg = "#3c4048",
--
-- 	scrollbar_thumb = "#16181a",
-- 	split = "#16181a",
--
-- 	ansi = { "#16181a", "#ff6e5e", "#5eff6c", "#f1ff5e", c7, c7, c8, "#ffffff" },
-- 	brights = { "#3c4048", "#ff6e5e", "#5eff6c", "#f1ff5e", c7, c7, c8, "#ffffff" },
-- 	indexed = { [16] = "#ffbd5e", [17] = "#ff6e5e" },
-- }
-- config.colors = cyberdream

-- For example, changing the color scheme:
-- config.color_scheme = "Bamboo"

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1500 }

-- Window Configuration
config.initial_rows = 45
config.initial_cols = 180
config.window_decorations = "RESIZE"
-- config.background = {
-- 	{
-- 		source = {
-- 			File = wezterm.config_dir .. "/bgblurred.png",
-- 		},
-- 		opacity = 1,
-- 	},
-- }
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Acrylic"

-- Performance Settings
config.max_fps = 144
config.animation_fps = 144
config.cursor_blink_rate = 250

-- Keybindings
config.keys = {
	-- Paste from clipboard
	{ key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },

	-- Scroll by page
	{ key = "PageUp", action = wezterm.action.ScrollByPage(-1) },
	{ key = "PageDown", action = wezterm.action.ScrollByPage(1) },

	-- Delete line to the left
	{
		key = "Backspace",
		mods = "LEADER",
		action = wezterm.action.SendKey({ key = "u", mods = "CTRL" }),
	},

	-- Open WezTerm config file quickly
	{
		key = ",",
		mods = "LEADER",
		action = wezterm.action.SpawnCommandInNewTab({
			cwd = "/mnt/c/Users/Chris/",
			set_environment_variables = {
				TERM = "screen-256color",
			},
			args = {
				"vim",
				"/mnt/c/Users/Chris/.wezterm.lua",
			},
		}),
	},

	-- Rename tab title
	{
		key = "R",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- Find files by fzf
	{
		key = "f",
		mods = "CTRL",
		action = wezterm.action.SendString("fzf\n"),
	},

	-- Split panes (tmux-style)
	{
		key = "/",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = ".",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},

	-- Change panes
	{
		key = "RightArrow",
		mods = "LEADER",
		action = wezterm.action({ ActivatePaneDirection = "Right" }),
	},
	{
		key = "LeftArrow",
		mods = "LEADER",
		action = wezterm.action({ ActivatePaneDirection = "Left" }),
	},
	{
		key = "UpArrow",
		mods = "LEADER",
		action = wezterm.action({ ActivatePaneDirection = "Up" }),
	},
	{
		key = "DownArrow",
		mods = "LEADER",
		action = wezterm.action({ ActivatePaneDirection = "Down" }),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action({ ActivatePaneDirection = "Right" }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action({ ActivatePaneDirection = "Left" }),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action({ ActivatePaneDirection = "Up" }),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action({ ActivatePaneDirection = "Down" }),
	},
}

-- Tab Bar Configuration
-- config.enable_tab_bar = true
-- config.hide_tab_bar_if_only_one_tab = false
-- config.show_tab_index_in_tab_bar = false
-- config.use_fancy_tab_bar = false
-- config.colors.tab_bar = {
-- 	background = "rgba(0, 0, 0, 0)",
-- 	new_tab = { fg_color = "rgba(0, 0, 0, 0)", bg_color = "rgba(0, 0, 0, 0)" },
-- 	new_tab_hover = { fg_color = "rgba(0, 0, 0, 0)", bg_color = "rgba(0, 0, 0, 0)" },
-- }

-- wezterm.on("format-tab-title", function(tab, _, _, _, hover)
-- 	local background = "rgba(94, 241, 255, 0.1)"
-- 	local foreground = "rgba(94, 241, 255, 0.1)"
--
-- 	if tab.is_active then
-- 		background = "rgba(94, 241, 255, 0.3)"
-- 		foreground = "rgba(94, 241, 255, 0)"
-- 	elseif hover then
-- 		background = transparent_bg
-- 		foreground = transparent_bg
-- 	end
--
-- 	local tab_index = tostring(tab.tab_index + 1)
-- 	local tab_content = tostring(tab.active_pane.title)
--
-- 	return {
-- 		{ Background = { Color = background } },
-- 		{ Foreground = { Color = foreground } },
-- 		{ Text = string.format("  %s - %s  ", tab_index, tab_content) },
-- 	}
-- end)

local function segments_for_right_status(window)
	return {
		window:active_workspace(),
		wezterm.strftime("%a %b %-d %H:%M"),
		wezterm.hostname(),
	}
end

wezterm.on("update-status", function(window, _)
	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	local segments = segments_for_right_status(window)

	local color_scheme = window:effective_config().resolved_palette
	-- Note the use of wezterm.color.parse here, this returns
	-- a Color object, which comes with functionality for lightening
	-- or darkening the colour (amongst other things).
	local bg = wezterm.color.parse(color_scheme.background)
	local fg = color_scheme.foreground

	-- Each powerline segment is going to be coloured progressively
	-- darker/lighter depending on whether we're on a dark/light colour
	-- scheme. Let's establish the "from" and "to" bounds of our gradient.
	local gradient_to, gradient_from = bg
	gradient_from = gradient_to:lighten(0.2)

	-- Yes, WezTerm supports creating gradients, because why not?! Although
	-- they'd usually be used for setting high fidelity gradients on your terminal's
	-- background, we'll use them here to give us a sample of the powerline segment
	-- colours we need.
	local gradient = wezterm.color.gradient(
		{
			orientation = "Horizontal",
			colors = { gradient_from, gradient_to },
		},
		#segments -- only gives us as many colours as we have segments.
	)

	-- We'll build up the elements to send to wezterm.format in this table.
	local elements = {}

	for i, seg in ipairs(segments) do
		local is_first = i == 1

		if is_first then
			table.insert(elements, { Background = { Color = "none" } })
		end
		table.insert(elements, { Foreground = { Color = gradient[i] } })
		table.insert(elements, { Text = SOLID_LEFT_ARROW })

		table.insert(elements, { Foreground = { Color = fg } })
		table.insert(elements, { Background = { Color = gradient[i] } })
		table.insert(elements, { Text = " " .. seg .. " " })
	end

	window:set_right_status(wezterm.format(elements))
end)

return config

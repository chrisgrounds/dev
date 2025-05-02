-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

local transparent_bg = "rgba(0, 0, 0, 0)"

local cyberdream = {
  foreground = "#ffffff",
  background = "#16181a",

  cursor_bg = "#ffffff",
  cursor_fg = "#16181a",
  cursor_border = "#ffffff",

  selection_fg = "#ffffff",
  selection_bg = "#3c4048",

  scrollbar_thumb = "#16181a",
  split = "#16181a",

  ansi = { "#16181a", "#ff6e5e", "#5eff6c", "#f1ff5e", "#5ea1ff", "#bd5eff", "#5ef1ff", "#ffffff" },
  brights = { "#3c4048", "#ff6e5e", "#5eff6c", "#f1ff5e", "#5ea1ff", "#bd5eff", "#5ef1ff", "#ffffff" },
  indexed = { [16] = "#ffbd5e", [17] = "#ff6e5e" },
}
config.colors = cyberdream

-- For example, changing the color scheme:
config.color_scheme = 'Bamboo'

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1500 }

-- Window Configuration
config.initial_rows = 45
config.initial_cols = 180
-- config.window_decorations = "RESIZE"
config.background = {
  {
      source = {
          File = wezterm.config_dir .. "/purple.png"
      },
      opacity = 1
  }
}
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Acrylic"

-- Performance Settings
config.max_fps = 144
config.animation_fps = 144
config.cursor_blink_rate = 250

-- Keybindings
config.keys = {
  { key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
}

-- Tab Bar Configuration
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false
config.colors.tab_bar = {
    background = transparent_bg,
    new_tab = { fg_color = config.colors.background, bg_color = config.colors.brights[6] },
    new_tab_hover = { fg_color = config.colors.background, bg_color = config.colors.foreground },
}

wezterm.on("format-tab-title", function(tab, _, _, _, hover)
  local background = config.colors.brights[1]
  local foreground = config.colors.foreground

  if tab.is_active then
      background = config.colors.brights[7]
      foreground = config.colors.background
  elseif hover then
      background = config.colors.brights[8]
      foreground = config.colors.background
  end

  local title = tostring(tab.tab_index + 1)
  return {
      { Foreground = { Color = background } },
      { Text = "█" },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Foreground = { Color = background } },
      { Text = "█" },
  }
end)


-- and finally, return the configuration to wezterm
return config

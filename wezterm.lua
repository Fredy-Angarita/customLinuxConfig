local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 40

local appearance = require 'appearance'
local projects = require 'projects'
wezterm.on('format-tab-title', function(tab)
  local tab_index = tab.tab_index + 1 -- Lua empieza en 1
  return {
    { Text = ' ' .. tostring(tab_index) .. ' ' },
  }
end)

local theme = dofile(os.getenv("HOME") .. "/.config/wezterm/theme.lua")
for key, value in pairs(theme) do 
   config[key] = value
end
local bildings = dofile(os.getenv("HOME") .. "/.config/wezterm/keybildings.lua")
for key, value in pairs (bildings) do
   config[key] = value
end
return config

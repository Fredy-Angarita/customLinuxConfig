local wezterm = require("wezterm")
local projects = require 'projects'

local keys = {}

keys.leader = {key = 'Space', mods = 'CTRL', timeout_milliseconds = 500}


local function move_pane(key, direction)
   return {
      key = key,
      mods = 'LEADER',
      action = wezterm.action.ActivatePaneDirection(direction),
   }
end 

local function resize_pane(key, direction)
   return {
      key = key,
      action = wezterm.action.AdjustPaneSize {direction, 3},
   }
end

keys.keys = {
   {
	key = 'z',
	mods = 'LEADER',
	action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
   },
   {
	key = 'x',
	mods = 'LEADER',
	action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
   },
   {
        key = 'q',
	mods = 'LEADER',
	action = wezterm.action.CloseCurrentPane {confirm = true},
   },
   {
	key = 'r',
	mods = 'LEADER',
	action = wezterm.action.ActivateKeyTable {
	   name = 'resize_panes',
	   one_shot = false,
	   timeout_milliseconds = 1000,
	}
   },
   {
	key = 'p',
	mods = 'LEADER',
	action = projects.choose_project(),
   },
   {
    key = 'f',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },
   move_pane('s', 'Down'),
   move_pane('w', 'Up'),
   move_pane('a', 'Left'),
   move_pane('d', 'Right'),
}

keys.key_tables = {
   resize_panes = {
     resize_pane('s', 'Down'),
     resize_pane('w', 'Up'),
     resize_pane('a', 'Left'),
     resize_pane('d', 'Right'),
   }
}

return keys

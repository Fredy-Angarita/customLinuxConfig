local wezterm = require("wezterm")
local appearance = require("appearance")
local theme = {}

theme.tab_bar_at_bottom = true
theme.use_fancy_tab_bar = false

--[[
Dracula, Alabaster, Ashes (base16), apprentice (Gogh)
Tokyo Night (Gogh), Tokyo Night, 
]]
theme.color_scheme = "Tokyo Night"

-- Font Settings
theme.font = wezterm.font("GeistMono NFM")
theme.font_size = 13.0

-- Window Settings
theme.window_padding = {
  left = 25,
  right= 25,
}
--Background Settings
theme.window_background_opacity = 1.0
theme.background = {
  {
    source = {
      File = "/home/devfx/Imágenes/terminal/t2.jpg",
    },
    hsb = {
      brightness = 0.3,
    },
    width = "Cover",
    height = "Cover",
    horizontal_align = "Center",
    vertical_align = "Middle",
  },
  {
    source = {
      Color = "rgba(43, 43, 43, 0.25)",
    },
    width = "100%",
    height = "100%",
  },
}
-- 🎨 Colors
local base_color = "#2b2b2b"   -- azul grisáceo oscuro
local accent_color = "#f5c542" -- azul claro para resaltar
local text_color = "#f5f5f5"   -- casi blanco para contraste

-- Tab Bar Settings
theme.colors = {
  tab_bar = {
    background = base_color,

    active_tab = {
      bg_color = accent_color,
      fg_color = base_color,
      intensity = "Bold",
    },

    inactive_tab = {
      bg_color = "#3a3a3a",
      fg_color = "#dcdcdc",
    },

    inactive_tab_hover = {
      bg_color = "#4a4a4a",
      fg_color = "#fff6cc",
      italic = true,
    },

    new_tab = {
      bg_color = base_color,
      fg_color = accent_color,
    },

    new_tab_hover = {
      bg_color = accent_color,
      fg_color = base_color,
      italic = true,
    },
  },
}
theme.window_frame = {
  active_titlebar_bg = base_color,
  inactive_titlebar_bg = base_color,
  active_titlebar_fg = text_color,
  inactive_titlebar_fg = "#a0a6af",
  button_bg = base_color,
  button_fg = text_color,
}


local function segments_for_right_status(window)
   return {
      window: active_workspace(),
      wezterm.strftime('%a %b %-d %H:%M'),
      wezterm.hostname(),
   }
end
wezterm.on('update-status', function(window, _)
  local segments = segments_for_right_status(window)

  local color_scheme = window:effective_config().resolved_palette
  local bg = wezterm.color.parse(color_scheme.background)
  local fg = color_scheme.foreground

  local gradient_to, gradient_from = bg
  if appearance.is_dark() then
    gradient_from = gradient_to:lighten(0.2)
  else
    gradient_from = gradient_to:darken(0.2)
  end

  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments
  )

  local elements = {}

  for i, seg in ipairs(segments) do
    local is_first = i == 1
    if is_first then
      table.insert(elements, { Background = { Color = 'none' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end)
return theme

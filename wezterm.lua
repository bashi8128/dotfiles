local wezterm = require 'wezterm'

return {
  -- Font settings
  font = wezterm.font_with_fallback{
    -- /usr/share/fonts/HackGen_Nerd/HackGenConsoleNF-Regular.ttf, FontConfig
    { family = "HackGen Console NF", weight="Regular", stretch="Normal", style="Normal" }, 
    -- /usr/share/fonts/HackGen_Nerd/HackGenConsoleNF-Bold.ttf, FontConfig
    { family = "HackGen Console NF", weight="Bold", stretch="Normal", style="Normal" }, 
    -- /usr/share/fonts/HackGen_Nerd/HackGenConsoleNFJ-Regular.ttf, FontConfig
    { family = "HackGen Console NFJ", weight="Regular", stretch="Normal", style="Normal" }, 
    -- /usr/share/fonts/HackGen_Nerd/HackGenConsoleNFJ-Bold.ttf, FontConfig
    { family = "HackGen Console NFJ", weight="Bold", stretch="Normal", style="Normal" }, 
    -- /usr/share/fonts/HackGen_Nerd/HackGen35ConsoleNF-Regular.ttf, FontConfig
    { family = "HackGen35 Console NF", weight="Regular", stretch="Normal", style="Normal" }, 
    -- /usr/share/fonts/HackGen_Nerd/HackGen35ConsoleNF-Bold.ttf, FontConfig
    { family = "HackGen35 Console NF", weight="Bold", stretch="Normal", style="Normal" }, 
    -- /usr/share/fonts/HackGen_Nerd/HackGen35ConsoleNFJ-Regular.ttf, FontConfig
    { family = "HackGen35 Console NFJ", weight="Regular", stretch="Normal", style="Normal" }, 
    -- /usr/share/fonts/HackGen_Nerd/HackGen35ConsoleNFJ-Bold.ttf, FontConfig
    { family = "HackGen35 Console NFJ", weight="Bold", stretch="Normal", style="Normal" }, 
  },
  warn_about_missing_glyphs = false,

  -- Key Bindings
  leader = { key = 'q', mods = 'CTRL' },
  keys = {
    { key = 'Enter', mods = 'ALT', action = wezterm.action.ToggleFullScreen },
    { key = '|', mods = 'LEADER|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }},
    { key = '-', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }},
    { key = '[', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },
    { key = 'x', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = false }},
    { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection "Left"},
    { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection "Down"},
    { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection "Up"},
    { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection "Right"},
    { key = 'r',
      mods = 'LEADER|SHIFT',
      action = wezterm.action.ActivateKeyTable {
        name = "resize_pane",
        one_shot = false,
      }
    },
  },

  -- Key Tables
  key_tables = {
    resize_pane = {
      { key = 'LeftArrow', action = wezterm.action.AdjustPaneSize { "Left", 1 } },
      { key = 'DownArrow', action = wezterm.action.AdjustPaneSize { "Down", 1 } },
      { key = 'UpArrow', action = wezterm.action.AdjustPaneSize { "Up", 1 } },
      { key = 'RightArrow', action = wezterm.action.AdjustPaneSize { "Right", 1 } },
      { key = '[', mods = 'CTRL', action = "PopKeyTable" },
    },
  }
}

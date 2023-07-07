---@type ChadrcConfig
local M = {}

M.ui = {
  theme_toggle = {},
  theme = "catppuccin",
  transparency = false,

  statusline = {
    theme = "default",
    separator_style = "round",
  },

  nvdash = {
    load_on_startup = true,
  },
}

return M
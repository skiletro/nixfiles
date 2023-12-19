{...}: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
       local wezterm = require "wezterm"

       return {
         font = wezterm.font "Iosevka Comfy",
         font_size = 11,
         color_scheme = "Catppuccin Mocha",
         enable_scroll_bar = false,
         enable_tab_bar = false,
         scrollback_lines = 10000,
         window_padding = {
           left = 30,
           right = 30,
           top = 30,
           bottom = 30,
         },
         default_cursor_style = 'BlinkingBar',
         animation_fps = 40,
         check_for_updates = false,
      }
    '';
  };
}

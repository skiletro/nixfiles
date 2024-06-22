{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.terminal.utils.enable {
    programs.zellij = {
      enable = true;
      settings = {
        theme = "catppuccin-mocha";
        ui.pane_frames.rounded_corners = true;
      };
    };

    home.packages = with pkgs; [tmux]; # zellij alternative
  };
}

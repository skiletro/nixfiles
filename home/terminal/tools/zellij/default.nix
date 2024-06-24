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
        ui.pane_frames.rounded_corners = true;
      };
    };

    home.packages = with pkgs; [tmux]; # zellij alternative
  };
}

{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = {
    programs.zellij = {
      enable = true;
      settings = {
        ui.pane_frames.rounded_corners = true;
      };
    };
  };
}

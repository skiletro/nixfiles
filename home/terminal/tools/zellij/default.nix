{...}: {
  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      ui.pane_frames.rounded_corners = true;
    };
  };
}

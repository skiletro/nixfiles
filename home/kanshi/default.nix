{
  ...
}: {
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    profiles = {
      undocked.outputs = [
        {
          criteria = "eDP-1";
          status = "enable";
          scale = 1.5;
          mode = "1920x1080@60Hz";
        }
      ];
      docked.outputs = [
        {
          criteria = "DP-1";
          status = "enable";
          scale = 1.0;
          mode = "1920x1080@144Hz";
        }
        {
          criteria = "eDP-1";
          status = "enable";
          scale = 1.0;
          mode = "1920x1080@60Hz";
        }
      ];
    };
  };
}

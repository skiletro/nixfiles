{lib, ...}: {
  options.userConfig = {
    isHeadless = lib.mkEnableOption "Does the system have graphical output?";

    # Declare options for programs and settings that are configured using home-manager ONLY.
    programs = {
      emacs.enable = lib.mkEnableOption "Emacs";
      firefox.enable = lib.mkEnableOption "Firefox";
      mpv.enable = lib.mkEnableOption "MPV";
      neovim.enable = lib.mkEnableOption "Neovim";
      noisetorch.enable = lib.mkEnableOption "NoiseTorch"; # TODO: IMPLEMENT
      spotify.enable = lib.mkEnableOption "Spotify";
      vscode.enable = lib.mkEnableOption "Visual Studio Code";
    };

    services = {
      xdg.enable = lib.mkEnableOption "XDG Settings";

      eww.enable = lib.mkEnableOption "Eww";
      rofi.enable = lib.mkEnableOption "Rofi";
      swaylock.enable = lib.mkEnableOption "Swaylock";
      swaync.enable = lib.mkEnableOption "Sway Notification Center";
      syncthing.enable = lib.mkEnableOption "Syncthing and Syncthingtray";
      wlogout.enable = lib.mkEnableOption "Wlogout";
    };
  };
}

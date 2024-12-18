{lib, ...}: {
  options.userConfig = {
    system = {
      gpu = lib.mkOption {
        type = lib.types.enum ["none" "amd" "nvidia"];
        default = "none";
        description = "Specify the GPU, responsible for installing drivers, etc.";
      };
    };

    # Declare options for programs and settings that are configured using home-manager ONLY.
    programs = {
      firefox.enable = lib.mkEnableOption "Firefox";
      helix.enable = lib.mkEnableOption "Helix";
      lazygit.enable = lib.mkEnableOption "Lazygit";
      mpv.enable = lib.mkEnableOption "MPV";
      neovim.enable = lib.mkEnableOption "Neovim";
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

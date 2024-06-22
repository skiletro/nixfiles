{
  lib,
  config,
  ...
}: {
  options = {
    userConfig.programs.graphical = {
      emacs.enable = lib.mkEnableOption "Emacs";
      firefox.enable = lib.mkEnableOption "Firefox";
      spotify.enable = lib.mkEnableOption "Spotify";
      vscode.enable = lib.mkEnableOption "Visual Studio Code";
      zathura.enable = lib.mkEnableOption "Zathura";
    };
  };

  config = lib.mkIf config.userConfig.programs.graphical.enable {
    # Enable all graphical apps by default.
    userConfig.programs.graphical = {
      emacs.enable = lib.mkDefault true;
      firefox.enable = lib.mkDefault true;
      spotify.enable = lib.mkDefault true;
      vscode.enable = lib.mkDefault true;
      zathura.enable = lib.mkDefault true;
    };

    programs.noisetorch.enable = true;
  };
}

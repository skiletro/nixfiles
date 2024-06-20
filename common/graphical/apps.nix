{
  lib,
  config,
  ...
}: {
  options = {
    userConfig.graphical = {
      emacs.enable = lib.mkEnableOption "Emacs";
      firefox.enable = lib.mkEnableOption "Firefox";
      spotify.enable = lib.mkEnableOption "Spotify";
      vscode.enable = lib.mkEnableOption "Visual Studio Code";
      zathura.enable = lib.mkEnableOption "Zathura";
    };
  };

  config = lib.mkIf config.userConfig.graphical.enable {
    userConfig.graphical.emacs.enable = lib.mkDefault true;
    userConfig.graphical.firefox.enable = lib.mkDefault true;
    userConfig.graphical.spotify.enable = lib.mkDefault true;
    userConfig.graphical.vscode.enable = lib.mkDefault true;
    userConfig.graphical.zathura.enable = lib.mkDefault true;

    programs.noisetorch.enable = true;
  };
}

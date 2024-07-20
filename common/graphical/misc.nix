{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    userConfig.programs.graphical.misc.enable = lib.mkEnableOption "Misc Programs: IDEs, Game Engines, etc.";
  };

  config = lib.mkIf config.userConfig.programs.graphical.misc.enable {
    nixpkgs.config.android_sdk.accept_license = true;

    environment.systemPackages = with pkgs; [
      android-studio
      godot_4
    ];
  };
}

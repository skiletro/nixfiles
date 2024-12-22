{
  lib,
  pkgs,
  config,
  ...
}: {
  options.userConfig.programs.vial.enable = lib.mkEnableOption "Vial, a keyboard configurator";

  config = lib.mkIf config.userConfig.programs.vial.enable {
    environment.systemPackages = with pkgs; [vial];

    services.udev.packages = with pkgs; [
      vial
      via # For keyboards not running Vial firmware, but still support Via
    ];
  };
}

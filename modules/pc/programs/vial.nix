{
  lib,
  pkgs,
  config,
  ...
}: {
  config = lib.mkIf config.eos.programs.graphical.enable {
    environment.systemPackages = [pkgs.vial];

    services.udev.packages = with pkgs; [
      vial
      via # for keyboards not running Vial firmware, but still support Via.
    ];
  };
}

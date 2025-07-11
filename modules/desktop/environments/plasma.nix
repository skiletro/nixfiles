{
  lib,
  config,
  ...
}: {
  options.eos.desktop.plasma.enable = lib.mkEnableOption "Plasma desktop environment" // {enable = false;};

  config = lib.mkIf config.eos.desktop.plasma.enable {
    flake.modules.nixos.desktop = {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      services.desktopManager.plasma6.enable = true;
    };

    flake.modules.homeManager.jamie = _: {
    };
  };
}

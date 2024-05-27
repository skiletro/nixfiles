{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    customConfig.wms.plasma.enable = lib.mkEnableOption "KDE Plasma";
  };

  config = lib.mkIf config.customConfig.wms.plasma.enable {
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      konsole
      ark
      elisa
      gwenview
      okular
      kate
      khelpcenter
    ];
  };
}

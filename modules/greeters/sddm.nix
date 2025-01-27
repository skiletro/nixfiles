{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf ((config.userConfig.greeter.enable)
    && (config.userConfig.greeter.type == "sddm")) {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    environment.systemPackages = [
      (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
        [General]
        background=${config.stylix.image}
        type=image
      '')
    ];
  };
}

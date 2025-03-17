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
      package = lib.mkForce pkgs.kdePackages.sddm;
      wayland.enable = true;
    };

    environment.systemPackages = [
      (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
        [General]
        background=${config.stylix.image}
        type=image
      '')
      pkgs.kdePackages.sddm-kcm # Adds SDDM settings to Plasma Settings
    ];
  };
}

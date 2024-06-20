{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf ((config.userConfig.greeter.enable)
    && (config.userConfig.greeter.type == "sddm")) {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      #theme = "chili";
    };

    #environment.systemPackages = with pkgs; [sddm-chili-theme];
  };
}

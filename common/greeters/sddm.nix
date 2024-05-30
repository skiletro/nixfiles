{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.customConfig.greeter == "sddm") {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      #theme = "chili";
    };

    #environment.systemPackages = with pkgs; [sddm-chili-theme];
  };
}

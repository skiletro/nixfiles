{
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.userConfig.greeter.enable
    && (config.userConfig.greeter.type == "gdm")) {
    services.xserver.displayManager.gdm = {
      enable = true;
      wayland = true;
      autoSuspend = false;
    };
  };
}

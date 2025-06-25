{
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.eos.system.greeter == "gdm") {
    services.displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}

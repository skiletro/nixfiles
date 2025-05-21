{
  lib,
  config,
  ...
}: let
  cfg = config.eos;
in {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = lib.mkIf (cfg.system.gpu == "nvidia") {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  services.xserver.videoDrivers = lib.mkIf (cfg.system.gpu == "nvidia") ["nvidia"];
}

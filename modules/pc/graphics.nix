{
  lib,
  config,
  ...
}: let
  inherit (lib) mkMerge mkIf;
  cfg = config.eos;
in {
  config = mkMerge [
    {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    }
    (mkIf (cfg.system.gpu == "nvidia") {
      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
        powerManagement.enable = true;
      };

      services.xserver.videoDrivers = ["nvidia"];

      # Fix wake/suspend issues
      boot.kernelParams = [
        "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
        "NVreg_TemporaryFilePath=/var/tmp"
      ];
    })
  ];
}

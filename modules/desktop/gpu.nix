{
  lib,
  config,
  ...
}: {
  options.eos.system.gpu.isNvidia = lib.mkEnableOption "Nvidia Drivers" // {enable = false;};

  config = {
    flake.modules.nixos.desktop = lib.mkMerge [
      # Relevant to all graphics cards, i.e., mesa drivers
      {
        hardware.graphics = {
          enable = true;
          enable32Bit = true;
        };
      }

      # Nvidia specific settings
      (lib.mkIf
        config.eos.system.gpu.isNvidia
        (nixosAttrs: {
          hardware.nvidia = {
            package = nixosAttrs.config.boot.kernelPackages.nvidiaPackages.beta;
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
        }))
    ];
  };
}

{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.userConfig.system.gpu == "nvidia") {
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
    };
    # Noveau drivers don't work very well; adding this to stop them from interfering
    boot.blacklistedKernelModules = ["nouveau"];

    # Fixes some VR issues. I should probably put this in vr.nix, but I don't think it is doing any harm here.
    hardware.graphics.extraPackages = [pkgs.monado-vulkan-layers];
    environment.systemPackages = with pkgs; [
      nvtopPackages.nvidia
      monado-vulkan-layers
    ];
  };
}

{
  lib,
  config,
  ...
}: {
  options = {
    customConfig.cleanboot.enable = lib.mkEnableOption "Plymouth + a few more tweaks";
  };

  config = lib.mkIf config.customConfig.cleanboot.enable {
    boot = {
      plymouth = {
        enable = true;
        #theme = "";
      };
      initrd.verbose = false;
      consoleLogLevel = 0;
      kernelParams = ["quiet" "udev.log_level=0"];
    };
  };
}

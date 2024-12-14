{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.userConfig.system.gpu == "amd") {
    # TODO: I don't have an AMD GPU anymore, so this may need tweaking in the future.
    hardware.graphics = {
      enable32Bit = true;
    };

    environment.systemPackages = with pkgs; [
      nvtopPackages.amd
    ];
  };
}

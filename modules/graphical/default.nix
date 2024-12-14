{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./drivers
    ./gaming
    ./fonts.nix
  ];

  config = lib.mkIf (config.userConfig.system.gpu != "none") {
    # Platform-independent graphics
    # NOTE: Set the drivers for the specific device using userConfig.system.gpu.
    hardware.graphics.enable = true;

    # Bootloader
    # NOTE: The rationale of this being here, is that currently the only systems that are configured in this flake that don't *technically* have a GPU is WSL, which uses its own bootloader anyway.
    boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };

    # Sound
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Configure keymap in X11
    services.xserver.xkb.layout = "gb";

    xdg.portal.enable = true;

    # Printing
    services.printing = {
      enable = true;
      drivers = with pkgs; [hplip]; # HP proprietary drivers
    };

    # Plymouth Fancy Boot
    boot = {
      plymouth.enable = true;
      initrd.verbose = false;
      consoleLogLevel = 0;
      kernelParams = ["quiet" "udev.log_level=0"];
    };

    programs.dconf.enable = lib.mkDefault true;
  };
}

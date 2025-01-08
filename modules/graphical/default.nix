{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./drivers
    ./gaming
    ./programs
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
    services.pulseaudio.enable = false;
    security.rtkit.enable = true; # make pipewire realtime-capable
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      lowLatency.enable = true; # Handled by nix-gaming flake
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
      plymouth.enable = lib.mkIf config.userConfig.system.splashscreen true;
      initrd.verbose = lib.mkIf config.userConfig.system.splashscreen false;
      consoleLogLevel = lib.mkIf config.userConfig.system.splashscreen 0;
      kernelParams = lib.mkIf config.userConfig.system.splashscreen ["quiet" "udev.log_level=0"];
    };

    programs.dconf.enable = lib.mkDefault true;
  };
}

{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./gaming
    ./apps.nix
    ./fonts.nix
  ];

  options = {
    userConfig.programs.graphical.enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.userConfig.programs.graphical.enable {
    # Platform-independent graphics
    # NOTE: Set the drivers for the specific device in the hosts/hostname.nix file.
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    # Sound
    sound.enable = true;
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

    services = {
      gvfs.enable = true; # Mount, trash, and other functionalities
      tumbler.enable = true; # Thumbnail support for images

      # Printing
      printing = {
        enable = true;
        drivers = with pkgs; [hplip]; # HP proprietary drivers
      };
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true; # For WiFi printers
      };
    };

    # hopefully I can switch away from swaylock in the future.
    # for now though, this can just stay here.
    # i'm too lazy.
    security.pam.services.swaylock = {};

    # Plymouth fancy boot :)
    boot = {
      plymouth = {
        enable = true;
        #theme = "";
      };
      initrd.verbose = false;
      consoleLogLevel = 0;
      kernelParams = ["quiet" "udev.log_level=0"];
    };

    programs.dconf.enable = true;
  };
}

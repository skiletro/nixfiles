{pkgs, ...}: {
  imports = [
    ./flatpak.nix
    ./fonts.nix
    ./graphics.nix
    ./stylix.nix
    ./virtualisation.nix
    ./desktops
    ./gaming
    ./greeters
    ./programs
    ./services
  ];

  config = {
    boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };

    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      avahi = {
        enable = true;
        nssmdns4 = true;
        nssmdns6 = true;
        openFirewall = true; # For WiFI printers
        publish = {
          enable = true;
          domain = true;
        };
      };
      printing = {
        enable = true;
        drivers = with pkgs; [
          cnijfilter2 # Canon Pixma
        ];
      };
      xserver.excludePackages = [pkgs.xterm];
    };

    security.rtkit.enable = true; # make pipewire realtime-capable

    xdg.portal.enable = true;

    programs.dconf.enable = true;
  };
}

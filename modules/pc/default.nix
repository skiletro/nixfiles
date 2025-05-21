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
      printing.enable = true;
      xserver.excludePackages = [pkgs.xterm];
    };

    security.rtkit.enable = true; # make pipewire realtime-capable

    xdg.portal.enable = true;

    programs.dconf.enable = true;
  };
}

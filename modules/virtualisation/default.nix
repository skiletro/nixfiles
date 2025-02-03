{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    userConfig.virtualisation.enable = lib.mkOption {
      default = true;
      description = "Enables Virtualisation";
    };
  };

  config = lib.mkIf config.userConfig.virtualisation.enable {
    # Virt Manager
    virtualisation.libvirtd = {
      enable = true;
      shutdownTimeout = 1; # https://superuser.com/questions/1784543/getting-cant-connect-to-default-error-on-shutdown-after-installing-virt-manag#1803752
      qemu.vhostUserPackages = with pkgs; [virtiofsd];
    };

    virtualisation.spiceUSBRedirection.enable = true;

    programs.virt-manager.enable = true;

    # Podman (drop-in replacement for Docker)
    virtualisation.podman = {
      enable = true;
      dockerCompat = true; # `docker` alias for podman - drop-in replacement
      defaultNetwork.settings.dns_enabled = lib.mkDefault true; # Required for containers under podman-compose to be able to talk to each other.
    };

    # Misc Packages
    environment.systemPackages = let
      qemu-eufi = pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
        -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
        "$@"
      '';
    in
      with pkgs; [
        qemu
        qemu-eufi
        virtio-win
        distrobox # Tightly integrated Podman containers
        podman-tui
        podman-compose
      ];
  };
}

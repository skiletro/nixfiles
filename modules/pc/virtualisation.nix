{
  lib,
  pkgs,
  ...
}: {
  config = {
    virtualisation = {
      libvirtd = {
        enable = true;
        shutdownTimeout = 1; # https://superuser.com/questions/1784543/getting-cant-connect-to-default-error-on-shutdown-after-installing-virt-manag#1803752
        qemu.vhostUserPackages = with pkgs; [virtiofsd];
      };

      spiceUSBRedirection.enable = true;

      # Podman (drop-in replacement for Docker)
      podman = {
        enable = true;
        dockerCompat = true; # `docker` alias for podman - drop-in replacement
        defaultNetwork.settings.dns_enabled = lib.mkDefault true; # Required for containers under podman-compose to be able to talk to each other.
      };
    };

    programs.virt-manager.enable = true;

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

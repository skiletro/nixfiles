{pkgs, ...}: {
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  environment = {
    systemPackages = let
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
        quickemu # quickly create and run optimised vms
      ];
  };
}

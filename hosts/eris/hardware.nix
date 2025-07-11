{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Boot Hardware
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];
  boot.supportedFilesystems = ["ntfs"];

  # Drives
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/94e933e3-aaf9-4cf3-b7c9-044306fce269";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F4AF-09F7";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/ae2dc9bc-8451-48f4-a42b-916e449f30b8";}
  ];

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # CPU
  hardware.cpu.amd = {
    updateMicrocode = true;
    ryzen-smu.enable = true;
  };
}

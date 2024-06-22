{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "eris";

  userConfig = {
    # Core Settings
    greeter = {
      enable = true;
      type = "sddm";
    };

    desktop = {
      enable = true;
      environments = ["plasma"];
      terminalEmulator = "alacritty";
    };
  };

  # Bootloader
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  # Using kernel 6.6, latest (6.9) version doesn't play nicely with nvidia for whatever reason
  # Revisit this as soon as there's an update to the situation
  boot.kernelPackages = pkgs.linuxPackages;

  # Nvidia Graphics Drivers
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    # Beta 555 drivers for explicit sync
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "555.42.02";
      sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
      sha256_aarch64 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
      openSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
      settingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
      persistencedSha256 = lib.fakeSha256;
    };
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
  };
  # noveau drivers don't work very well, adding this to stop them from interfering
  boot.blacklistedKernelModules = ["nouveau"];

  # Configure console keymap
  console.keyMap = "uk";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

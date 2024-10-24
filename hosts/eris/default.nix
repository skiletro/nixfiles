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
    programs.graphical.chrome.enable = false;
    programs.graphical.emacs.enable = false;
  };

  # Bootloader
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Nvidia Graphics Drivers
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
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

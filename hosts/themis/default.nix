{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "themis";

  userConfig = {
    greeter = {
      enable = true;
      type = "greetd";
    };

    desktop = {
      enable = true;
      environments = ["hyprland"];
      terminalEmulator = "alacritty";
      scaling = {
        enable = true;
        multiplier = 1.25;
      };
    };

    programs.graphical.gaming.enable = false;
  };

  # Bootloader
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 14;
    };
    efi.canTouchEfiVariables = true;
  };

  # Laptop battery optimisation
  powerManagement.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;
    };
  };

  # Enable touchpad support
  services.libinput.enable = true;

  # Bluetooth support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  hardware.cpu.amd.updateMicrocode = true;

  environment.systemPackages = let
    montool = pkgs.writeShellScriptBin "montool" ''
        toggle_bar() {
          eww close bar
          eww open bar
        }

        toggle_on() {
          hyprctl keyword monitor "DP-1, 1920x1080@120, auto, 1"
          hyprctl keyword monitor "eDP-1, disable"
          sleep 1.5
          toggle_bar
        }

        toggle_off() {
          hyprctl reload
          sleep 1.5
          toggle_bar
        }

        case "$1" in
          on)
            toggle_on >/dev/null
            echo "Done!"
          ;;

          off)
            toggle_off >/dev/null
            echo "Done!"
          ;;

          *)
          cat <<-EOF
      montool - quick script written to toggle laptop screen on and off

      Commands:
        on    Turn off laptop and turn on dedicated monitor
        off   Turn back on laptop monitor
      EOF
          ;;
        esac
    '';
  in
    with pkgs; [montool];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

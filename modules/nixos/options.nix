{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  cfg = config.eos;
in {
  options.eos = {
    system = {
      user = mkOption {
        type = types.str;
        default = "jamie";
        description = "Specify the default username for the user.";
      };

      gpu = mkOption {
        type = types.nullOr (types.enum ["amd" "nvidia"]);
        default = null;
        description = "Specify the GPU - responsible for installing drivers and ensuring compatibility with certain applications.";
      };

      greeter = mkOption {
        type = types.nullOr (types.enum ["gdm" "sddm"]);
        default = null;
      };

      desktop = mkOption {
        type = types.nullOr (types.enum ["gnome" "plasma"]);
        default = null;
      };
    };

    programs = {
      enable =
        mkEnableOption "all programs"
        // {
          default = true;
        };

      graphical.enable =
        mkEnableOption "graphical programs"
        // {
          default = cfg.programs.enable;
        };

      terminal.enable =
        mkEnableOption "terminal programs"
        // {
          default = cfg.programs.enable;
        };

      gaming.enable =
        mkEnableOption "games and gaming utilities"
        // {
          default = cfg.programs.enable;
        };

      vr.enable =
        mkEnableOption "wivrn and VR utilities"
        // {
          default = cfg.programs.gaming.enable;
        };

      extraPrograms = mkOption {
        type = types.listOf types.package;
        description = "Extra packages to install that do not have a dedicated option.";
        default = [];
      };
    };

    tooling = {
      enable =
        mkEnableOption "programming tooling. E.g., LSPs, runtimes, etc."
        // {
          default = true;
        };

      go.enable =
        mkEnableOption "Go tooling"
        // {
          default = cfg.tooling.enable;
        };

      nix.enable =
        mkEnableOption "Nix tooling"
        // {
          default = cfg.tooling.enable;
        };

      rust.enable =
        mkEnableOption "Rust tooling"
        // {
          default = cfg.tooling.enable;
        };

      web.enable =
        mkEnableOption "Web (HTML/CSS/JS) tooling"
        // {
          default = cfg.tooling.enable;
        };

      python.enable =
        mkEnableOption "Python tooling"
        // {
          default = cfg.tooling.enable;
        };
    };

    services = {
      enable =
        mkEnableOption "all background services"
        // {
          default = true;
        };

      rnnoise.enable =
        mkEnableOption "RNNoise Pipewire Microphone Noise Suppression"
        // {
          default = cfg.services.enable;
        };

      rclone.enable =
        mkEnableOption "Rclone Documents Syncing"
        // {
          default = cfg.services.enable;
        };

      sunshine.enable =
        mkEnableOption "Sunshine Game Streaming"
        // {
          default = cfg.services.enable;
        };

      wireguard.enable =
        mkEnableOption "WireGuard"
        // {
          default = cfg.services.enable;
        };
    };
  };

  config = {
    environment.systemPackages = cfg.programs.extraPrograms;

    assertions = builtins.concatLists [
      (lib.optionals (cfg.system.gpu == null) [
        {
          assertion = !cfg.programs.graphical.enable;
          message = "eos: cannot install graphical applications without a gpu declared.";
        }
        {
          assertion = !cfg.programs.gaming.enable;
          message = "eos: cannot install games and gaming utilities without a gpu declared.";
        }
        {
          assertion = !cfg.programs.vr.enable;
          message = "eos: cannot install WiVRn and other VR utilies without a gpu declared.";
        }
      ])
    ];
  };
}

{
  lib,
  config,
  pkgs,
  inputs',
  ...
}: {
  config = lib.mkIf config.eos.programs.gaming.enable {
    programs.steam = {
      enable = true;
      # The thought process behind both declaratively installing Proton builds and manually installing them
      # is that I can use the declarative version for most games, and games that need tweaking can use the
      # versions installed by ProtonPlus, as to retain compatability with protontricks and winetricks.
      # (For whatever reason, the declarative versions do not play nicely with protontricks at all).
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        steam-play-none
        # TODO: Package and add proton-cachyos
      ];
      extest.enable = true;
      protontricks.enable = true;
    };

    environment.systemPackages = with pkgs; [
      # Tools
      lutris
      gamescope_git
      winetricks
      protonplus
      sgdboop

      # Launchers
      r2modman # Thunderstore Mod Manager (Think Lethal Company, derivationStrict)
      (prismlauncher.override {
        jdks = with pkgs; [
          graalvmPackages.graalvm-oracle
          graalvmPackages.graalvm-oracle_17
          temurin-jre-bin-8
        ];
      })
      heroic # Epic Games, GOG, Amazon Games
      osu-lazer-bin

      # Emulators
      dolphin-emu # Wii, Gamecube
      ryujinx # Switch
      cemu # Wii U
    ];

    home-manager.sharedModules = lib.singleton {
      programs.mangohud = {
        enable = true;
        enableSessionWide = false;
      };

      xdg.autostart.entries = [
        (
          (pkgs.makeDesktopItem {
            desktopName = "Steam Silent";
            name = "steam-silent";
            destination = "/";
            noDisplay = true;
            exec = "${lib.getExe config.programs.steam.package} -silent -console";
          })
          + /steam-silent.desktop
        )
      ];
    };

    boot.kernel.sysctl."vm.max_map_count" = 2147483642;

    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 15;
        };
        custom = let
          powerprofilesctl = lib.getExe pkgs.power-profiles-daemon;
          gsr-notify = text: "${lib.getExe inputs'.nixpkgs-gsr-ui.legacyPackages.gpu-screen-recorder-notification} --timeout 1.5 --bg-color ${config.lib.stylix.colors.base0E} --text '${text}'";
        in {
          start =
            (pkgs.writeShellScript "gamemode-start"
              # sh
              ''
                ${powerprofilesctl} set performance
                ${gsr-notify "Gamemode optimisations activated."}
              '').outPath;
          end =
            (pkgs.writeShellScript "gamemode-end"
              # sh
              ''
                ${powerprofilesctl} set power-saver
                ${gsr-notify "Gamemode optimisations deactivated."}
              '').outPath;
        };
      };
    };

    services.flatpak.packages = [
      "com.github._0negal.Viper" # Titanfall 2
      "org.vinegarhq.Sober" # Roblox
      "io.github.TeamWheelWizard.WheelWizard" # mkwii mod manager
    ];

    # HDR
    environment.variables = {
      DXVK_HDR = "1";
      ENABLE_HDR_WSI = "1";
    };

    hardware.graphics.extraPackages = [pkgs.nur.repos.xddxdd.vk-hdr-layer];
  };
}

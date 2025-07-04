{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./gsr.nix
    ./vr.nix
  ];

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
      nur.repos.skiletro.sgdboop

      # Launchers
      r2modman # Thunderstore Mod Manager (Think Lethal Company, derivationStrict)
      (prismlauncher.override {
        jdks = with pkgs; [
          graalvmPackages.graalvm-oracle
          graalvmPackages.graalvm-oracle_17
          temurin-jre-bin-8
        ];
      })

      # Emulators
      dolphin-emu # Wii, Gamecube
      ryujinx # Switch
      cemu # Wii U
    ];

    boot.kernel.sysctl."vm.max_map_count" = 2147483642;

    programs.gamemode = {
      enable = true;
      enableRenice = true;
    };

    services.flatpak.packages = [
      "com.heroicgameslauncher.hgl" # Epic Games, GOG, etc.
      "sh.ppy.osu" # Osu!
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

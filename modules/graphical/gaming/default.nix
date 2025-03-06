{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./emulators.nix
    ./vr.nix
  ];

  options.userConfig.gaming.enable = lib.mkEnableOption "Game Launchers: Steam, Heroic, etc.";

  config = lib.mkIf config.userConfig.gaming.enable {
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
      platformOptimizations.enable = true; # Handled by nix-gaming flake
    };

    environment.systemPackages = with pkgs; [
      # Tools
      lutris
      gamescope_git
      winetricks
      protontricks
      protonplus
      nur.repos.skiletro.steam-art-manager

      # Launchers
      r2modman # Thunderstore Mod Manager (Think Lethal Company, derivationStrict)
      (prismlauncher.override {
        jdks = with pkgs; [
          graalvmPackages.graalvm-oracle
          graalvmPackages.graalvm-oracle_17
          temurin-jre-bin-8
        ];
      })
    ];

    programs.gamemode = {
      enable = true;
      enableRenice = true;
    };

    services.flatpak.packages = [
      "com.dec05eba.gpu_screen_recorder" # ShadowPlay alternative
      "com.heroicgameslauncher.hgl" # Epic Games, GOG, etc.
      "sh.ppy.osu" # Osu!
      "com.github._0negal.Viper" # Titanfall 2
      {
        flatpakref = "https://sober.vinegarhq.org/sober.flatpakref"; # Roblox
        sha256 = "1pj8y1xhiwgbnhrr3yr3ybpfis9slrl73i0b1lc9q89vhip6ym2l";
      }
    ];
  };
}

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
      platformOptimizations.enable = true; # Handled by nix-gaming flake
    };

    environment.systemPackages =
      (with pkgs; [
        # Tools
        gamescope_git
        winetricks
        protontricks
        protonplus

        # Launchers
        lutris # Games that need extra configuration
        bottles # Same idea as Lutris, but has support for regular software too
        r2modman # Thunderstore Mod Manager (Think Lethal Company, derivationStrict)
        (prismlauncher.override {
          # Java Versions. Minecraft needs 8, 11, 17, and 21 as of 2024-10-25.
          jdks = with pkgs; [
            temurin-jre-bin-8
            temurin-jre-bin-11
            temurin-jre-bin-17
            temurin-jre-bin-21
          ];
        })
      ])
      ++ [
      ];

    programs.gamemode = {
      enable = true;
      enableRenice = true;
    };

    services.flatpak.packages = [
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

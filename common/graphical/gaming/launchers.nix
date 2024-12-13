{
  config,
  lib,
  pkgs,
  ...
}: {
  options.userConfig.gaming.launchers.enable = lib.mkEnableOption "Game Launchers: Steam, Heroic, etc.";

  config = lib.mkIf config.userConfig.gaming.launchers.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    environment.systemPackages = with pkgs; [
      # Tools
      gamescope
      protonup-qt # Modify Steam Proton versions

      # Launchers
      lutris # Games that need extra configuration
      bottles # Same idea as Lutris, but has support for regular software too
      heroic # Epic Games, Gog, and Amazon Prime Gaming
      r2modman # Thunderstore Mod Manager (Think Lethal Company, derivationStrict)
    ];
  };
}

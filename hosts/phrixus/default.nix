{
  config,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    inputs.jovian.nixosModules.default
  ];

  networking.hostName = "phrixus";

  eos = {
    system = {
      gpu = "amd";
      desktop = "plasma";
    };
    programs.enable = false; # We don't want any of the usual desktop things installed by default.
    services.enable = false; # We don't need any of the background services either.
  };

  jovian = {
    steam = {
      enable = true;
      autoStart = true;
      user = "jamie";
      desktopSession = config.eos.system.desktop;
    };
    decky-loader = {
      enable = true;
      inherit (config.jovian.steam) user;
    };
    hardware.has.amd.gpu = true;
  };

  services.flatpak.packages = [
    "org.kde.konsole"
    "app.zen_browser.zen" # Zen Browser
    "tv.plex.PlexHTPC" # Plex
    "com.github.iwalton3.jellyfin-media-player" # Jellyfin
  ];
}

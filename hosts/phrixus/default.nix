{
  imports = [
    ./hardware.nix
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

  services.flatpak.packages = [
    "app.zen_browser.zen" # Zen Browser
    "tv.plex.PlexHTPC" # Plex
    "com.github.iwalton3.jellyfin-media-player" # Jellyfin
  ];
}

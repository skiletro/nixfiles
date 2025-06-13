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

  # Fixes boot times taking forever. If for whatever reason this config doesn't get activated,
  # Running `systemctl --user mask steamos-manager.service` on-device will fix it.
  systemd.user.services."steamos-manager" = {
    enable = false;
    unitConfig.Mask = true;
  };

  services.flatpak.packages = [
    "org.chromium.Chromium" # Chromium
    "org.kde.konsole" # Konsole
    "tv.plex.PlexHTPC" # Plex
    "com.github.iwalton3.jellyfin-media-player" # Jellyfin
    "rocks.shy.VacuumTube" # YouTube
    "com.moonlight_stream.Moonlight" # Moonlight Game Streaming
  ];
}

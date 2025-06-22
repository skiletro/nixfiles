{pkgs, ...}: {
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "phrixus";

  eos = {
    system = {
      gpu = "amd";
      desktop = "plasma";
    };
    services.enable = false;
    programs = {
      enable = false;
      extraPrograms = with pkgs; [
        nur.repos.skiletro.vacuumtube
      ];
    };
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
    "com.moonlight_stream.Moonlight" # Moonlight Game Streaming
  ];
}

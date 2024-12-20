{
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}: {
  imports = [inputs.spicetify.homeManagerModules.default];

  config = lib.mkIf osConfig.userConfig.programs.spotify.enable {
    programs.spicetify = let
      spicetify = inputs.spicetify.legacyPackages.${pkgs.system};
    in {
      enable = true;

      enabledExtensions = with spicetify.extensions; [
        songStats
      ];

      enabledCustomApps = with spicetify.apps; [
        newReleases
        lyricsPlus
      ];
    };

    # We are overriding the default .desktop file because of GNOME and their stupid CSDs.
    # This should force Spotify to run under XWayland, giving us nicer window decorations.
    xdg.desktopEntries.spotify = {
      name = "Spotify";
      genericName = "Music Player";
      icon = "spotify-client";
      exec = "env -u WAYLAND_DISPLAY spotify %U";
      terminal = false;
      categories = ["Audio" "Music" "Player" "AudioVideo"];
      mimeType = ["x-scheme-handler/spotify"];
    };
  };
}

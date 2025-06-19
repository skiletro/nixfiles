{
  pkgs,
  inputs,
  inputs',
  lib,
  osConfig,
  ...
}: {
  imports = [inputs.spicetify.homeManagerModules.default];
  config = lib.mkIf osConfig.eos.programs.enable {
    stylix.targets.spicetify.enable = false; # The default spicetify theme colours kinda suck

    programs.spicetify = let
      inherit (inputs'.spicetify.legacyPackages) extensions apps;
    in {
      enable = true;

      enabledExtensions = with extensions; [
        songStats
      ];

      enabledCustomApps = with apps; [
        newReleases
        lyricsPlus
      ];

      theme = {
        name = "stylix";
        src = pkgs.writeTextFile {
          name = "color.ini";
          destination = "/color.ini";
          text = with osConfig.lib.stylix.colors; ''
            [base]
            text               = ${base05}
            subtext            = ${base05}
            main               = ${base00}
            main-elevated      = ${base02}
            highlight          = ${base02}
            highlight-elevated = ${base03}
            sidebar            = ${base01}
            player             = ${base02}
            card               = ${base00}
            shadow             = ${base00}
            selected-row       = ${base05}
            button             = ${base0B}
            button-active      = ${base05}
            button-disabled    = ${base03}
            tab-active         = ${base0B}
            notification       = ${base0B}
            notification-error = ${base08}
            equalizer          = ${base0B}
            misc               = ${base00}
          '';
        };
        # Sidebar configuration is incompatible with the default navigation bar
        sidebarConfig = false;
      };
      colorScheme = "base";
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

    # Here we can also install ncspot, a lightweight TUI program if the main client
    # is a bit too much for whatever workload we're up to.
    programs.ncspot = {
      enable = true;
      package = pkgs.ncspot.override {
        withCover = true; # Show cover art in terminals that support it!
        withNotify = false; # No notifications, please!
      };
    };
  };
}

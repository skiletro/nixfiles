{
  pkgs,
  lib,
  config,
  ...
}: {
  options.eos.internal.gnome-extensions = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = [];
  };

  config = lib.mkIf (config.eos.system.desktop == "gnome") {
    services.desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [pkgs.nautilus]; # fix ding ext
    };

    environment.gnome.excludePackages = with pkgs; [
      epiphany
      evince
      geary
      gnome-connections
      gnome-contacts
      gnome-console
      gnome-maps
      gnome-music
      gnome-tour
      gnome-software
      seahorse
      simple-scan
      totem
      xorg.xprop # fixes notif spam with unite extension
    ];

    services.tlp.enable = lib.mkForce false; # Gnome power management takes priority over `tlp`

    eos.internal.gnome-extensions = with pkgs.gnomeExtensions; [
      appindicator
      dash-to-dock
      gtk4-desktop-icons-ng-ding
      mpris-label
      search-light
      smile-complementary-extension
      unite
      weather-oclock
    ];

    environment = {
      systemPackages =
        (with pkgs; [
          adwaita-icon-theme # fixes some missing icons
          gapless
          gjs # fixes ding ext
          libheif
          libheif.out # HEIC Image Previews
          mission-center # Task Manager
          papers
          showtime # Video Player
          smile
        ])
        ++ config.eos.internal.gnome-extensions;
      pathsToLink = ["share/thumbnailers"];
    };

    services.udev.packages = [pkgs.gnome-settings-daemon];

    nixpkgs.overlays = [
      (_final: prev: {
        # Nautilus GStreamer support, see: https://wiki.nixos.org/wiki/Nautilus#Gstreamer
        nautilus = prev.nautilus.overrideAttrs (nprev: {
          buildInputs =
            nprev.buildInputs
            ++ (with pkgs.gst_all_1; [
              gst-plugins-good
              gst-plugins-bad
            ]);
        });
      })
    ];
  };
}

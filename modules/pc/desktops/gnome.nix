{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.eos.system.desktop == "gnome") {
    services.desktopManager.gnome.enable = true;

    environment.gnome.excludePackages = with pkgs; [
      epiphany
      geary
      gnome-connections
      gnome-contacts
      gnome-console
      gnome-maps
      gnome-tour
      gnome-software
      seahorse
      simple-scan
    ];

    services.tlp.enable = lib.mkForce false; # Gnome power management takes priority over `tlp`

    environment = {
      systemPackages =
        (with pkgs; [
          adwaita-icon-theme # fixes some missing icons
          libheif
          libheif.out # HEIC Image Previews
          mission-center # Task Manager
          showtime # Video Player (Totem replacement)
          smile
        ])
        ++ (with pkgs.gnomeExtensions; [
          appindicator
          dash-to-dock
          mpris-label
          smile-complementary-extension
          weather-oclock
        ]);
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

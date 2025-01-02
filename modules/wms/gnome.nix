{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  config = lib.mkIf (builtins.elem "gnome" config.userConfig.desktop.environments) {
    services.xserver.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = with pkgs; [
      epiphany
      geary
      gnome-connections
      gnome-contacts
      gnome-console
      gnome-maps
      gnome-tour
      gnome-software
      gnome-weather
      seahorse
      simple-scan
    ];
    services.tlp.enable = lib.mkForce false; # Gnome power management takes priority over `tlp`

    environment.systemPackages =
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
        blur-my-shell
        dash-to-dock
        mpris-label
        smile-complementary-extension
      ]);

    environment.pathsToLink = ["share/thumbnailers"];

    services.udev.packages = [pkgs.gnome-settings-daemon];

    nixpkgs.overlays = [
      (_final: prev: {
        mutter = prev.mutter.overrideAttrs (_oldAttrs: {
          src = inputs.mutter-triple-buffering-src;
          preConfigure = ''
            cp -a "${inputs.gvdb-src}" ./subprojects/gvdb
          '';
        });
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

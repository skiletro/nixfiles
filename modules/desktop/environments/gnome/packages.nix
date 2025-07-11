{
  lib,
  config,
  ...
}: {
  options.eos.desktop.gnome.enable = lib.mkEnableOption "GNOME desktop environment" // {enable = false;};

  config = lib.mkIf config.eos.desktop.gnome.enable {
    flake.modules.nixos.desktop = {pkgs, ...}: {
      services = {
        displayManager.gdm.enable = true;
        desktopManager.gnome = {
          enable = true;
          extraGSettingsOverridePackages = [pkgs.nautilus]; # fix ding ext
        };
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
      ];

      services.tlp.enable = lib.mkForce false; # Gnome power management takes priority over `tlp`

      environment = {
        systemPackages = with pkgs; [
          adwaita-icon-theme # fixes some missing icons
          gapless
          gjs # fixes ding ext
          libheif
          libheif.out # HEIC Image Previews
          mission-center # Task Manager
          papers
          showtime # Video Player
          smile
          xorg.xprop # fixes notif on wake in some circumstances - to do with extension
        ];
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

    flake.modules.homeManager.jamie = {pkgs, ...}: let
      extensions = with pkgs.gnomeExtensions; [
        appindicator
        dash-to-dock
        gtk4-desktop-icons-ng-ding
        mpris-label
        search-light
        smile-complementary-extension
        unite
        weather-oclock
      ];
    in {
      home.packages = extensions;

      dconf.settings."org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = map (ext: ext.extensionUuid) extensions ++ lib.singleton "user-theme@gnome-shell-extensions.gcampax.github.com";
      };
    };
  };
}

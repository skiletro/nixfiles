{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib.gvariant) mkTuple;
  inherit (lib) getExe mkForce;

  extensions = with pkgs.gnomeExtensions; [
    accent-directories
    appindicator
    color-picker
    dash-to-dock
    gtk4-desktop-icons-ng-ding
    mpris-label
    search-light
    smile-complementary-extension
    unite
    weather-oclock
  ];
in {
  config = lib.mkIf (config.eos.system.desktop == "gnome") {
    home-manager.sharedModules = lib.singleton (userArgs: {
      stylix.iconTheme = {
        enable = true;
        package = pkgs.morewaita-icon-theme;
        dark = "MoreWaita";
        light = "MoreWaita";
      };

      dconf.enable = true;
      dconf.settings = {
        "org/gnome/mutter" = {
          attach-modal-dialogs = false;
          center-new-windows = true;
          dynamic-workspaces = true;
          edge-tiling = true;
          experimental-features = ["scale-monitor-framebuffer" "variable-refresh-rate"];
        };

        "org/gnome/shell".favorite-apps = [
          "zen-twilight.desktop"
          "org.gnome.Nautilus.desktop"
          "thunderbird.desktop"
          "com.mitchellh.ghostty.desktop"
          "discord.desktop"
          "spotify.desktop"
          "steam.desktop"
          "chrome-fjpeaicnionajpipomepndgbcpchdmlb-Default.desktop" # Instagram PWA
          "writer.desktop"
          "calc.desktop"
        ];

        "org/gnome/TextEditor" = {
          restore-session = false;
          style-variant = "light";
        };

        "org/gnome/desktop/interface" = {
          accent-color = "pink"; # Set this to whatever matches the colour scheme best.
          clock-format = "12h";
          clock-show-weekday = true;
          color-scheme = mkForce "prefer-dark"; # Stylix sets this value as light-mode for whatever reason.
          enable-animations = true;
          enable-hot-corners = false;
          gtk-enable-primary-paste = false;
        };

        "org/gnome/desktop/media-handling" = {
          autorun-never = true;
        };

        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "flat";
          speed = 0.7;
        };

        "org/gnome/desktop/peripherals/touchpad" = {
          two-finger-scrolling-enabled = true;
        };

        "org/gnome/desktop/wm/preferences" = {
          auto-raise = true;
          button-layout = "close,minimize,maximize:"; # macos style
          focus-mode = "click";
          num-workspaces = 1;
          resize-with-right-button = true;
        };

        "org/gnome/desktop/input-sources" = {
          sources = [
            (mkTuple [
              "xkb"
              "gb"
            ])
          ];
          xkb-options = [];
        };

        # Keybindings
        "org/gnome/settings-daemon/plugins/media-keys" = {
          # TODO: Write a function that makes this a bit nicer.
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
          ];
          home = ["<Super>e"];
          www = ["<Super>f"];
          calculator = ["<Super>c"];
        };

        # TODO: Probably also a function that generates these a bit nicer, preferably so I don't have to do the fuckery above ^^
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Super>Return";
          command = "${getExe userArgs.config.programs.ghostty.package}";
          name = "Launch Terminal";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          binding = "<Super>period";
          command = "smile";
          name = "Open Emoji Picker";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
          binding = "Launch9"; # F18
          command = "${getExe pkgs.playerctl} -p spotify volume 0.02+";
          name = "Spotify Volume Up";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
          binding = "Launch8"; # F17
          command = "${getExe pkgs.playerctl} -p spotify volume 0.02-";
          name = "SpotifyVolumeDown";
        };

        # Only enable these keybindings if we have GSR!
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = lib.mkIf config.eos.programs.gaming.enable {
          binding = "<Shift><Alt>F9";
          command = "gsr-ui-cli replay-save";
          name = "Capture Replay with GSR UI";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = lib.mkIf config.eos.programs.gaming.enable {
          binding = "<Super>z";
          command = "gsr-ui-cli toggle-show";
          name = "Launch GSR UI";
        };

        "org/gnome/shell/keybindings" = {
          show-screenshot-ui = ["<Shift><Super>s"];
        };

        "org/gnome/desktop/wm/keybindings" = {
          close = ["<Shift><Super>q"];
          show-desktop = ["<Shift><Super>d"];
          switch-to-workspace-1 = ["<Super>1"];
          switch-to-workspace-2 = ["<Super>2"];
          switch-to-workspace-3 = ["<Super>3"];
          switch-to-workspace-4 = ["<Super>4"];
          switch-to-workspace-5 = ["<Super>5"];
          minimize = ["<Shift><Super>c"];
          move-to-workspace-1 = ["<Shift><Super>1"];
          move-to-workspace-2 = ["<Shift><Super>2"];
          move-to-workspace-3 = ["<Shift><Super>3"];
          move-to-workspace-4 = ["<Shift><Super>4"];
          move-to-workspace-5 = ["<Shift><Super>5"];
          toggle-fullscreen = ["<Shift><Super>f"];
        };

        # Extensions
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = map (ext: ext.extensionUuid) extensions ++ lib.optional config.stylix.enable "user-theme@gnome-shell-extensions.gcampax.github.com";
        };

        "org/gnome/shell/extensions/appindicator" = {
          icon-opacity = 255;
          icon-size = 0;
          legacy-tray-enabled = false;
          tray-pos = "center";
        };

        "org/gnome/shell/extensions/dash-to-dock" = {
          apply-custom-theme = false;
          background-color = "rgb(36,31,49)";
          background-opacity = 0.8;
          click-action = "minimize-or-previews";
          custom-background-color = false;
          custom-theme-shrink = false;
          dash-max-icon-size = 48;
          disable-overview-on-startup = true;
          dock-fixed = false;
          dock-position = "LEFT";
          extend-height = false;
          height-fraction = 0.9;
          icon-size-fixed = true;
          intellihide-mode = "ALL_WINDOWS";
          middle-click-action = "quit";
          preferred-monitor = -2;
          preferred-monitor-by-connector = "DP-2";
          preview-size-scale = 0.0;
          running-indicator-style = "DOT";
          scroll-action = "do-nothing";
          shift-click-action = "launch";
          shift-middle-click-action = "launch";
          show-apps-at-top = false;
          show-mounts = true;
          show-mounts-only-mounted = true;
          show-show-apps-button = false;
          show-trash = false;
          transparency-mode = "DEFAULT";
          hot-keys = false;
        };

        "org/gnome/shell/extensions/blur-my-shell/dash-to-dock".pipeline = "pipeline_default";

        "org/gnome/shell/extensions/mpris-label" = {
          divider-string = " - ";
          extension-place = "center";
          icon-padding = 5;
          left-click-action = "play-pause";
          left-padding = 0;
          middle-click-action = "none";
          mpris-sources-blacklist = "Mozilla zen,Mozilla zen-twilight,Chromium";
          right-click-action = "open-menu";
          right-padding = 0;
          second-field = "";
          show-icon = "left";
          thumb-backward-action = "none";
          thumb-forward-action = "none";
          use-whitelisted-sources-only = false;
          extension-index = 0;
        };

        # Search Light
        "org/gnome/shell/extensions/search-light" = with config.lib.stylix.colors; let
          mkColor = r: g: b: mkTuple (map builtins.fromJSON [r g b] ++ [1.0]);
        in {
          "shortcut-search" = ["<Super>d"];
          "border-radius" = 1.1;
          "background-color" = mkColor base00-dec-r base00-dec-g base00-dec-b;
          "text-color" = mkColor base05-dec-r base05-dec-g base05-dec-b;
          "border-color" = mkColor base01-dec-r base01-dec-g base01-dec-b;
          "border-thickness" = 1;
          "scale-width" = 0.17;
          "scale-height" = 0.2;
          "popup-at-cursor-monitor" = true;
        };

        "org/gnome/shell/extensions/unite" = {
          "hide-activites-button" = "never";
          "use-activities-text" = false;
          "show-desktop-name" = false;
          "hide-window-titlebars" = "never";
          "show-window-buttons" = "never";
          "show-window-title" = "never";
        };

        # Ding
        "org/gnome/shell/extensions/gtk4-ding" = {
          start-corner = "top-right";
          show-drop-place = false;
          show-home = false;
          show-trash = false;
          show-volumes = false;
        };

        # Smile (Emoji Selector)
        "it/mijorus/smile" = {
          is-first-run = false;
          load-hidden-on-startup = true;
        };

        "org/gnome/shell/extensions/color-picker" = {
          enable-shortcut = true;
          color-picker-shortcut = ["<Super>l"];
          enable-systray = false;
        };
      };

      # Set Smile to start on startup, allowing for the emoji picker to open quicker.
      xdg.autostart.entries = [
        (
          (pkgs.makeDesktopItem {
            desktopName = "Smile Silent";
            name = "smile-silent";
            destination = "/";
            exec = "${lib.getExe pkgs.smile} --start-hidden";
            noDisplay = true;
          })
          + /smile-silent.desktop
        )
      ];
    });

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

    environment = {
      systemPackages =
        (with pkgs; [
          adwaita-icon-theme # fixes some missing icons
          adwaita-icon-theme-legacy # fixes some missing icons
          gapless
          gjs # fixes ding ext
          libheif
          libheif.out # HEIC Image Previews
          mission-center # Task Manager
          papers
          showtime # Video Player
          smile

          # Thumbnailers
          ffmpegthumbnailer # fixes video thumbnails without totem
          bign-handheld-thumbnailer # for nintendo ds and 3ds roms
          nufraw-thumbnailer # for raw images
          gnome-epub-thumbnailer # for epub and mobi books
        ])
        ++ extensions;
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

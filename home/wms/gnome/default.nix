{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf (builtins.elem "gnome" osConfig.userConfig.desktop.environments) {
    # Set icon theme through Stylix if we are using Gnome.
    # MoreWaita is just a bit of an expansion of the default Adwaita icons!
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

      "org/gnome/TextEditor" = {
        restore-session = false;
        style-variant = "light";
      };

      "org/gnome/desktop/interface" = {
        accent-color = "purple"; # Set this to whatever matches the wallpaper best.
        clock-format = "12h";
        clock-show-weekday = true;
        color-scheme = lib.mkForce "prefer-dark"; # Stylix sets this value as light-mode for whatever reason.
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
        button-layout = ":minimize,maximize,close";
        focus-mode = "click";
        num-workspaces = 1;
        resize-with-right-button = true;
      };

      # Keybindings
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"];
        home = ["<Super>e"];
        search = ["<Super>d"];
        www = ["<Super>f"];
        calculator = ["<Super>c"];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>Return";
        command = "${osConfig.userConfig.desktop.terminalEmulator}";
        name = "Launch Terminal";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>period";
        command = "smile";
        name = "Open Emoji Picker";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        binding = "Launch9";
        command = "${pkgs.playerctl}/bin/playerctl -p spotify volume 0.02+";
        name = "Spotify Volume Up";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
        binding = "<Shift>Launch9";
        command = "${pkgs.playerctl}/bin/playerctl -p spotify volume 0.02-";
        name = "SpotifyVolumeDown";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
        binding = "<Shift><Control><Alt>F11";
        command = "capture-replay";
        name = "Capture Replay";
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
        toggle-fullscreen = ["<Shift><Super>f"];
      };

      # Extensions
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          appindicator.extensionUuid
          blur-my-shell.extensionUuid
          dash-to-dock.extensionUuid
          mpris-label.extensionUuid
          smile-complementary-extension.extensionUuid
          weather-oclock.extensionUuid
        ];
      };

      "org/gnome/shell/extensions/appindicator" = {
        icon-opacity = 255;
        icon-size = 0;
        legacy-tray-enabled = false;
        tray-pos = "right";
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        apply-custom-theme = false;
        background-color = "rgb(36,31,49)";
        background-opacity = 0.8;
        click-action = "minimize-or-previews";
        custom-background-color = false;
        custom-theme-shrink = false;
        dash-max-icon-size = 32;
        disable-overview-on-startup = true;
        dock-fixed = true;
        dock-position = "LEFT";
        extend-height = true;
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
      };

      "org/gnome/shell/extensions/blur-my-shell/dash-to-dock".pipeline = "pipeline_default";

      "org/gnome/shell/extensions/mpris-label" = {
        divider-string = " - ";
        extension-place = "center";
        icon-padding = 5;
        left-click-action = "play-pause";
        left-padding = 0;
        middle-click-action = "none";
        mpris-sources-blacklist = "Mozilla zen,Chromium";
        right-click-action = "open-menu";
        right-padding = 0;
        second-field = "";
        show-icon = "left";
        thumb-backward-action = "none";
        thumb-forward-action = "none";
        use-whitelisted-sources-only = false;
      };

      # Smile (Emoji Selector)
      "it/mijorus/smile" = {
        is-first-run = false;
        load-hidden-on-startup = true;
      };
    };

    # Set Smile to start on startup, allowing for the emoji picker to open quicker.
    home.file.".config/autostart/smile.desktop".source = "${pkgs.writeText "smile.desktop" ''
      [Desktop Entry]
      Type=Application
      Name=smile
      Exec=smile --start-hidden
      X-Flatpak=smile
    ''}";
  };
}

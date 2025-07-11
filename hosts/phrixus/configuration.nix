{
  pkgs,
  lib,
  cfg,
  config,
  ...
}: let
  inherit (config.eos.system) user desktop;
in {
  eos = {
    system = {
      gpu = "amd";
      desktop = "plasma";
    };
    services.enable = false;
    programs = {
      enable = false;
      extraPrograms = with pkgs; [
        kdePackages.konsole
        nur.repos.skiletro.vacuumtube
      ];
    };
  };

  jovian = {
    steam = {
      enable = true;
      autoStart = true;
      desktopSession = desktop;
      inherit user;
    };
    decky-loader = {
      enable = true;
      inherit user;
    };
    hardware.has.amd.gpu = lib.mkIf (cfg.system.gpu == "amd") true;
  };

  system.activationScripts.enableCefForDeckyLoader =
    # sh
    ''
      if [ -d /home/${user}/.steam/steam/ ]; then
        FLAG=/home/${user}/.steam/steam/.cef-enable-remote-debugging
        touch $FLAG
        chown ${user}: $FLAG
      fi
    '';

  system.activationScripts.addReturnDesktopItem = let
    file = "/home/${user}/Desktop/Return to Gaming Mode.desktop";
  in
    # sh
    ''
      if [ ! -f "${file}" ]; then
        cat <<- "EOF" > "${file}"
        [Desktop Entry]
        Name=Return to Gaming Mode
        Exec=qdbus org.kde.Shutdown /Shutdown org.kde.Shutdown.logout
        Icon=steamdeck-gaming-return
        Terminal=false
        Type=Application
        StartupNotify=false
      EOF
        chown ${user}: "${file}"
      fi
    '';

  # Fixes boot times taking forever. If for whatever reason this config doesn't get activated,
  # Running `systemctl --user mask steamos-manager.service` on-device will fix it.
  systemd.user.services."steamos-manager" = {
    enable = false;
    unitConfig.Mask = true;
  };

  services.flatpak.packages = [
    "org.chromium.Chromium" # Chromium
    "tv.plex.PlexHTPC" # Plex
    "com.github.iwalton3.jellyfin-media-player" # Jellyfin
    "com.moonlight_stream.Moonlight" # Moonlight Game Streaming
  ];
}

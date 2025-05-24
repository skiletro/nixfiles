{
  config,
  lib,
  ...
}: let
  inherit (config.eos.system) user desktop;
  cfg = config.eos;
in {
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
}

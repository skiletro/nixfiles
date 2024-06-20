{
  lib,
  pkgs,
  config,
  ...
}: {
  config = lib.mkIf config.userConfig.gaming.vr.enable {
    programs.alvr = {
      enable = true;
      openFirewall = true;
    };

    services.monado = {
      enable = true;
      defaultRuntime = true;
    };
  };

  # Normal issue with NixOS
  # Run `sudo setcap CAP_SYS_NICE+ep ~/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrcompositor-launcher` on every update of SteamVR

  # https://github.com/alvr-org/ALVR/issues/2115
  # Set the launch option of SteamVR to `"/home/jamie/.local/share/Steam/steamapps/common/SteamVR/bin/vrmonitor.sh" %command%`
}

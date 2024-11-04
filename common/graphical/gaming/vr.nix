#TODO: VR-support in this flake needs to be completely redone, once I have the proper hardware to properly troubleshoot.
{
  lib,
  pkgs,
  config,
  ...
}: {
  options.userConfig.gaming.vr.enable = lib.mkEnableOption "Virtual Reality";

  config = lib.mkIf config.userConfig.gaming.vr.enable {
    environment.systemPackages = with pkgs; [
      wlx-overlay-s
    ];

    services.monado = {
      enable = true;
      defaultRuntime = false;
    };

    services.wivrn = {
      enable = true;
      openFirewall = true;

      # Write information to /etc/xdg/openxr/1/active_runtime.json, VR applications
      # will automatically read this and work with wivrn
      defaultRuntime = true;

      # Executing it through the systemd service executes WiVRn w/ CAP_SYS_NICE
      # Resulting in no stutters!
      autoStart = true;

      # Config for WiVRn (https://github.com/WiVRn/WiVRn/blob/master/docs/configuration.md)
      config = {
        enable = true;
        json = {
          # 1.0x display scaling
          scale = 1.0;
          # 100 Mb/s
          bitrate = 100000000;
          encoders = [
            {
              encoder = "x264";
              codec = "h264";
              # 1.0 x 1.0 scaling
              width = 1.0;
              height = 1.0;
              offset_x = 0.0;
              offset_y = 0.0;
            }
          ];
        };
      };
    };
  };

  # Normal issue with NixOS
  # Run `sudo setcap CAP_SYS_NICE+ep ~/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrcompositor-launcher` on every update of SteamVR

  # https://github.com/alvr-org/ALVR/issues/2115
  # Set the launch option of SteamVR to `"/home/jamie/.local/share/Steam/steamapps/common/SteamVR/bin/vrmonitor.sh" %command%`
}

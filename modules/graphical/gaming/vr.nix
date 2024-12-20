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

    services.wivrn = {
      enable = true;
      package = pkgs.wivrn.override {
        cudaSupport = config.userConfig.system.gpu == "nvidia";
      };
      openFirewall = true;
      defaultRuntime = true; # Default runtime for SteamVR games set in HM module.
    };
  };

  # --- Instructions ---
  # Ensure you add the following launch argument to Steam games to allow them to run under OpenComposite and therefore WiVRn
  # `PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/wivrn/comp_ipc %command%`
  #
  # In order to get audio working, you need to set the sound output to the output created by WiVRn when the headset connects.
  # For the microphone, it is the same process, however you also need to make sure that the microphone is enabled in the WiVRn settings on the headset itself.
}

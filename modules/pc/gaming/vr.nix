{
  lib,
  pkgs,
  config,
  ...
}: {
  config = lib.mkIf config.eos.programs.vr.enable {
    environment.systemPackages = with pkgs; [
      bs-manager # Beat Saber Mod Manager
      wlx-overlay-s # In-game overlay
      android-tools # Allows for wired WiVRn
    ];

    services.wivrn = {
      enable = true;
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

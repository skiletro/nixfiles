{
  lib,
  pkgs,
  config,
  inputs',
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
      package = pkgs.wivrn.override {
        cudaSupport = true;
      };
      openFirewall = true;
      defaultRuntime = true; # Default runtime for SteamVR games set in HM module.
    };

    programs.steam.package = lib.mkDefault (
      pkgs.steam.override (prev: {
        extraEnv =
          {
            PRESSURE_VESSEL_FILESYSTEMS_RW = "$XDG_RUNTIME_DIR/wivrn/comp_ipc";
          }
          // (prev.extraEnv or {});
      })
    );

    home-manager.sharedModules = lib.singleton (userAttrs: {
      # This assumes a WiVRn configuration
      xdg.configFile."openxr/1/active_runtime.json".source = "${config.services.wivrn.package}/share/openxr/1/openxr_wivrn.json";

      xdg.configFile."openvr/openvrpaths.vrpath".text = ''
        {
          "config" :
          [
            "${userAttrs.config.xdg.dataHome}/Steam/config"
          ],
          "external_drivers" : null,
          "jsonid" : "vrpathreg",
          "log" :
          [
            "${userAttrs.config.xdg.dataHome}/Steam/logs"
          ],
          "runtime" :
          [
            "${pkgs.opencomposite}/lib/opencomposite"
          ],
          "version" : 1
        }
      '';

      xdg.configFile."wlxoverlay/wayvr.yaml".source = (pkgs.formats.yaml {}).generate "wayvr.yaml" {
        version = 1;
        run_compositor_at_start = false;
        auto_hide = true;
        auto_hide_delay = 750;

        dashboard = {
          exec = lib.getExe inputs'.nixpkgs-xr.packages.wayvr-dashboard;
          blit_method = "software";
          env = [
            "GDK_BACKEND=wayland"
            "WEBKIT_DISABLE_DMABUF_RENDERER=1"
            "WEBKIT_DISABLE_COMPOSITING_MODE=1"
          ];
        };
      };
    });
  };

  # --- Instructions ---
  # Ensure you add the following launch argument to Steam games to allow them to run under OpenComposite and therefore WiVRn
  # `PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/wivrn/comp_ipc %command%`
  #
  # In order to get audio working, you need to set the sound output to the output created by WiVRn when the headset connects.
  # For the microphone, it is the same process, however you also need to make sure that the microphone is enabled in the WiVRn settings on the headset itself.
}

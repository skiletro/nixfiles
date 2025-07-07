{
  lib,
  config,
  osConfig,
  pkgs,
  inputs',
  ...
}: {
  config = lib.mkIf osConfig.eos.programs.vr.enable {
    # This assumes a WiVRn configuration
    xdg.configFile."openxr/1/active_runtime.json".source = "${osConfig.services.wivrn.package}/share/openxr/1/openxr_wivrn.json";

    xdg.configFile."openvr/openvrpaths.vrpath".text = ''
      {
        "config" :
        [
          "${config.xdg.dataHome}/Steam/config"
        ],
        "external_drivers" : null,
        "jsonid" : "vrpathreg",
        "log" :
        [
          "${config.xdg.dataHome}/Steam/logs"
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
        env = ["GDK_BACKEND=wayland"];
      };
    };
  };
}

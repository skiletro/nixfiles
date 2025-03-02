{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.gaming.vr.enable {
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
  };
}

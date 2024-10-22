{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}: {
  imports = [
    ./prismlauncher
    ./steam
  ];

  config = lib.mkIf osConfig.userConfig.programs.graphical.gaming.enable {
    home.packages = with pkgs; [
      # Tools
      gamescope
      protonup-qt #modify steam proton versions
      parsec-bin

      # Launchers
      lutris #non-steam games that need extra tweaking
      bottles #same idea as lutris
      heroic #epic games & gog - disabled due to security (electron)
    ];

    programs.mangohud = {
      enable = true;
      enableSessionWide = false; # Need to test to see if it crashes gamescope with workaround implem.
      # TODO: Need to customise more
    };

    xdg.configFile."openxr/1/active_runtime.json".text = ''
      {
        "file_format_version": "1.0.0",
        "runtime": {
            "name": "Monado",
            "library_path": "${pkgs.monado}/lib/libopenxr_monado.so"
        }
      }
    '';

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

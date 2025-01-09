{
  lib,
  config,
  pkgs,
  ...
}: {
  options.userConfig.programs.chromium.enable = lib.mkEnableOption "Vial, a keyboard configurator";

  config = lib.mkIf config.userConfig.programs.chromium.enable {
    environment.systemPackages = with pkgs; [chromium]; # For whatever reason, programs.chromium.enable doesn't actually add the package.

    programs.chromium = {
      enable = true;
      extensions = [
        "gjkjjhgjcalgefcimahpbacihndicccn" # Remove Ads from Photopea
        "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
      ];
      extraOpts = {
        WebAppInstallForceList =
          lib.lists.forEach [
            {
              custom_name = "Photopea";
              url = "https://www.photopea.com";
            }
            {
              custom_name = "Plex";
              url = "https://app.plex.tv/desktop/#!";
            }
            {
              custom_name = "Instagram";
              url = "https://www.instagram.com";
            }
            {
              custom_name = "WhatsApp";
              url = "https://web.whatsapp.com";
            }
            {
              custom_name = "Netflix";
              url = "https://www.netflix.com";
            }
          ] (attr:
            attr
            // {
              install_as_shortcut = true;
              default_launch_container = "window";
            });
      };
    };

    nixpkgs.overlays = [
      (_final: prev: {
        chromium = prev.chromium.override (_oldAttrs: {
          enableWideVine = true;
        });
      })
    ];
  };
}

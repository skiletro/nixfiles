{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.eos.programs.graphical.enable {
    environment.systemPackages = with pkgs; [chromium]; # For whatever reason, programs.chromium.enable doesn't actually add the package.

    programs.chromium = {
      enable = true;
      extensions = [
        "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
      ];
      extraOpts = {
        WebAppInstallForceList =
          lib.lists.forEach [
            {
              custom_name = "Plex";
              url = "https://app.plex.tv/desktop/#!";
            }
            {
              custom_name = "Instagram";
              url = "https://www.instagram.com";
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
          widevine-cdm = pkgs.widevine-cdm.overrideAttrs (_oldAttrs: {
            src = pkgs.fetchzip {
              url = "https://alien.slackbook.org/slackbuilds/chromium-widevine-plugin/build/4.10.2891.0-linux-x64.zip";
              hash = "sha256-ZO6FmqJUnB9VEJ7caJt58ym8eB3/fDATri3iOWCULRI";

              ## builds just fine, but fails to play DRM content - PEBCAK?
              #url = "https://dl.google.com/widevine-cdm/1.4.9.1088-linux-x64.zip";
              #hash = "sha256-AT/LlX1q5LuoB+xxgYRQlEKhhCmw37q7FET3IavSzJo";

              stripRoot = false;
            };
          });
        });
      })
    ];
  };
}

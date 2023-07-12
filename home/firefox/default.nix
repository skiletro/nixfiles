{ config, pkgs, lib, inputs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
        DontCheckDefaultBrowser = true;
        FirefoxHome = {
          Search = true;
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
        ExtensionSettings = {};
      };
    };
    profiles.jamie = {
      id = 0;
      isDefault = true;
      name = "jamie";
      search = {
        force = true;
        default = "DuckDuckGo";
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@n" ];
          };
        };
      };
      settings = {
        "general.smoothScroll" = true;
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        ublock-origin
        sponsorblock
        stylus
        augmented-steam
        fediact
        #bypass-paywalls-clean
      ];
      #extraConfig
      #userChrome
      #userContent
    };
  };
}

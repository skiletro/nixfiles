{
  inputs,
  lib,
  osConfig,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.twilight];

  config = lib.mkIf osConfig.eos.programs.enable {
    programs.zen-browser = {
      enable = true;
      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
      };
      profiles."default" = {}; # TODO: Declare extensions
    };

    stylix.targets.zen-browser.profileNames = lib.singleton "default";
  };
}

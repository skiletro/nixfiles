{
  lib,
  pkgs,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.discord.enable {
    home.packages = [
      # Remember to enable the Stylix theme in the Vencord settings!
      (pkgs.discord.override {
        withVencord = true;
      })
    ];
  };
}

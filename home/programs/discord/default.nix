{
  lib,
  pkgs,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.discord.enable {
    home.packages = with pkgs; [discord-canary];

    # Overriding default .desktop file because the default one doesn't recognise canary as part of the actual Discord app (gnome issue)
    xdg.desktopEntries.discord-canary = {
      name = "Discord Canary";
      genericName = "All-in-one cross-platform voice and text chat for gamers";
      icon = "discord-canary";
      exec = "DiscordCanary";
      mimeType = ["x-scheme-handler/discord"];
      categories = ["Network" "InstantMessaging"];
      settings = {
        Version = "1.4";
        StartupWMClass = "discord";
      };
    };
  };
}

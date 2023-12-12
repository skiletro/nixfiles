{...}: {
  xdg = {
    enable = true;
    mimeApps.enable = true;
    mimeApps.defaultApplications = let
      browser = ["firefox.desktop"];
      mediaPlayer = ["mpv.desktop"];
    in {
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xht" = browser;
      "application/x-extension-xhtml" = browser;
      "application/xhtml+xml" = browser;
      "text/html" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/ftp" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/unknown" = browser;

      "audio/*" = mediaPlayer;
      "video/*" = mediaPlayer;
      "image/*" = ["nomacs.desktop"];
      "text/plain" = ["nvim.desktop"];
      "application/json" = browser;
      "application/pdf" = browser;
      "application/zip" = ["org.gnome.FileRoller.desktop"];

      "x-scheme-handler/msteams" = ["teams-for-linux.desktop"];
      "x-scheme-handler/element" = ["Beeper.desktop"];
      "x-scheme-handler/discord" = ["webcord.desktop"];
      "x-scheme-handler/spotify" = ["spotify.desktop"];
      "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
    };
  };
}

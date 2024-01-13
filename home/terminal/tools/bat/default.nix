{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "catppuccin-mocha";
    };
  };

  xdg.configFile."bat/themes/catppuccin-mocha.tmTheme".source = pkgs.fetchurl {
    url = "https://raw.g5ithubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme";
    sha256 = "1z434yxjq95bbfs9lrhcy2y234k34hhj5frwmgmni6j8cqj0vi58";
  };

  programs.fish.shellAbbrs = {
    cat = "bat";
  };
}

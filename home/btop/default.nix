{pkgs, ...}: {
  xdg.configFile."btop/themes/catppuccin_mocha.theme".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/btop/89ff712eb62747491a76a7902c475007244ff202/themes/catppuccin_mocha.theme";
    hash = "sha256-TeaxAadm04h4c55aXYUdzHtFc7pb12e0wQmCjSymuug=";
  };
}

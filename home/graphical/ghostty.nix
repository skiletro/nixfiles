{
  lib,
  osConfig,
  pkgs,
  inputs',
  ...
}: {
  config = lib.mkIf (osConfig.eos.system.desktop == "gnome") {
    programs.ghostty = {
      enable = true;
      package = inputs'.ghostty.packages.default;
      settings = let
        padding = 6;
      in {
        adjust-cell-width = "-1";
        window-padding-x = padding;
        window-padding-y = padding;
        custom-shader = toString (pkgs.fetchurl {
          url = "https://gist.githubusercontent.com/reshen/991d19f9f8c8fedf64ff726f05f05f44/raw/513dfc739ac0ee285c5f0886d0ec7d70ed5e7261/cursor_smear_fade.glsl";
          sha256 = "sha256-fECoZKRQeSzEoDjQTaxB0b9HAb1li8F4Kqxfxs4FITs=";
        });
      };
    };
  };
}

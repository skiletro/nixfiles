{
  flake.modules.nixos.desktop = {pkgs, ...}: {
    fonts = {
      fontDir.enable = true;
      packages = with pkgs; [
        corefonts
        vistafonts # Microsoft fonts
        noto-fonts
        noto-fonts-extra
        noto-fonts-cjk-sans # Japanese, Korean, Chinese, etc.
        noto-fonts-color-emoji
        nerd-fonts.symbols-only
        nerd-fonts."m+"
      ];
    };
  };
}

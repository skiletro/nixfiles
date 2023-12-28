{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = let
      accent = "cba6f7"; #mauve
      wrong = "f38ba8"; #red
      bg = "1e1e2e";
      transparent = "00000000";
      translucent = "00000088";
    in {
      screenshots = true;
      clock = true;
      fade-in = 0;
      indicator = true;
      indicator-radius = 100;
      indicator-thickness = 7;
      timestr = "%I:%M%p";
      datestr = "%b %d, %Y";

      text-color = accent;
      text-ver-color = accent;
      text-clear-color = accent;
      text-wrong-color = accent;

      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";

      ring-color = bg;
      ring-ver-color = bg;
      ring-clear-color = accent;
      ring-wrong-color = wrong;
      bs-hl-color = wrong;
      key-hl-color = accent;

      line-color = transparent;
      line-ver-color = transparent;
      line-wrong-color = transparent;

      inside-color = translucent;
      inside-ver-color = translucent;
      inside-clear-color = translucent;
      inside-wrong-color = translucent;

      separator-color = transparent;
    };
  };
}

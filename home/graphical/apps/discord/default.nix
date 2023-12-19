{pkgs, ...}: {
  # https://github.com/NotAShelf/nyx/blob/41eec1dfbd6bdcb22e705f24195e795289100848/homes/notashelf/graphical/apps/discord/default.nix#L13
  home.packages = with pkgs; [
    ((discord-canary.override {
        withOpenASAR = true;
      })
      .overrideAttrs (old: {
        libPath = old.libPath + ":${pkgs.libglvnd}/lib";
        nativeBuildInputs = old.nativeBuildInputs ++ [pkgs.makeWrapper];

        postFixup = ''
          wrapProgram $out/opt/DiscordCanary/DiscordCanary --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform=wayland}}"
        '';
      }))
  ];
}

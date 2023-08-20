final: prev: {
  eww-wayland = prev.eww-wayland.overrideAttrs (old: rec {
    src = prev.fetchFromGitHub {
      owner = "ralismark";
      repo = "eww";
      rev = "aae214f51f4c8d8129cd0b8dbd0e1c362c50ce27";
      hash = "sha256-b/ipIavlmnEq4f1cQOrOCZRnIly3uXEgFbWiREKsh20=";
    };

    buildInputs = with prev; [libdbusmenu-gtk3 glib gtk3 gdk-pixbuf gtk-layer-shell];

    cargoDeps = old.cargoDeps.overrideAttrs (prev.lib.const {
      inherit src;
      outputHash = "sha256-ixnU1m7WpR5XBg9gAPhHq95LG79XCZtIaax3W3HpBTw=";
    });
  });
}

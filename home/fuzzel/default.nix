{
  pkgs,
  lib,
  ...
}: {
  xdg.configFile."fuzzel/fuzzel.ini".text = ''
    font=Urbanist
    dpi-aware=yes
    prompt="> "
    icon-theme=Papirus

    horizontal-pad=20
    vertical-pad=10
    inner-pad=20

    [colors]
    background=#1e1e2eff
    text=#cdd6f4ff
    match=#cba7faff
    selection=#313244ff
    selection-text=#bac2deff
    border=#cba7faff

    [border]
    width=2
    radius=7

    [dmenu]

    [key-bindings]
  '';
}

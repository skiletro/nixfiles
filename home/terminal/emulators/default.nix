{...}: {
  imports = [
    ./alacritty
    #./foot disabled due to weird font substitution error
    ./kitty
    #./wezterm disabled because nixpkgs has out of date package with unfixed bug
  ];
}

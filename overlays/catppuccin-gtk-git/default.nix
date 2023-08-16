final: prev: 
{
  catppuccin-gtk = prev.catppuccin-gtk.overrideAttrs (old: rec {
    src = prev.fetchFromGitHub {
      owner = "catppuccin";
      repo = "gtk";
      rev = "1897b09f2361f196f17a7748530b3dfc4d09d249";
      hash = "sha256-BjdPe3wQBSVMYpeCifq93Cqt/G4bzsZYgOPBTilHqD8=";
    };
  });
}

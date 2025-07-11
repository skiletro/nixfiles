{inputs, ...}: let
  inherit (inputs.self.lib) mkSystem;
in {
  flake.nixosConfigurations.chronos = mkSystem "x86_64-linux" "desktop" "chronos";
  eos = {
    desktop.gnome.enable = true;
  };
}

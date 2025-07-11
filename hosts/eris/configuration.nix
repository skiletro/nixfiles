{inputs, ...}: let
  inherit (inputs.self.lib) mkSystem;
in {
  flake.ixosConfigurations.eris = mkSystem "x86_64-linux" "desktop" "eris";
}

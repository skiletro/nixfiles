{...}: {
  imports = [../../hosts];

  systems = ["x86_64-linux" "aarch64-linux"];

  perSystem = {pkgs, ...}: {
    # Per-system attributes can be defined here. The self' and inputs'
    # module parameters provide easy access to attributes of the same
    # system.
    devShells.default = pkgs.mkShellNoCC {
      buildInputs = with pkgs; [
        deadnix
        just
        nh
        statix
      ];
      shellHook = "just -l -u";
    };

    formatter = pkgs.alejandra;
  };
}

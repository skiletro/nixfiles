{inputs, ...}: {
  imports = [
    ../../hosts

    ./treefmt.nix
  ];

  systems = import inputs.systems;

  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShellNoCC {
      buildInputs = with pkgs; [
        just
        nh
      ];
      shellHook = "just -l -u";
    };
  };
}

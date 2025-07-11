{
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

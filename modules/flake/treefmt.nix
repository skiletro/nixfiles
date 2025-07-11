{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem = {config, ...}: {
    formatter = config.treefmt.build.wrapper;

    treefmt = {
      flakeCheck = true;
      programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        just.enable = true;
        statix.enable = true;
      };
    };
  };
}

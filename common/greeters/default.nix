{lib, ...}: {
  imports = [
    ./greetd.nix
    ./sddm.nix
  ];

  options = {
    customConfig.greeter = lib.mkOption {
      type = lib.types.enum ["sddm" "greetd"];
      default = "sddm";
      description = "The display manager greeter to use.";
    };
  };
}

{lib, ...}: {
  imports = [
    ./greetd.nix
    ./sddm.nix
  ];

  options = {
    userConfig.greeter = {
      enable = lib.mkEnableOption "Greeter";
      type = lib.mkOption {
        type = lib.types.enum ["sddm" "greetd"];
        default = "sddm";
        description = "The display manager greeter to use.";
      };
    };
  };
}

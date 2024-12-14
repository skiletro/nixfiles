{lib, ...}: {
  imports = [
    ./gdm.nix
    ./greetd.nix
    ./sddm.nix
  ];

  options = {
    userConfig.greeter = {
      enable = lib.mkEnableOption "Greeter";
      type = lib.mkOption {
        type = lib.types.enum ["gdm" "greetd" "sddm"];
        default = "sddm";
        description = "specify the display manager greeter to use";
      };
    };
  };
}

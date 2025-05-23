{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.easy-hosts.flakeModule
  ];

  easy-hosts = {
    shared.modules = [../modules/shared];

    additionalClasses = {
      pc = "nixos";
      server = "nixos";
      mac = "darwin";
    };

    hosts = {
      eris = {
        arch = "x86_64";
        class = "pc";
      };
      # nephele = {
      #   arch = "x86_64";
      #   class = "pc";
      # };
      # jupiter = {
      #   arch = "x86_64";
      #   class = "pc";
      # };
    };

    perClass = class: {
      modules = builtins.concatLists [
        (lib.optionals (class == "pc" || class == "nixos") [
          ../modules/nixos
          ../home
          inputs.agenix.nixosModules.default
          inputs.chaotic.nixosModules.default
          inputs.home-manager.nixosModules.default
          inputs.nur.modules.nixos.default
          inputs.stylix.nixosModules.stylix
        ])

        # Every host gets the modules for their own class
        [../modules/${class}]
      ];
    };
  };
}

{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.easy-hosts.flakeModule
  ];

  easy-hosts = let
    additionalClasses = {
      pc = "nixos";
      steam-machine = "nixos";
      server = "nixos";
      mac = "darwin";
    };

    getBaseClass = class: additionalClasses.${class} or class;
  in {
    inherit additionalClasses;

    hosts = {
      eris = {
        arch = "x86_64";
        class = "pc";
      };
      # nephele = {
      #   arch = "x86_64";
      #   class = "pc";
      # };
      phrixus = {
        arch = "x86_64";
        class = "steam-machine";
      };
    };

    perClass = class: {
      modules = builtins.concatLists [
        # Shared Modules
        [
          ../modules/shared
          ../modules/${class}
        ]

        # Per Base OS
        (lib.optionals ((getBaseClass class) == "nixos") [
          ../modules/nixos
          inputs.agenix.nixosModules.default
          inputs.chaotic.nixosModules.default
          inputs.nur.modules.nixos.default
          inputs.stylix.nixosModules.stylix
        ])

        # Per Class
        (lib.optionals (class == "pc") [
          ../home
          inputs.home-manager.nixosModules.default
        ])

        (lib.optionals (class == "steam-machine") [
          ../home
          ../modules/pc # Benefits from inheriting from here
          inputs.home-manager.nixosModules.default
          inputs.jovian.nixosModules.default
        ])
      ];
    };
  };
}

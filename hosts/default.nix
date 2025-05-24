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
        class = "pc";
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
      ];
    };
  };
}

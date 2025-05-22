{inputs, ...}: {
  imports = [
    inputs.easy-hosts.flakeModule
  ];

  easy-hosts = {
    shared.modules = [
      ../modules/shared
      ../modules/nixos # TODO: Remove this once proper darwin support is added to the flake
      ../home
      inputs.agenix.nixosModules.default
      inputs.chaotic.nixosModules.default
      inputs.home-manager.nixosModules.default
      inputs.nur.modules.nixos.default
      inputs.stylix.nixosModules.stylix
    ];

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
      modules = [../modules/${class}];
    };
  };
}

{
  description = "nixfiles - Config";

  inputs = {
    # We're using unstable for cutting edge packages. We're fine using this
    # because we have rollbacks
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Allows us to configure our home directory with Nix!
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # This is so the HM flake uses our nixpkgs, instead of the nixpkgs commit in their repo

    # Stands for "Nix User Repository". It has a few packages that I need, such as a few Firefox addons and some fonts
    nur.url = "github:nix-community/NUR";

    # Custom spotify theming
    spicetify.url = "github:the-argus/spicetify-nix";

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    declarative-flatpak.url = "github:gmodena/nix-flatpak";

    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nur,
    emacs-overlay,
    declarative-flatpak,
    wsl,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    # Here is where all the module imports are stored
    commonModules = [
      ./common
      # NixOS Modules
      home-manager.nixosModules.default
      nur.nixosModules.nur
      declarative-flatpak.nixosModules.nix-flatpak
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.jamie.imports = [./home];
          extraSpecialArgs = {inherit inputs self;};
        };
        nixpkgs.overlays = [
          # Nixpkgs Overlays
          nur.overlay
          emacs-overlay.overlay
          (import ./packages)
        ];
      }
    ];
  in {
    nixosConfigurations = {
      eris = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = commonModules ++ [./hosts/eris];
      };

      themis = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = commonModules ++ [./hosts/themis];
      };

      wsl = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules =
          commonModules
          ++ [
            wsl.nixosModules.default
            ./hosts/wsl
          ];
      };
    };

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        nh
        alejandra #code formatting
        just #command runner
      ];
      shellHook = "just -l";
    };
  };
}

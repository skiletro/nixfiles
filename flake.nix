{
  description = "nixfiles - Config";

  inputs = {
    # We're using unstable for cutting edge packages. We're fine using this
    # because we have rollbacks
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Allows us to configure our home directory with Nix!
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # This is so the HM flake uses our nixpkgs, instead of the nixpkgs commit in their repo

    # Stands for "Nix User Repository". Has a few packages that I need, like Firefox addons
    nur.url = "github:nix-community/NUR";

    # Custom spotify theming
    spicetify.url = "github:the-argus/spicetify-nix";

    # Emacs Overlay
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    # Declarative Flatpaks
    declarative-flatpak.url = "github:gmodena/nix-flatpak";

    # VSCode Plugins
    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nur,
    emacs-overlay,
    declarative-flatpak,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    # Here is where all the module imports are stored
    desktopModules = [
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
      themis = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./hosts/themis] ++ desktopModules;
      };

      eris = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./hosts/eris] ++ desktopModules;
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

{
  description = "nixfiles - Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable packages

    home-manager.url = "github:nix-community/home-manager"; # Allows us to configure our home directory with Nix!
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # This is so the HM flake uses our nixpkgs, instead of the nixpkgs commit in their repo

    stylix.url = "github:danth/stylix"; # Automatic styling

    cursors.url = "github:lilleaila/nix-cursors"; # Recoloured cursors

    nur.url = "github:nix-community/NUR"; # Nix User Repository; similar to the AUR.

    spicetify.url = "github:Gerg-L/spicetify-nix"; # Custom spotify theming

    emacs-overlay.url = "github:nix-community/emacs-overlay"; # Allows generating an emacs config using org mode + nix

    declarative-flatpak.url = "github:gmodena/nix-flatpak"; # Declare Flatpaks in this config!

    vscode-extensions.url = "github:nix-community/nix-vscode-extensions"; # Declare VSC Extensions

    wsl.url = "github:nix-community/NixOS-WSL/main"; # WSL Support
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    # Here is where all the module imports are stored
    commonModules = [
      ./common
      # NixOS Modules
      inputs.home-manager.nixosModules.default
      inputs.stylix.nixosModules.stylix
      inputs.nur.nixosModules.nur
      inputs.declarative-flatpak.nixosModules.nix-flatpak
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "homemanager";
          users.jamie.imports = [./home];
          extraSpecialArgs = {inherit inputs self;};
        };
        nixpkgs.overlays = [
          # Nixpkgs Overlays
          inputs.nur.overlay
          inputs.emacs-overlay.overlay
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
        modules = commonModules ++ [./hosts/wsl];
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

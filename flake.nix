{
  description = "nixfiles - Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable packages

    home-manager.url = "github:nix-community/home-manager"; # Allows us to configure our home directory with Nix!
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # This is so the HM flake uses our nixpkgs, instead of the nixpkgs commit in their repo

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake"; # Best browser
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix"; # Automatic styling
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    cursors.url = "github:lilleaila/nix-cursors"; # Recoloured cursors
    cursors.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR"; # Nix User Repository; similar to the AUR.

    spicetify.url = "github:Gerg-L/spicetify-nix"; # Custom spotify theming
    spicetify.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay"; # Allows generating an emacs config using org mode + nix
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    declarative-flatpak.url = "github:gmodena/nix-flatpak"; # Declare Flatpaks in this config!

    vscode-extensions.url = "github:nix-community/nix-vscode-extensions"; # Declare VSC Extensions
    vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    wsl.url = "github:nix-community/NixOS-WSL/main"; # WSL Support
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
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
          backupFileExtension = "hm";
          users.jamie.imports = [./home];
          extraSpecialArgs = {inherit inputs self;};
        };
        nixpkgs.overlays = with inputs; [
          # Nixpkgs Overlays
          nur.overlay
          emacs-overlay.overlay
        ];
      }
    ];
  in {
    nixosConfigurations = {
      eris = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = commonModules ++ [./hosts/eris];
      };

      wsl = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = commonModules ++ [./hosts/wsl];
      };
    };

    devShells.${system}.default = let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [inputs.devshell.overlays.default];
      };
    in
      pkgs.devshell.mkShell {imports = [(pkgs.devshell.importTOML ./devshell.toml)];}; # TODO: Probably a nicer way to express this

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}

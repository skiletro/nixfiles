{
  description = "nixfiles - Config";

  inputs = {
    cursors.url = "github:lilleaila/nix-cursors"; # Recoloured cursors

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    declarative-flatpak.url = "github:gmodena/nix-flatpak"; # Declare Flatpaks in this config!

    home-manager.url = "github:nix-community/home-manager"; # Allows us to configure our home directory with Nix!
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # This is so the HM flake uses our nixpkgs, instead of the nixpkgs commit in their repo

    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixpkgs-unstable"; # Unstable packages

    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr"; # VR Tools
    nixpkgs-xr.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR"; # Nix User Repository; similar to the AUR.

    spicetify.url = "github:Gerg-L/spicetify-nix"; # Custom spotify theming
    spicetify.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix"; # Automatic styling
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    vscode-extensions.url = "github:nix-community/nix-vscode-extensions"; # Declare VSC Extensions
    vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    wsl.url = "github:nix-community/NixOS-WSL/main"; # WSL Support

    zen-browser.url = "github:0xc000022070/zen-browser-flake"; # Best browser
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    # Here is where all the module imports are stored
    commonModules = [
      ./modules
      # NixOS Modules
      inputs.home-manager.nixosModules.default
      inputs.stylix.nixosModules.stylix
      inputs.nur.modules.nixos.default
      inputs.declarative-flatpak.nixosModules.nix-flatpak
      inputs.nix-gaming.nixosModules.platformOptimizations
      inputs.nix-gaming.nixosModules.pipewireLowLatency
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
          nur.overlays.default
        ];
      }
    ];
  in {
    # Devshell - manage using devshell.toml file
    devShells.${system}.default = let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [inputs.devshell.overlays.default];
      };
    in
      pkgs.devshell.mkShell {imports = [(pkgs.devshell.importTOML ./devshell.toml)];}; # TODO: Probably a nicer way to express this

    # Formatter
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    # System configurations
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
  };
}

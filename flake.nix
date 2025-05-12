{
  description = "nixfiles - Config";

  inputs = {
    # Core Inputs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Unstable packages

    home-manager.url = "github:nix-community/home-manager"; # Allows us to configure our home directory with Nix!
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # This is so the HM flake uses our nixpkgs, instead of the nixpkgs commit in their repo

    declarative-flatpak.url = "github:gmodena/nix-flatpak"; # Declare Flatpaks in this config!

    # Styling
    stylix.url = "github:danth/stylix"; # Automatic styling
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    cursors.url = "github:lilleaila/nix-cursors"; # Recoloured cursors

    # Extra Packages
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR"; # Nix User Repository; similar to the AUR.

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # Individual Programs
    spicetify.url = "github:Gerg-L/spicetify-nix"; # Spotify
    spicetify.inputs.nixpkgs.follows = "nixpkgs";

    vscode-extensions.url = "github:nix-community/nix-vscode-extensions"; # VSC Extensions
    vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake"; # Best browser
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:johanneshorner/nixGL"; # See https://github.com/nix-community/nixGL/pull/190, fixes issues with Steam Deck
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    # Here is where all the module imports are stored
    commonModules =
      [./modules]
      ++ (with inputs; [
        home-manager.nixosModules.default
        stylix.nixosModules.stylix
        nur.modules.nixos.default
        declarative-flatpak.nixosModules.nix-flatpak
        nix-gaming.nixosModules.platformOptimizations
        nix-gaming.nixosModules.pipewireLowLatency
        chaotic.nixosModules.default
      ]);
  in {
    devShells.${system}.default = pkgs.mkShellNoCC {
      buildInputs = with pkgs; [
        alejandra # Code Formatting
        deadnix # Dead Code Scanner
        just # Command Runner
        nh # Nix CLI Helper
      ];
      shellHook = "just --list --unsorted";
    };

    # Formatter
    formatter.${system} = pkgs.alejandra;

    # System configurations
    nixosConfigurations = {
      eris = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = commonModules ++ [./hosts/eris];
      };
    };

    # Home configurations
    homeConfigurations = {
      nephele = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [inputs.stylix.homeManagerModules.stylix ./hosts/nephele];
        extraSpecialArgs = {inherit inputs;};
      };
    };
  };
}

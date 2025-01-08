{
  description = "nixfiles - Config";

  inputs = {
    # Core Inputs
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixpkgs-unstable"; # Unstable packages

    home-manager.url = "github:nix-community/home-manager"; # Allows us to configure our home directory with Nix!
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # This is so the HM flake uses our nixpkgs, instead of the nixpkgs commit in their repo

    declarative-flatpak.url = "github:gmodena/nix-flatpak"; # Declare Flatpaks in this config!

    wsl.url = "github:nix-community/NixOS-WSL/main"; # WSL Support

    # Styling
    stylix.url = "github:danth/stylix"; # Automatic styling
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    cursors.url = "github:lilleaila/nix-cursors"; # Recoloured cursors

    # Extra Packages
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr"; # VR Tools
    nixpkgs-xr.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR"; # Nix User Repository; similar to the AUR.

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # Individual Programs
    spicetify.url = "github:Gerg-L/spicetify-nix"; # Spotify
    spicetify.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim"; # Neovim
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    vscode-extensions.url = "github:nix-community/nix-vscode-extensions"; # VSC Extensions
    vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake"; # Best browser
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # GNOME 47 Triple Buffering Patch
    mutter-triple-buffering-src = {
      url = "gitlab:vanvugt/mutter?ref=triple-buffering-v4-47&host=gitlab.gnome.org";
      flake = false;
    };

    gvdb-src = {
      url = "gitlab:GNOME/gvdb?ref=main&host=gitlab.gnome.org";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    # Here is where all the module imports are stored
    commonModules =
      [
        ./modules
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
      ]
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
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        alejandra # Code Formatting
        deadnix # Dead Code Scanner
        just # Command Runner
        nh # Nix CLI Helper
      ];
      shellHook = "just --list --unsorted";
    };

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

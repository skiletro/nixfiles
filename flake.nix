{
  description = "nixfiles - Config";

  inputs = {
    # We're using unstable for cutting edge packages. We're fine using this
    # because we have rollbacks
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Allows us to configure our home directory with Nix!
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # This is so the HM flake uses our nixpkgs, instead of the nixpkgs commit in their repo

    # Nice utility flake: among other things, has better garbage collection
    nh.url = "github:viperML/nh";
    nh.inputs.nixpkgs.follows = "nixpkgs";

    # Stands for "Nix User Repository". Has a few packages that I need, like Firefox addons
    nur.url = "github:nix-community/NUR";

    # The Wayland compositor! Their flake is used for the -git build.
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";

    # Elkowars Wacky Widgets, used primarily for my bar and osd popups. Currently using a patch which adds a systray
    eww.url = "github:hylophile/eww/dynamic-icons";

    # Custom spotify theming
    spicetify.url = "github:the-argus/spicetify-nix";

    # Neovim distribution made for nix/hm
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nh,
    nur,
    hyprland,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    # Here is where all the module imports are stored
    desktopModules = [
      ./common
      # NixOS Modules
      home-manager.nixosModules.default
      nh.nixosModules.default
      nur.nixosModules.nur
      hyprland.nixosModules.default
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
    };

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        alejandra #code formatting
        just #command runner
      ];
      shellHook = "just -l";
    };
  };
}

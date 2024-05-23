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

    # The Wayland compositor! Their flake is used for the -git build.
    hyprland.url = "github:hyprwm/Hyprland/ed69502ff6e79a6dad213333b0bc3a15e2247942";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";

    # Elkowars Wacky Widgets Git, used primarily for my bar and OSD popups. Currently using a patch which adds a systray
    eww.url = "github:ralismark/eww/tray-3";

    # Custom spotify theming
    spicetify.url = "github:the-argus/spicetify-nix";

    # Emacs Overlay
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    # VSCode Plugins
    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nur,
    hyprland,
    emacs-overlay,
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

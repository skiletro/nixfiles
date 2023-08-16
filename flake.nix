{
  description = "skiletro's config :)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    nur.url = "github:nix-community/NUR";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    myfonts.url = "github:skiletro/fonts/a87a2750b282255b9aea4f2aa3d9a70e8b68a1ba";

    hyprland.url = "github:hyprwm/Hyprland";

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs =
    inputs@{ self, nixpkgs, home-manager, utils, devshell, myfonts, hyprland, anyrun, spicetify-nix, nur, ... }:
    let
      desktopModules = [
        nur.nixosModules.nur
        ./common
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jamie.imports = [
	          inputs.hyprland.homeManagerModules.default
            inputs.spicetify-nix.homeManagerModule
            inputs.anyrun.homeManagerModules.default
            ./home
          ];
          home-manager.extraSpecialArgs = { inherit inputs self; };
        }
      ];

    in utils.lib.mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      channelsConfig.allowUnfree = true;

      sharedOverlays = [
        devshell.overlays.default
        nur.overlay
        (import ./packages)
        (import ./overlays/eww-git)
        #(import ./overlays/catppuccin-gtk-git) #dont work rn
      ];

      hosts.themis.modules = [ ./machines/themis ] ++ desktopModules;

      hostDefaults.modules = [ 
        hyprland.nixosModules.default
        { programs.hyprland.enable = true;}
      ];

      outputsBuilder = channels:
        with channels.nixpkgs; {
          packages = {
            inherit (channels.nixpkgs) beeper nvchad;
          };
          devShell = channels.nixpkgs.devshell.mkShell {
            imports =
              [ (channels.nixpkgs.devshell.importTOML ./devshell.toml) ];
          };
        };
    };
}

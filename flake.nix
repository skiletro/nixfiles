{
  description = "jamie's config (based on bezmuth)";

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

    hyprland.url = "github:hyprwm/Hyprland";

    spicetify-nix.url = "github:the-argus/spicetify-nix";

    nix-gaming.url = "github:fufexan/nix-gaming";

    webcord.url = "github:fufexan/webcord-flake";
  };

  outputs =
    inputs@{ self, nixpkgs, home-manager, utils, devshell, hyprland, spicetify-nix, nur, nix-gaming, webcord, ... }:
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
            inputs.webcord.homeManagerModules.default
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
        webcord.overlays.default
        (import ./packages)
        (import ./overlays/eww-git)
      ];

      hosts.themis.modules = [ ./machines/themis ] ++ desktopModules;
      hosts.vm.modules = [ ./machines/vm ] ++ desktopModules;

      hostDefaults.modules = [ 
        hyprland.nixosModules.default
        { programs.hyprland = {
          enable = true;
          package = hyprland.packages.x86_64-linux.hyprland-hidpi;
          xwayland.hidpi = true; # temp until i can figure out what's going on
        };}
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

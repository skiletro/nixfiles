{
  description = "jamie's config (based on bezmuth)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    inputs@{ self, nixpkgs, home-manager, utils, devshell, hyprland, ... }:
    let
      desktopModules = [
        ./common
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jamie.imports = [
	          inputs.hyprland.homeManagerModules.default
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
        (import ./packages)
      ];

      hosts.themis.modules = [ ./machines/themis ] ++ desktopModules;
      hosts.vm.modules = [ ./machines/vm ] ++ desktopModules;

      hostDefaults.modules = [ 
        hyprland.nixosModules.default
        { programs.hyprland.enable = true; }
      ];

      outputsBuilder = channels:
        with channels.nixpkgs; {
          #defaultPackage = channels.nixpkgs.devshell.mkShell {
          #  imports =
          #    [ (channels.nixpkgs.devshell.importTOML ./devshell.toml) ];
          #};
          packages = {
            inherit (channels.nixpkgs) beeper nvchad eww-systray;
          };
          devShell = channels.nixpkgs.devshell.mkShell {
            imports =
              [ (channels.nixpkgs.devshell.importTOML ./devshell.toml) ];
          };
        };
    };
}

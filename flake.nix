{
  description = "skiletro's config :)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    myfonts.url = "github:skiletro/fonts";

    hyprland.url = "github:hyprwm/Hyprland";

    #eww.url = "github:ralismark/eww/tray-3"; #tmp disabled
    eww.url = "github:hylophile/eww/dynamic-icons";

    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    utils,
    devshell,
    hyprland,
    spicetify-nix,
    nh,
    nur,
    ...
  }: let
    desktopModules = [
      ./common
      hyprland.nixosModules.default
      nur.nixosModules.nur
      nh.nixosModules.default
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.jamie.imports = [
          inputs.spicetify-nix.homeManagerModule
          ./home
        ];
        home-manager.extraSpecialArgs = {inherit inputs self;};
      }
    ];
  in
    utils.lib.mkFlake {
      inherit self inputs;

      supportedSystems = ["x86_64-linux"];

      channelsConfig.allowUnfree = true;

      sharedOverlays = [
        devshell.overlays.default
        nur.overlay
        (import ./packages)
      ];

      hosts.eris.modules = [./machines/eris] ++ desktopModules;
      hosts.themis.modules = [./machines/themis] ++ desktopModules;

      hostDefaults.modules = [];

      outputsBuilder = channels:
        with channels.nixpkgs; {
          packages = {
            inherit (channels.nixpkgs) beeper nvchad lutgen;
          };
          devShell = channels.nixpkgs.devshell.mkShell {
            imports = [(channels.nixpkgs.devshell.importTOML ./devshell.toml)];
          };
          overlay = import ./overlays;
        };
    };
}

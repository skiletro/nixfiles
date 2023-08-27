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

    emacs-doom.url = "github:nix-community/nix-doom-emacs";
    #emacs.url = "github:nix-community/emacs-overlay/c16be6de78ea878aedd0292aa5d4a1ee0a5da501"; # pinned for now, see: https://github.com/nix-community/nix-doom-emacs/issues/409
    emacs.url = "github:nix-community/emacs-overlay";

    myfonts.url = "github:skiletro/fonts/a87a2750b282255b9aea4f2aa3d9a70e8b68a1ba";

    hyprland.url = "github:hyprwm/Hyprland";

    eww.url = "github:ralismark/eww/tray-3";

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    utils,
    devshell,
    emacs-doom,
    emacs,
    myfonts,
    hyprland,
    eww,
    anyrun,
    spicetify-nix,
    nur,
    ...
  }: let
    desktopModules = [
      ./common
      hyprland.nixosModules.default
      nur.nixosModules.nur
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.jamie.imports = [
          inputs.hyprland.homeManagerModules.default
          inputs.spicetify-nix.homeManagerModule
          inputs.anyrun.homeManagerModules.default
          inputs.emacs-doom.hmModule
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
        emacs.overlay
        nur.overlay
        (import ./packages)
        #(import ./overlays/eww-git)
      ];

      hosts.themis.modules = [./machines/themis] ++ desktopModules;

      hostDefaults.modules = [
        #hyprland.nixosModules.default
        {programs.hyprland.enable = true;}
      ];

      outputsBuilder = channels:
        with channels.nixpkgs; {
          packages = {
            inherit (channels.nixpkgs) beeper nvchad;
          };
          devShell = channels.nixpkgs.devshell.mkShell {
            imports = [(channels.nixpkgs.devshell.importTOML ./devshell.toml)];
          };
        };
    };
}

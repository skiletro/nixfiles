{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.cleanTmpDir = true;
  zramSwap.enable = false;
  networking.hostName = "tyche";
  networking.domain = "subnet05290242.vcn05290242.oraclevcn.com";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINnFEMa0S9zuA5cVg+Ktazz9gEevkDCNYIDX0WAMxcAC eos''
  ];
  security.sudo.extraRules = [
    {
      users = ["jamie"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD" "SETENV"];
        }
      ];
    }
  ];

  users.users.jamie = {
    isNormalUser = true;
    description = "Jamie";
    extraGroups = ["users" "wheel"];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINnFEMa0S9zuA5cVg+Ktazz9gEevkDCNYIDX0WAMxcAC eos''
    ];
  };
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    alejandra
    gh
    direnv
    git
    neovim
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [25565 19132];
    allowedUDPPorts = [25565 19132];
  };

  services.minecraft-server = {
    enable = false;
    eula = true;
    package = let
      version = "1.20-fabric0.14.22";
      url = "https://meta.fabricmc.net/v2/versions/loader/1.20/0.14.22/0.11.2/server/jar";
      sha256 = "0wvi25nm8wmg9f4a7684rhg5g5fvpw28hh1l0r0rgcgz34fn7kxf";
    in (pkgs.minecraft-server.overrideAttrs (old: rec {
      name = "minecraft-server-${version}";
      inherit version;

      src = pkgs.fetchurl {
        inherit url sha256;
      };
    }));
  };
}

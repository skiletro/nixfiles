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
}

{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.eos.programs.graphical.enable {
    environment.systemPackages = with pkgs; [
      lact
    ];

    systemd.services.lact = {
      description = "Linux GPU Configuration Tool for AMD and NVIDIA - Daemon";
      after = ["multi-user.target"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${lib.getExe pkgs.lact} daemon";
      };
      enable = true;
    };
  };
}

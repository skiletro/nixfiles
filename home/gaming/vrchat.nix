{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.eos.programs.vr.enable {
    programs.steam.config.apps."438100" = {
      compatTool = "proton_experimental";
      launchOptions = ''env -u TZ PRESSURE_VESSEL_FILESYSTEMS_RW="$XDG_RUNTIME_DIR/wivrn/comp_ipc" %command%'';
    };

    systemd.user.tmpfiles.rules = let
      inherit (osConfig.eos.system) user;
      vrcPicsDir = "/home/${user}/.local/share/Steam/steamapps/compatdata/438100/pfx/drive_c/users/steamuser/Pictures/VRChat";
    in
      lib.singleton "L /home/${user}/Pictures/VRChat - - - - ${vrcPicsDir}";

    home.packages = with pkgs; [
      vrcx
    ];
  };
}

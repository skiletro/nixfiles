{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}: let
  refreshRate = "60";
  lengthOfReplayInSeconds = "45";
  outputDirectory = "${config.home.homeDirectory}/Videos/Clips/Unprocessed";

  captureSoundEffect = pkgs.fetchurl {
    url = "https://assets.mixkit.co/active_storage/sfx/2037/2037.mp3";
    sha256 = "19m42fb7nyzacgz67r95kzjiybs7xs8ajqkf341xa7vy88nmxn5i";
  };

  captureReplayScript = pkgs.writeShellScriptBin "capture-replay" ''
    ${lib.getExe pkgs.killall} -SIGUSR1 gpu-screen-recorder && msg="Replay Saved!" || msg="Error, check logs. This probably means that the service is not running."
    sleep 0.25
    ${lib.getExe pkgs.libnotify} -t 1500 -- "GPU Screen Recorder" "$msg"
    ${lib.getExe' pkgs.pipewire "pw-play"} ${captureSoundEffect}
  '';

  startReplayScript = pkgs.writeShellScriptBin "start-replay" ''
    sleep 10
    ${lib.getExe pkgs.gpu-screen-recorder} -w portal -restore-portal-session yes -f ${refreshRate} \
      -r ${lengthOfReplayInSeconds} -c mp4 -a "default_output|default_input" -o ${outputDirectory}
  '';

  desktopFile = pkgs.writeText "gpureplay.desktop" ''
    [Desktop Entry]
    Version=1.0
    Name=gpu-screen-recorder Start Replay
    Exec=${lib.getExe' startReplayScript "start-replay"}
    Terminal=false
    Type=Application
  '';
in {
  config = lib.mkIf osConfig.userConfig.services.gpureplay.enable {
    home.packages = [captureReplayScript];

    home.file.".config/autostart/gpureplay.desktop" = {
      source = "${desktopFile}";
    };
  };
}

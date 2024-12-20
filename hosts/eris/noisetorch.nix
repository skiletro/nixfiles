{pkgs, ...}: {
  programs.noisetorch.enable = true;

  systemd.user.services.noisetorch = let
    nt = "${pkgs.noisetorch}/bin/noisetorch";
    deviceUnit = ''sys-devices-pci0000:00-0000:00:01.3-0000:03:00.0-usb1-1\x2d2-1\x2d2:1.0-sound-card0-controlC0.device'';
    deviceID = ''alsa_input.usb-BLUE_MICROPHONE_Blue_Snowball_201305-00.mono-fallback'';
  in {
    enable = true;
    description = "NoiseTorch Audio Cancelling";
    wantedBy = ["default.target"];
    requires = [deviceUnit];
    after = ["pipewire.service" deviceUnit];
    serviceConfig = {
      Type = "simple";
      RemainAfterExit = "yes";
      ExecStart = ''${nt} -s ${deviceID} -i -o'';
      ExecStop = ''${nt} -u'';
      Restart = "on-failure";
      RestartSec = 3;
    };
  };
}

#TODO: VR-support in this flake needs to be completely redone, once I have the proper hardware to properly troubleshoot.
{
  lib,
  pkgs,
  config,
  ...
}: let
  # This is a wrapper script to help avoid EAC errors with VRChat
  steamapps = "~/.local/share/Steam/steamapps";
  vrcfolder = "${steamapps}/compatdata/438100/pfx/drive_c/users/steamuser/AppData/LocalLow/VRChat/VRChat";
  startvrc = pkgs.writeShellScript "startvrc" ''
    #!/usr/bin/env sh
    do_taskset() {
    	log=$(${pkgs.inotify-tools}/bin/inotifywait --include '.*\.txt' --event create "${vrcfolder}" --format '%f')

    	echo "Log: ${vrcfolder}/$log"

    	while ! pid=$(pgrep VRChat); do
    		sleep 0.1
    	done

    	echo "Setting VRChat to dual-core..."
    	taskset -pac 0,1 "$pid"

    	tail -f "${vrcfolder}/$log" 2>/dev/null | sed -n '/EOS Login Succeeded/{p;q}'
    	sleep 1

    	echo "Setting VRChat to all cores..."
    	taskset -pac "0-$(($(nproc) - 1))" "$pid"

    	echo "Our work here is done."
    }

    LD_PRELOAD="" do_taskset </dev/null &
    exec "$@"
  '';
in {
  options.userConfig.gaming.vr.enable = lib.mkEnableOption "Virtual Reality";

  config = lib.mkIf config.userConfig.gaming.vr.enable {
    environment.systemPackages = with pkgs; [
      wlx-overlay-s
      startvrc
    ];

    services.wivrn = {
      enable = true;
      openFirewall = true;

      # Write information to /etc/xdg/openxr/1/active_runtime.json, VR applications
      # will automatically read this and work with WiVRn (Note: This does not currently
      # apply for games run in Valve's Proton). This is why we have the home manager file.
      defaultRuntime = true;

      autoStart = true; # Run WiVRn as a systemd service on startup
    };
  };

  # Please ensure you add the following launch argument to Steam games to allow them to run under OpenComposite and therefore WiVRn
  # `PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/wivrn/comp_ipc %command%`

  # If playing VRChat however, set the launch argument to the following instead:
  # `PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/wivrn/comp_ipc startvrc %command%`
}

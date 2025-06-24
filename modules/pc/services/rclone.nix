{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.eos.services.rclone.enable {
    age.secrets."rclone-protondrive.conf" = {
      file = ../../../secrets/rclone-protondrive.age;
      mode = "400";
      owner = config.eos.system.user;
    };

    systemd.services."rclone-documents-sync" = {
      after = ["run-agenix.d.mount"];
      wants = ["run-agenix.d.mount"];
      serviceConfig = {
        Type = "oneshot";
        User = config.eos.system.user;
        ExecStart = let
          conf = "/run/agenix/rclone-protondrive.conf";
        in
          lib.getExe (pkgs.writers.writeFishBin "rclone-docs-sync"
            # fish
            ''
              set HASH_FILE "/tmp/.rclone-protondrive-hash"
              set REMOTE_DIR "Documents"
              set SYNC_DIR "/home/${config.eos.system.user}/Documents"

              set CURRENT_HASH (${lib.getExe pkgs.gnutar} fcP - $SYNC_DIR | md5sum)

              function log -a val
                  echo "$(date --rfc-3339 s) - RPROTON - $val"
              end

              function run_sync
                  log "Running sync..."
                  ${lib.getExe pkgs.rclone} bisync --config="${conf}" -v --force --min-size 1b proton:$REMOTE_DIR $SYNC_DIR
              end

              function create_hash_file
                  log "Creating hash file..."
                  echo $CURRENT_HASH >$HASH_FILE
              end

              function check_hash
                  log "Checking directory hashes..."
                  set prev_hash (cat $HASH_FILE)
                  if test "$CURRENT_HASH" != "$prev_hash"
                      log "Hash is not the same. Syncing..."
                      run_sync
                      create_hash_file
                  else
                      log "Hash is the same, no need to sync."
                  end
              end

              function main
                  log "Checking if previous hash file exists..."
                  if test -f $HASH_FILE
                      log "Hash file exists!"
                      check_hash
                  else
                      log "Hash file does not exist."
                      create_hash_file
                      run_sync
                  end
              end

              main
            '');
      };
      startAt = "*:0/15"; # Every 15 minutes
    };
  };
}

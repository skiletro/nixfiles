{...}: {
  programs.mangohud = {
    enable = true;
    enableSessionWide = false; # Need to test to see if it crashes gamescope with workaround implem.
    # TODO: Need to customise more
  };
}

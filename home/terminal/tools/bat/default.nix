{...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "base16-256";
    };
  };

  programs.fish.shellAbbrs = {
    cat = "bat";
  };
}

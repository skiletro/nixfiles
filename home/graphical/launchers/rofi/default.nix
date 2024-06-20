{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.graphical.enable {
    home.packages = with pkgs; [
      (rofimoji.override {rofi = pkgs.rofi-wayland;}) #Emoji picker
    ];

    programs.rofi = rec {
      enable = true;
      package = pkgs.rofi-wayland;
      plugins = with pkgs; [rofi-calc];
      extraConfig = {
        show-icons = true;
        display-drun = "";
        drun-display-format = "{icon} {name}";
        disable-history = false;
        click-to-exit = true;
        modi = "drun";
      };
      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
        normal-font = "Urbanist 12";
        symbol-font = "Symbols Nerd Font 12";
        background = mkLiteral "#1e1e2e";
        accent = mkLiteral "#cba7fa";
        text = mkLiteral "#cdd6f4";
      in {
        "*" = {
          font = normal-font;
        };

        "window" = {
          background-color = background;
          text-color = accent;
          border = mkLiteral "2px";
          border-color = accent;
          border-radius = mkLiteral "10px";
          width = mkLiteral "500px";
          anchor = mkLiteral "center";
          x-offset = 0;
          y-offset = 0;
          padding = mkLiteral "15px";
        };

        "mainbox" = {
          children = mkLiteral "[ inputbar, listview ]";
          background-color = background;
        };

        # Search bar
        "inputbar" = {
          children = mkLiteral "[ prompt, entry ]";
          padding = mkLiteral "0px";
          margin = mkLiteral "0px 0px 5px 0px";
          background-color = background;
        };

        "prompt" = {
          font = symbol-font;
          text-color = accent;
          padding = mkLiteral "2px";
          background-color = background;
        };

        "entry" = {
          text-color = accent;
          placeholder = "Search...";
          margin = mkLiteral "0px 0px 0px 5px";
          background-color = background;
        };

        # Entries
        "listview" = {
          scrollbar = false;
          lines = 8;
          border = mkLiteral "0px";
          background-color = background;
        };

        "element" = {
          orientation = mkLiteral "horizontal";
          border-radius = mkLiteral "4px";
          padding = mkLiteral "6px 6px 6px 6px";
        };

        "element normal.normal" = {
          background-color = background;
          text-color = text;
        };

        "element alternate.normal" = {
          background-color = background;
          text-color = text;
        };

        "element selected.normal" = {
          background-color = accent;
          text-color = background;
        };

        "element-icon" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
          horizontal-align = mkLiteral "0.5";
          vertical-align = mkLiteral "0.5";
          size = mkLiteral "24px";
          border = mkLiteral "0px";
        };

        "element-text" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
          expand = true;
          horizontal-align = 0;
          vertical-align = mkLiteral "0.5";
          margin = mkLiteral "2px 0px 2px 2px";
        };
      };
    };
  };
}

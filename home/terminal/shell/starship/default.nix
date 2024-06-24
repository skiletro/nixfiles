{
  lib,
  osConfig,
  ...
}: {
  programs.starship = let
    colours = osConfig.lib.stylix.colors.withHashtag;

    background = colours.base00;
    foreground = colours.base07;

    color1 = colours.base0C;
    color2 = colours.base0D;
    color3 = colours.base0E;
  in {
    enable = true;
    enableFishIntegration = true;

    settings = {
      format = lib.concatStrings [
        #"[ ](fg:#1e1e2e bg:#ff00aa)"
        #"$username"
        #"[](fg:#ff00aa)"
        "$directory"
        "[](fg:${background} bg:${color1})"
        "$git_branch"
        "$git_status"
        "[](fg:${color1} bg:${color2})"
        "$c"
        "$elixir"
        "$elm"
        "$golang"
        "$haskell"
        "$java"
        "$julia"
        "$nodejs"
        "$nim"
        "$rust"
        "[](fg:${color2} bg:${color3})"
        "$nix_shell"
        "$docker_context"
        "[ ](fg:${color3})"
      ];

      add_newline = false; # Disable the blank line at the start of the prompt

      # You can also replace your username with a neat symbol like  to save some space
      username = {
        show_always = true;
        #style_user = "fg:#11111b bg:#89B4FA";
        #style_root = "fg:#11111b bg:#cba6f7";
        #format = "[$user ]($style)";
        format = "[󱄅 ](fg:#11111b bg:#ff00aa)";
      };

      directory = {
        style = "fg:${foreground}";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "../";
      };

      # Section 1
      git_branch = {
        symbol = "󰘬";
        style = "fg:${background} bg:${color1}";
        format = "[[ $symbol $branch ](fg:#11111b bg:${color1})]($style)";
      };

      git_status = {
        style = "fg:${background} bg:${color1}";
        format = "[[($all_status$ahead_behind )](fg:#11111b bg:${color1})]($style)";
      };

      # Section 2
      c = {
        symbol = " ";
        style = "fg:${background} bg:${color2}";
        format = "[[ $symbol ($version) ](fg:${background} bg:${color2})]($style)";
      };

      elixir = {
        symbol = " ";
        style = "fg:${background} bg:${color2}";
        format = "[[ $symbol ($version) ](fg:${background} bg:${color2})]($style)";
      };

      elm = {
        symbol = " ";
        style = "fg:${background} bg:${color2}";
        format = "[[ $symbol ($version) ](fg:${background} bg:${color2})]($style)";
      };

      golang = {
        symbol = " ";
        style = "fg:${background} bg:${color2}";
        #format = "[[ $symbol ($version) ](fg:${background} bg:${color2})]($style)";
        format = "[[ $symbol](fg:${background} bg:${color2})]($style)";
      };

      haskell = {
        symbol = " ";
        style = "fg:${background} bg:${color2}";
        format = "[[ $symbol ($version) ](fg:${background} bg:${color2})]($style)";
      };

      java = {
        symbol = " ";
        style = "fg:${background} bg:${color2}";
        format = "[[ $symbol ($version) ](fg:${background} bg:${color2})]($style)";
      };

      julia = {
        symbol = " ";
        style = "fg:${background} bg:${color2}";
        format = "[[ $symbol ($version) ](fg:${background} bg:${color2})]($style)";
      };

      nodejs = {
        symbol = "";
        style = "fg:${background} bg:${color2}";
        format = "[[ $symbol ($version) ](fg:${background} bg:${color2})]($style)";
      };

      nim = {
        symbol = " ";
        style = "fg:${background} bg:${color2}";
        format = "[[ $symbol ($version) ](fg:${background} bg:${color2})]($style)";
      };

      rust = {
        symbol = "";
        style = "fg:${background} bg:${color2}";
        format = "[[ $symbol ($version) ](fg:${background} bg:${color2})]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "fg:${background} bg:${color2}";
        format = "[[  $time ](fg:${background} bg:${color2})]($style)";
      };

      # Section 3
      docker_context = {
        symbol = " ";
        style = "fg:${background} bg:${color3}";
        format = "[[ $symbol $context ](fg:${background} bg:${color3})]($style) $path";
      };

      nix_shell = {
        symbol = "󱄅 ";
        impure_msg = ""; # Crow
        pure_msg = " "; # Dove
        unknown_msg = " ";
        style = "fg:${background} bg:${color3}";
        format = "[[ $symbol$state ](fg:${background} bg:${color3})]($style)";
      };
    };
  };
}

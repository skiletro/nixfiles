{ config, pkgs, lib, inputs, ... }:

{
    programs.starship = {
      enable = true;

      settings = {
        format = lib.concatStrings [
        "[ ](fg:#1e1e2e bg:#89B4FA)"
        "$username"
        "[](fg:#89B4FA)"
        "$directory"
        "[](fg:#1e1e2e bg:#fab387)"
        "$git_branch"
        "$git_status"
        "[](fg:#fab387 bg:#cba6f7)"
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
        "[](fg:#cba6f7 bg:#a6e3a1)"
        "$nix_shell"
        "$docker_context"
        "[ ](fg:#a6e3a1)"
        ];

        add_newline = false; # Disable the blank line at the start of the prompt

        # You can also replace your username with a neat symbol like  to save some space
        username = {
          show_always = true;
          style_user = "fg:#11111b bg:#89B4FA";
          style_root = "fg:#11111b bg:#f38ba8";
          format = "[$user ]($style)";
        };

        directory = {
          style = "fg:#cdd6f4";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
        };

        # Here is how you can shorten some long paths by text replacement
        # similar to mapped_locations in Oh My Posh:
        #[directory.substitutions]
        #"Documents" = " "
        #"Downloads" = " "
        #"Music" = " "
        #"Pictures" = " "
        #"~" = "󰋞 "
        # Keep in mind that the order matters. For example:
        # "Important Documents" = "  "
        # will not be replaced, because "Documents" was already substituted before.
        # So either put "Important Documents" before "Documents" or use the substituted version:
        # "Important  " = "  "

        c = {
          symbol = " ";
          style = "fg:#11111b bg:#cba6f7";
          format = "[[ $symbol ($version) ](fg:#11111b bg:#cba6f7)]($style)";
        };

        docker_context = {
          symbol = " ";
          style = "fg:#11111b bg:#a6e3a1";
          format = "[[ $symbol $context ](fg:#11111b bg:#a6e3a1)]($style) $path";
        };

        elixir = {
          symbol = " ";
          style = "fg:#11111b bg:#cba6f7";
          format = "[[ $symbol ($version) ](fg:#11111b bg:#cba6f7)]($style)";
        };

        elm = {
          symbol = " ";
          style = "fg:#11111b bg:#cba6f7";
          format = "[[ $symbol ($version) ](fg:#11111b bg:#cba6f7)]($style)";
        };

        git_branch = {
          symbol = "";
          style = "fg:#11111b bg:#fab387";
          format = "[[ $symbol $branch ](fg:#11111b bg:#fab387)]($style)";
        };

        git_status = {
          style = "fg:#11111b bg:#fab387";
          format = "[[($all_status$ahead_behind )](fg:#11111b bg:#fab387)]($style)";
        };

        golang = {
          symbol = " ";
          style = "fg:#11111b bg:##cba6f7";
          #format = "[[ $symbol ($version) ](fg:#11111b bg:#cba6f7)]($style)";
          format = "[[ $symbol](fg:#11111b bg:#cba6f7)]($style)";
        };

        haskell = {
          symbol = " ";
          style = "fg:#11111b bg:#cba6f7";
          format = "[[ $symbol ($version) ](fg:#11111b bg:#cba6f7)]($style)";
        };

        java = {
          symbol = " ";
          style = "fg:#11111b bg:#cba6f7";
          format = "[[ $symbol ($version) ](fg:#11111b bg:#cba6f7)]($style)";
        };

        julia = {
          symbol = " ";
          style = "fg:#11111b bg:#cba6f7";
          format = "[[ $symbol ($version) ](fg:#11111b bg:#cba6f7)]($style)";
        };

        nodejs = {
          symbol = "";
          style = "fg:#11111b bg:#cba6f7";
          format = "[[ $symbol ($version) ](fg:#11111b bg:#cba6f7)]($style)";
        };

        nim = {
          symbol = " ";
          style = "fg:#11111b bg:#cba6f7";
          format = "[[ $symbol ($version) ](fg:#11111b bg:#cba6f7)]($style)";
        };

        nix_shell = {
          symbol = "󱄅 ";
          impure_msg = "i";
          pure_msg = "p";
          unknown_msg = "u";
          style = "fg:#11111b bg:#a6e3a1";
          #format = "[[ via $symbol $state<$name> ](fg:#11111b bg:#cba6f7)]($style)";
          format = "[[ via $symbol $state ](fg:#11111b bg:#a6e3a1)]($style)";
        };

        rust = {
          symbol = "";
          style = "fg:#11111b bg:#cba6f7";
          format = "[[ $symbol ($version) ](fg:#11111b bg:#cba6f7)]($style)";
        };

        time = {
          disabled = false;
          time_format = "%R"; # Hour:Minute Format
          style = "fg:#11111b bg:#89b4fa";
          format = "[[  $time ](fg:#11111b bg:#89b4fa)]($style)";
        };
      };
    };

}

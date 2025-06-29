{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.eos.programs.terminal.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      languages = {
        language-server = {
          emmet-lsp = {
            command = "emmet-language-server";
            args = ["--stdio"];
          };
          gopls.config.gofumpt = true;
        };
        language = [
          {
            name = "html";
            # roots = [".git"];
            formatter = {
              command = "prettier";
              args = ["--parser" "html"];
            };
            language-servers = ["vscode-html-language-server" "emmet-lsp"];
          }
          {
            name = "tsx";
            formatter = {
              command = "prettier";
              args = ["--parser" "typescript"];
            };
            language-servers = ["vscode-html-language-server" "emmet-lsp"];
          }
          {
            name = "nix";
            formatter = {
              command = "alejandra";
              args = ["--quiet"];
              auto-format = true;
            };
          }
          {
            name = "fish";
            formatter.command = "fish_indent";
            auto-format = true;
          }
          {
            name = "go";
            auto-format = true;
          }
        ];
      };
      settings = {
        editor = {
          bufferline = "multiple";
          cursorline = true;
          true-color = true;
          line-number = "relative";
          rulers = [120];
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          indent-guides = {
            character = "‣";
            render = true;
            skip-levels = 1;
          };
          auto-pairs = true;
          lsp = {
            auto-signature-help = false;
            display-progress-messages = true;
            display-inlay-hints = true;
          };
          end-of-line-diagnostics = "hint";
          inline-diagnostics = {
            cursor-line = "error";
            other-lines = "disable";
          };
          statusline.left = ["mode" "spinner" "version-control" "file-name"];
        };
        keys = {
          select = {
            "X" = "select_line_above";
          };
        };
      };
    };
  };
}

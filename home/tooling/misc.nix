{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.eos.tooling.enable {
    home.packages = with pkgs; [
      bash-language-server # Bash
      docker-compose-language-service # Docker Compose
      dockerfile-language-server-nodejs # Dockerfile
      marksman # Markdown
      taplo # TOML
      yaml-language-server # YAML
    ];
  };
}

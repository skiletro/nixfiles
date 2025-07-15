{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.eos.programs.terminal.enable {
    # programs.beets = {
    #   enable = true;
    #   settings =
    #     # yaml
    #     ''
    #       directory = "~/Music"
    #       library = "~/Music/beets.db"
    #       import:
    #         move: yes
    #       plugins: fetchart lyrics lastgenre
    #     '';
    # };
    programs.beets = {
      enable = true;
      settings = {
        directory = "~/Music";
        library = "~/Music/beets.db";
        "import".move = true;
        plugins = ["fetchart" "lyrics" "lastgenre"];
      };
    };
  };
}

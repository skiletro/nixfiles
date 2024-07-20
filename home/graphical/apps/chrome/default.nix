{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.graphical.chrome.enable {
    programs.chromium = let
      package = pkgs.ungoogled-chromium;
    in {
      enable = true;
      package = package;
      extensions = let
        createChromiumExtensionFor = browserVersion: {
          id,
          sha256,
          version,
        }: {
          inherit id;
          crxPath = builtins.fetchurl {
            url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
            name = "${id}.crx";
            inherit sha256;
          };
          inherit version;
        };
        createChromiumExtension = createChromiumExtensionFor (lib.versions.major package.version);
      in [
        (createChromiumExtension {
          id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          version = "4.7";
          sha256 = "sha256:01kk94l38qqp2rbyylswjs8q25kcjaqvvh5b8088xria5mbrhskl";
        })
        (createChromiumExtension {
          id = "gjkjjhgjcalgefcimahpbacihndicccn";
          version = "4.7";
          sha256 = "sha256:0qyrdvc73wq4vqanpgdi274ikx759yrvs334sw7hixizrnpgq9a8";
        })
      ];
    };
  };
}

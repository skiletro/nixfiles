{
  appimageTools,
  fetchurl,
  makeDesktopItem,
}: let
  pname = "beeper";
  version = "3.74.4";
  name = "${pname}-${version}";
  src = fetchurl {
    url = "https://download.todesktop.com/2003241lzgn20jd/${pname}-${version}.AppImage";
    hash = "sha512-HQWZcgikYvOd+M3I8QZQr5cwK9Itat+Ru6V3wu55M0EEwbUiQSJPZFLbsW+cXNzqw3dFBaF00H5ZGe5VnM0+YA==";
    # Get hashes from https://download.todesktop.com/2003241lzgn20jd/latest-linux.yml
  };
  desktop-file = makeDesktopItem rec {
    name = "Beeper";
    exec = "beeper --default-frame --enable-features=UseOzonePlatform --ozone-platform=wayland";
    icon = "beeper";
    comment = "Unified Desktop";
    desktopName = "Beeper";
    genericName = "Beeper";
  };
  appimageContents = appimageTools.extractType2 {inherit name src;};
in
  appimageTools.wrapType2 {
    inherit name src;

    extraPkgs = pkgs:
      with pkgs; [
        libsecret
      ];

    extraInstallCommands = ''
      mv $out/bin/${name} $out/bin/${pname}

      mkdir -p $out/share/applications/
      ln -s ${desktop-file}/share/applications/* $out/share/applications

      install -m 444 -D ${appimageContents}/${pname}.png $out/share/icons/hicolor/512x512/apps/${pname}.png
    '';
  }

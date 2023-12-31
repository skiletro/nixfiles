{
  stdenv,
  pkgs,
}: let
  custom = ./custom;
in
  stdenv.mkDerivation {
    pname = "nvchad";
    version = "2.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "NvChad";
      repo = "NvChad";
      rev = "refs/heads/v2.0";
      sha256 = "sha256-tKMvKdB3jPSvcyewaOe8oak3pXhjAcLyyxgGMiMeqeU=";
    };

    installPhase = ''
      mkdir $out
      cp -r * "$out/"
      mkdir -p "$out/lua/custom"
      cp -r ${custom}/* "$out/lua/custom/"
    '';

    #meta = with lib; {
    #  description = "NvChad";
    #  homepage = "https://github.com/NvChad/NvChad";
    #  platforms = platforms.all;
    #  maintainers = [ maintainers.rayandrew ];
    #  license = licenses.gpl3;
    #};
  }

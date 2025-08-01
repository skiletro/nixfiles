{
  inputs',
  pkgs,
  lib,
  ...
}: let
  # inherit (inputs'.nixpkgs-unityhub-unfree.legacyPackages) unityhub;
  unityhub = inputs'.nixpkgs-unityhub-unfree.legacyPackages.unityhub.override {
    extraLibs = unityhubPkgs: [
      (unityhubPkgs.runCommand "libxml2-fake-old-abi" {} ''
        mkdir -p "$out/lib"
        ln -s "${unityhubPkgs.lib.getLib unityhubPkgs.libxml2}/lib/libxml2.so" "$out/lib/libxml2.so.2"
      '')
    ];
  };

  alcom = pkgs.symlinkJoin {
    name = "alcom";
    paths = [pkgs.alcom];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/ALCOM \
        --set WEBKIT_DISABLE_DMABUF_RENDERER 1
    '';
  };
in {
  home = {
    packages = [unityhub unityhub.fhsEnv alcom];

    file = let
      unityEditors = [
        "2022.3.22f1"
      ];
      editorDir = ".unity/Unity/Hub/Editor";
    in
      unityEditors
      |> map (version: "${editorDir}/${version}/Editor")
      |> map (path: {
        name = "${path}/unity-run";
        value = {
          executable = true;
          text = ''
            #! /bin/sh
            export LD_LIBRARY_PATH=/usr/lib
            exec ${lib.getExe unityhub.fhsEnv} ~/${path}/Unity "$@"
          '';
        };
      })
      |> lib.listToAttrs;
  };
}

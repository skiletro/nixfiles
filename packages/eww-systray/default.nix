{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, gtk3
, gdk-pixbuf
, withWayland ? true
, gtk-layer-shell
, stdenv
}:

rustPlatform.buildRustPackage rec {
  pname = "eww";
  version = "systray-2023-07-08";

  src = fetchFromGitHub {
    owner = "ralismark";
    repo = "eww";
    rev = "be553cb56f771e230aec5b9aff61f218c52d37d8";
    hash = "sha256-8e6gHSg6FDp6nU5v89D44Tqb1lR5aQpS0lXOVqzoUS4=";
  };

  cargoHash = "sha256-8PhaziqzS/rFVqRC4RtFC8UcqKFqMGv/d8scTTlKGzk=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ gtk3 gdk-pixbuf ] ++ lib.optional withWayland gtk-layer-shell;

  buildNoDefaultFeatures = true;
  buildFeatures = [
    (if withWayland then "wayland" else "x11")
  ];

  cargoBuildFlags = [ "--bin" "eww" ];

  cargoTestFlags = cargoBuildFlags;

  # requires unstable rust features
  RUSTC_BOOTSTRAP = 1;

  #meta = with lib; {
  #  description = "ElKowars wacky widgets";
  #  homepage = "https://github.com/elkowar/eww";
  #  license = licenses.mit;
  #  maintainers = with maintainers; [ figsoda lom ];
  #  broken = stdenv.isDarwin;
  #};
}

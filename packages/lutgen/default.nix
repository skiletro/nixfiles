{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "lutgen";
  version = "0.8.3";

  src = fetchFromGitHub {
    owner = "ozwaldorf";
    repo = "lutgen-rs";
    rev = "7a2026bb6e596474d1a90df033a0ad868b03ff81";
    sha256 = "sha256-9olBUPOi6ZQorgPxQX2lqZSlYjEPMwfhUF/Ze34v0nc=";
  };

  cargoHash = "sha256-hMbrzjfLSawrm+GmtLx7sQ7atr1aV2RU9rJXgun6HR8=";

  meta = with lib; {
    description = "Blazingly fast interpolated LUT generator and applicator for arbitrary and popular color palettes.";
    homepage = "https://github.com/ozwaldorf/lutgen-rs";
  };
}

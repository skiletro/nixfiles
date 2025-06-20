let
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINnFEMa0S9zuA5cVg+Ktazz9gEevkDCNYIDX0WAMxcAC eos"
  ];
in {
  "github-access-token.age".publicKeys = keys;
  "weather-plasmoid-location.age".publicKeys = keys;
  "user-password.age".publicKeys = keys;
}

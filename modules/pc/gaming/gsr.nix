# TODO: Replace this with the official module once it gets merged.
# https://github.com/NixOS/nixpkgs/pull/369574
{
  inputs',
  lib,
  config,
  ...
}: {
  config = let
    pkg = inputs'.nixpkgs-gsr-ui.legacyPackages.gpu-screen-recorder-ui.overrideAttrs (_: {
      patches = [./gsr-theme.patch]; # TODO: Finish this patch to allow for theming with Stylix. Very early days.
    });
  in
    lib.mkIf config.eos.programs.gaming.enable {
      programs.gpu-screen-recorder.enable = true;

      environment.systemPackages = [pkg];

      systemd.packages = [pkg];

      security.wrappers."gsr-global-hotkeys" = {
        owner = "root";
        group = "root";
        capabilities = "cap_setuid+ep";
        source = lib.getExe' pkg "gsr-global-hotkeys";
      };

      systemd.user.services.gpu-screen-recorder-ui.wantedBy = ["default.target"]; # Start on startup

      # TODO: Configure declaratively
      # Config file located at ~/.config/gpu-screen-recorder/config_ui
      # Not sure what language it uses; seems very much <option>.<suboption> <value>
      # Need to do some more research
    };
}

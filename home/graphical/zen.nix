{
  inputs',
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.eos.programs.enable {
    # This module seems very barebones at the moment, but it will allow for the browser to be configured a lot easier in the future.
    home.packages = [inputs'.zen-browser.packages.default];
  };
}

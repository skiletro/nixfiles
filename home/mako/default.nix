{ config, pkgs, lib, inputs, ... }:

{
  services.mako = {
    enable = true;
    backgroundColor = "#1E1E2E";
    textColor = "#CDD6F4";
    borderColor = "#CBA6F7";
    progressColor = "over #313244";
    
    font = "Iosevka Eos 10";
    borderRadius = 5;
    borderSize = 2;
    
    defaultTimeout = 7000;

    extraConfig = ''
      [urgency=high]
      border-color=#fab387
    '';
  };
}

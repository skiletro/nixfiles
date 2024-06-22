{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.services.swaync.enable {
    services.swaync = {
      enable = true;
      style = ./style.css;
      settings = {
        "positionX" = "right";
        "positionY" = "top";
        "control-center-margin-top" = 5;
        "control-center-margin-bottom" = 5;
        "control-center-margin-right" = 5;
        "control-center-margin-left" = 5;
        "control-center-width" = 400;
        "fit-to-screen" = true;

        "layer" = "top";
        "cssPriority" = "user";
        "notification-icon-size" = 64;
        "notification-body-image-height" = 100;
        "notification-body-image-width" = 200;
        "timeout" = 7;
        "timeout-low" = 5;
        "timeout-critical" = 0;
        "notification-window-width" = 350;
        "keyboard-shortcuts" = true;
        "image-visibility" = "when-available";
        "transition-time" = 200;
        "hide-on-clear" = true;
        "hide-on-action" = true;
        "script-fail-notify" = true;

        "widgets" = [
          "title"
          "notifications"
        ];

        "widget-config" = {
          "title" = {
            "text" = "Notifications";
            "clear-all-button" = true;
            "button-text" = "Clear All";
          };
        };
      };
    };
  };
}

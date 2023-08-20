{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.wofi = {
    enable = true;
    settings = {
      width = 400;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 28;
      gtk_dark = true;
      columns = 1;
    };

    style = ''
      @define-color clear rgba(0, 0, 0, 0.0);
      @define-color mauve #cba6f7;
      @define-color background #1e1e2e;
      @define-color foreground #313244;

      window {
          margin: 5px;
          background-color: @clear;
      }

      #outer-box {
          margin: 5px;
          border: 2px solid @mauve;
          background-color: @background;
          border-radius: 10px;
      }

      #input {
          margin: 10px;
          /*border: 2px solid blue;*/
          background-color: @background;
      }

      #inner-box {
          margin: 5px;
          /*border: 2px solid yellow;
          background-color: yellow;*/
      }

      #scroll {
          margin: 5px;
          /*border: 2px solid orange;
          background-color: orange;*/
      }

      #text {
          margin: 5px;
          /*border: 2px solid cyan;
          background-color: cyan;*/
      }

      #entry:selected {
          background-color: @mauve;
      }

      #text:selected {
          color: @background;
      }
    '';
  };
}

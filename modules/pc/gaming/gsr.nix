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
      patches = [
        (builtins.toFile "gsr-theme.patch"
          # diff
          ''
            diff --git a/src/Overlay.cpp b/src/Overlay.cpp
            index c3ae5ae..359cd7e 100644
            --- a/src/Overlay.cpp
            +++ b/src/Overlay.cpp
            @@ -811,7 +811,7 @@ namespace gsr {

                         window->draw(top_bar_background);
                         window->draw(top_bar_text);
            -            window->draw(logo_sprite);
            +            // window->draw(logo_sprite);

                         close_button_widget.draw(*window, mgl::vec2f(0.0f, 0.0f));
                         page_stack.draw(*window, mgl::vec2f(0.0f, 0.0f));
            diff --git a/src/Theme.cpp b/src/Theme.cpp
            index 2bef3c8..14e18f0 100644
            --- a/src/Theme.cpp
            +++ b/src/Theme.cpp
            @@ -29,7 +29,7 @@ namespace gsr {
                         vendor = GpuVendor::NVIDIA;
                     else if(color_name == "broadcom")
                         vendor = GpuVendor::BROADCOM;
            -        return gpu_vendor_to_color(vendor);
            +        return mgl::Color(89, 193, 191);
                 }

                 bool Theme::set_window_size(mgl::vec2i window_size) {
            diff --git a/src/gui/GlobalSettingsPage.cpp b/src/gui/GlobalSettingsPage.cpp
            index 6650c69..d69ec69 100644
            --- a/src/gui/GlobalSettingsPage.cpp
            +++ b/src/gui/GlobalSettingsPage.cpp
            @@ -146,16 +146,8 @@ namespace gsr {
                     list->add_widget(std::make_unique<Label>(&get_theme().body_font, "Accent color", get_color_theme().text_color));
                     auto tint_color_radio_button = std::make_unique<RadioButton>(&get_theme().body_font, RadioButton::Orientation::HORIZONTAL);
                     tint_color_radio_button_ptr = tint_color_radio_button.get();
            -        tint_color_radio_button->add_item("Red", "amd");
            -        tint_color_radio_button->add_item("Green", "nvidia");
            -        tint_color_radio_button->add_item("Blue", "intel");
                     tint_color_radio_button->on_selection_changed = [](const std::string&, const std::string &id) {
            -            if(id == "amd")
            -                get_color_theme().tint_color = mgl::Color(221, 0, 49);
            -            else if(id == "nvidia")
            -                get_color_theme().tint_color = mgl::Color(118, 185, 0);
            -            else if(id == "intel")
            -                get_color_theme().tint_color = mgl::Color(8, 109, 183);
            +            get_color_theme().tint_color = mgl::Color(89, 193, 191);
                         return true;
                     };
                     list->add_widget(std::move(tint_color_radio_button));

          '')
      ];
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

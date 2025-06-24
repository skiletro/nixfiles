{
  lib,
  osConfig,
  inputs,
  ...
}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  config = lib.mkIf osConfig.eos.programs.enable {
    programs.nixcord = {
      enable = true;
      discord.enable = false;
      vesktop = {
        enable = true;
        autoscroll.enable = true;
      };
      config = {
        useQuickCss = true;
        themeLinks = [
          "https://chloecinders.github.io/visual-refresh-compact-title-bar/browser.css"
          "https://raw.githubusercontent.com/Krammeth/css-snippets/refs/heads/main/PopoutsRevamped.css"
          "https://abbie.github.io/discord-css/import.css"
        ];
        plugins = {
          betterGifPicker.enable = true;
          crashHandler.enable = true;
          fakeNitro.enable = true;
          favoriteGifSearch.enable = true;
          fixSpotifyEmbeds.enable = true;
          fixYoutubeEmbeds.enable = true;
          noSystemBadge.enable = true;
          openInApp.enable = true;
          serverInfo.enable = true;
          unindent.enable = true;
          userVoiceShow.enable = true;
          youtubeAdblock.enable = true;
        };
      };
      quickCss =
        # css
        ''
          :root {
              --\\--compact-title-bar: true;
              --\\--compact-input-box: true;
              --\\--compact-context-menu: true;
              --\\--compact-user-area: true;
              --\\--compact-channel-categories: true;
              --\\--compact-server-list: false;

              --\\--hide-nameplates: true;
              --\\--hide-guild-tags: true;
              --\\--hide-profile-effects: true;
              --\\--hide-avatar-decorations: true;
              --\\--hide-gradient-glow-usernames: true;
              --\\--hide-server-boost-goal: true;
              --\\--hide-server-activity: true;
              --\\--hide-user-activity: true;
              --\\--hide-context-menu-quick-reactions: true;
              --\\--hide-hover-quick-reactions: false;
              --\\--hide-image-edit-button: true;
              --\\--hide-gif-button: false;
              --\\--hide-sticker-button: false;
              --\\--hide-emoji-button: false;
              --\\--hide-apps-button: true;
              --\\--hide-gift-button: true;
              --\\--hide-help-button: false;
              --\\--hide-shop-button: true;
              --\\--hide-nitro-button: true;
              --\\--hide-nitro-upsells: true;
              --\\--hide-vencord-desktop-platform-indicator: true;
              --\\--hide-cluttery-badges: true;
              /* ^ hides quest, hypesquad, active dev, and discriminator badges */

              --\\--darker-scrollbar: true;
              --\\--darker-hovered-message: true;
              --\\--prevent-sidebar-resizing: false;
              --\\--fix-minor-icon-misalignments: true;
          }
        '';
    };
  };
}

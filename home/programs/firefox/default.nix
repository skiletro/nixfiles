{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.firefox.enable {
    stylix.targets.firefox.enable = false;

    programs.firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DisableSetDesktopBackground = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          OfferToSaveLoginsDefault = false;
          PasswordManagerEnabled = false;
          DontCheckDefaultBrowser = true;
          FirefoxHome = {
            Search = true;
            Pocket = false;
            Snippets = false;
            TopSites = false;
            Highlights = false;
          };
          UserMessaging = {
            ExtensionRecommendations = false;
            SkipOnboarding = true;
          };
          ExtensionSettings = {};
        };
      };
      profiles.jamie = {
        id = 0;
        isDefault = true;
        name = "jamie";
        search = {
          force = true;
          default = "DuckDuckGo";
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@n"];
            };
            "Flathub" = {
              urls = [
                {
                  template = "https://flathub.org/apps/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["@flathub" "@fh"];
            };
          };
        };
        settings = {
          "general.smoothScroll" = true;
          "general.smoothScroll.msdPhysics.enabled" = true;
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "media.hardware-video-decoding.force-enabled" = true;

          # Settings stolen from https://github.com/yokoffing/BetterFox
          "content.notify.interval" = 100000;
          "gfx.canvas.accelerated.cache-items" = 4096;
          "gfx.canvas.accelerated.cache-size" = 512;
          "gfx.content.skia-font-cache-size" = 20;
          "browser.cache.jsbc_compression_level" = 3;
          "media.memory_cache_max_size" = 65536;
          "media.cache_readahead_limit" = 7200;
          "media.cache_resume_threshold" = 3600;
          "image.mem.decode_bytes_at_a_time" = 32768;
          "network.http.max-connections" = 1800;
          "network.http.max-persistent-connections-per-server" = 10;
          "network.http.max-urgent-start-excessive-connections-per-host" = 5;
          "network.http.pacing.requests.enabled" = false;
          "network.dnsCacheExpiration" = 3600;
          "network.ssl_tokens_cache_capacity" = 10240;
          "network.dns.disablePrefetch" = true;
          "network.dns.disablePrefetchFromHTTPS" = true;
          "network.prefetch-next" = false;
          "network.predictor.enabled" = false;
          "network.predictor.enable-prefetch" = false;
          "layout.css.grid-template-masonry-value.enabled" = true;
          "dom.enable_web_task_scheduling" = true;
          "dom.security.sanitizer.enabled" = true;
          "browser.contentblocking.category" = "strict";
          "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
          "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";
          "network.cookie.sameSite.noneRequiresSecure" = true;
          "browser.download.start_downloads_in_tmp_dir" = true;
          "browser.helperApps.deleteTempFileOnExit" = true;
          "browser.uitour.enabled" = false;
          "privacy.globalprivacycontrol.enabled" = true;
          "security.OCSP.enabled" = 0;
          "security.remote_settings.crlite_filters.enabled" = true;
          "security.pki.crlite_mode" = 2;
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "security.tls.enable_0rtt_data" = false;
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "browser.sessionstore.interval" = 60000;
          "privacy.history.custom" = true;
          "browser.search.separatePrivateDefault.ui.enabled" = true;
          "browser.urlbar.update2.engineAliasRefresh" = true;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.formfill.enable" = false;
          "security.insecure_connection_text.enabled" = true;
          "security.insecure_connection_text.pbmode.enabled" = true;
          "network.IDN_show_punycode" = true;
          "dom.security.https_first" = true;
          "dom.security.https_first_schemeless" = true;
          "signon.formlessCapture.enabled" = false;
          "signon.privateBrowsingCapture.enabled" = false;
          "network.auth.subresource-http-auth-allow" = 1;
          "editor.truncate_user_pastes" = false;
          "security.mixed_content.block_display_content" = true;
          "security.mixed_content.upgrade_display_content" = true;
          "security.mixed_content.upgrade_display_content.image" = true;
          "pdfjs.enableScripting" = false;
          "extensions.postDownloadThirdPartyPrompt" = false;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "privacy.userContext.ui.enabled" = true;
          "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
          "media.peerconnection.ice.default_address_only" = true;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "permissions.default.desktop-notification" = 2;
          "permissions.default.geo" = 2;
          "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
          "permissions.manager.defaultsUrl" = "";
          "webchannel.allowObject.urlWhitelist" = "";
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "data: =";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "app.shield.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "captivedetect.canonicalURL" = "";
          "network.captive-portal-service.enabled" = false;
          "network.connectivity-service.enabled" = false;
          "browser.privatebrowsing.vpnpromourl" = "";
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.preferences.moreFromMozilla" = false;
          "browser.tabs.tabmanager.enabled" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.aboutwelcome.enabled" = false;
          "browser.compactmode.show" = true;
          "browser.display.focus_ring_on_anything" = true;
          "browser.display.focus_ring_style" = 0;
          "browser.display.focus_ring_width" = 0;
          "layout.css.prefers-color-scheme.content-override" = 2;
          "browser.privateWindowSeparation.enabled" = false;
          "cookiebanners.service.mode" = 1;
          "cookiebanners.service.mode.privateBrowsing" = 1;
          "full-screen-api.transition-duration.enter" = "0 0";
          "full-screen-api.transition-duration.leave" = "0 0";
          "full-screen-api.warning.delay" = -1;
          "full-screen-api.warning.timeout" = 0;
          "browser.urlbar.suggest.calculator" = true;
          "browser.urlbar.unitConversion.enabled" = true;
          "browser.urlbar.trending.featureGate" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "extensions.pocket.enabled" = false;
          "browser.download.always_ask_before_handling_new_types" = true;
          "browser.download.manager.addToRecentDocs" = false;
          "browser.download.open_pdf_attachments_inline" = true;
          "browser.bookmarks.openInTabClosesMenu" = false;
          "browser.menu.showViewImageInfo" = true;
          "findbar.highlightAll" = true;
          "layout.word_select.eat_space_to_next_word" = false;
          "browser.search.suggest.enabled" = true;
          "privacy.userContext.enabled" = true;
          "gfx.canvas.accelerated" = true;
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          translate-web-pages
          ublock-origin
          decentraleyes
          sponsorblock
          augmented-steam
          protondb-for-steam
          fediact
          youtube-shorts-block
          i-dont-care-about-cookies
          sidebery
          plasma-integration
        ];
        # modified theme from https://github.com/Bali10050/FirefoxCSS
        #userChrome = builtins.readFile ./userChrome.css;
        #userContent = builtins.readFile ./userContent.css;
      };
    };
  };
}

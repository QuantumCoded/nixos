toplevel: { config, lib, pkgs, ... }:
let
  # TODO: figure out if using self here causes "dangling pointer" issues
  # when importing from another flake
  inherit (toplevel.config.flake.builders.${pkgs.system})
    buildFirefoxXpiAddon
    ;

  inherit (lib)
    mkEnableOption
    mkIf
    ;

  customAddons = {
    yomichan = buildFirefoxXpiAddon rec {
      pname = "yomitan";
      version = "24.5.5.0";
      addonId = "${pname}-${version}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4285904/yomitan-24.5.5.0.xpi";
      sha256 = "sha256-8t5K0e6J96YLqOFkFx10yhh/oA5DMt9iuuPi/O4sIdk=";
      meta = {
        homepage = "https://github.com/themoeway/yomitan";
        description = "Yomitan turns your browser into a tool for building Japanese language literacy by helping you to decipher texts which would be otherwise too difficult tackle. It features a robust dictionary with EPWING and flashcard creation support.";
        platforms = lib.platforms.all;
      };
    };
  };

  cfg = config.base.firefox;
in
{
  options.base.firefox = {
    enable = mkEnableOption "Firefox";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      profiles.default = {
        extensions =
          with pkgs.nur.repos.rycee.firefox-addons;
          with customAddons;
          [
            darkreader
            keepassxc-browser
            return-youtube-dislikes
            sponsorblock
            tree-style-tab
            ublock-origin
            web-scrobbler
            yomichan
          ];

        settings = {
          # Don't save passwords.
          "signon.rememberSignons" = false;

          # Don't show a warning when opening about:config. I know what I'm doing!
          "browser.aboutConfig.showWarning" = false;

          # Disable telemetry.
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "browser.tabs.crashReporting.sendReport" = false;
          "devtools.onboarding.telemetry.logged" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.pioneer-new-studies-available" = false;

          # Disable Firefox Pocket.
          "extensions.pocket.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;

          # Disable Firefox View.
          "browser.tabs.firefox-view" = false;
          "browser.tabs.firefox-view-next" = false;

          # Disable Firefox account features
          "identity.fxaccounts.enabled" = false;

          # Enable dark theme.
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "browser.theme.content-theme" = 2;
          "browser.theme.toolbar-theme" = 2;
        };
      };
    };
  };
}

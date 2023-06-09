{}:
{ self, pkgs, lib, ... }:
let
  inherit (self.lib) buildFirefoxXpiAddon;

  customPackages = {
    yomichan = buildFirefoxXpiAddon {
      pname = "yomichan";
      version = "20.5.22.1";
      addonId = "alex@foosoft.net";
      url = "https://addons.mozilla.org/firefox/downloads/file/3585060/yomichan-20.5.22.1.xpi";
      sha256 = "sha256-/icvPD/nCJYS31owfYMD25QzFjsxAqapy/UAehhxsy8=";
      meta = {
        homepage = "https://foosoft.net/projects/yomichan/";
        description = "Yomichan turns your browser into a tool for building Japanese language literacy by helping you to decipher texts which would be otherwise too difficult tackle. It features a robust dictionary with EPWING and flashcard creation support.";
        platforms = lib.platforms.all;
      };
    };
  };
in
{
  programs.firefox = {
    enable = true;

    profiles.default = {
      extensions =
        with pkgs.nur.repos.rycee.firefox-addons;
        with customPackages;
        [
          darkreader
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

        # Disable Firefox Pocket.
        "extensions.pocket.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;

        # Disable Firefox View.
        "browser.tabs.firefox-view" = false;

        # Disable Firefox account features
        "identity.fxaccounts.enabled" = false;

        # FIXME: Enable dark theme.
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "browser.theme.content-theme" = 2;
        "browser.theme.toolbar-theme" = 2;
      };
    };
  };
}

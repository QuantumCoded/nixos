{ config, lib, ... }:
let

  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.base.firefox;
in
{
  options.base.firefox = {
    enable = mkEnableOption "Firefox";

    extensions = mkOption {
      type = with types; listOf package;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      profiles.default = {
        inherit (cfg) extensions;
        # extensions =
        #   with pkgs.nur.repos.rycee.firefox-addons;
        #   with customAddons;

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

{ pkgs, lib, ... }:

let
  buildFirefoxXpiAddon = lib.makeOverridable (
    { stdenv ? pkgs.stdenv
    , fetchurl ? pkgs.fetchurl
    , pname
    , version
    , addonId
    , url
    , sha256
    , meta
    , ...
    }:
    stdenv.mkDerivation {
      name = "${pname}-${version}";

      inherit meta;

      src = fetchurl { inherit url sha256; };

      preferLocalBuild = true;
      allowSubstitutes = true;

      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$src" "$dst/${addonId}.xpi"
      '';
    }
  );
in
{
  programs.firefox = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        darkreader
        ublock-origin
        return-youtube-dislikes
        web-scrobbler
        sponsorblock
        tree-style-tab
        (buildFirefoxXpiAddon {
          pname = "yomichan";
          version = "20.5.22.1";
          addonId = "alex@foosoft.net";
          url = "https://addons.mozilla.org/firefox/downloads/file/3585060/yomichan-20.5.22.1.xpi";
          sha256 = "sha256-/icvPD/nCJYS31owfYMD25QzFjsxAqapy/UAehhxsy8=";
          meta = with lib; {
            homepage = "https://foosoft.net/projects/yomichan/";
            description = "Yomichan turns your browser into a tool for building Japanese language literacy by helping you to decipher texts which would be otherwise too difficult tackle. It features a robust dictionary with EPWING and flashcard creation support.";
            platforms = platforms.all;
          };
        })
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

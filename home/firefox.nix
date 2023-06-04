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
    package = pkgs.firefox;
    profiles.default = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
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
    };
  };
}

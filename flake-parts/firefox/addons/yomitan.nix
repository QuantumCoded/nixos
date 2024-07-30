{ buildFirefoxXpiAddon, lib, ... }:

buildFirefoxXpiAddon rec {
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
}

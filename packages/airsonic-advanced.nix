{ airsonic, fetchurl }:

airsonic.overrideAttrs (final: prev: rec {
  pname = "airsonic-advanced";
  version = "10.6.0";

  src = fetchurl {
    url = "https://github.com/airsonic-advanced/airsonic-advanced/releases/download/v${version}/airsonic.war";
    hash = "sha256-Uo9BfllJkWGtf9i4bTkePH7/cOCCVGXjFfhtNBdmTGk=";
  };

  meta.homepage = "https://github.com/airsonic-advanced";
})
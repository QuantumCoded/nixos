{ airsonic, fetchurl }:

airsonic.overrideAttrs (final: prev: {
  pname = "airsonic-advanced";
  version = "11.0.0-snapshot-20230217142243";

  src = fetchurl {
    url = "https://github.com/airsonic-advanced/airsonic-advanced/releases/download/11.0.0-SNAPSHOT.20230217142243/airsonic.war";
    hash = "sha256-hNN9NFhqoqYzWgIU10OgUY6C19Zo6MwUKrsS4gIRIg8=";
  };

  meta.homepage = "https://github.com/airsonic-advanced";
})

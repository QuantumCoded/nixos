{ appimageTools, fetchurl }:

appimageTools.wrapType1 rec {
  pname = "imhex";
  version = "1.35.3";
  src = fetchurl {
    url = "https://github.com/WerWolv/ImHex/releases/download/v${version}/imhex-${version}-x86_64.AppImage";
    hash = "sha256-xZD3PxiEGZ0aJmDvaU5mvxvqXyIHEJOtL6wrcyhK/jw=";
  };
}

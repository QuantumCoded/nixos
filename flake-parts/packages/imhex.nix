{ appimageTools, fetchurl }:

appimageTools.wrapType1
{
  pname = "imhex";
  version = "1.34.0";
  src = fetchurl {
    url = "https://github.com/WerWolv/ImHex/releases/download/v1.34.0/imhex-1.34.0-x86_64.AppImage";
    hash = "sha256-OTNYNhRsSsOxaeNBWb7NiYxGjSuwANNCwqjI5CBHjwo=";
  };
}

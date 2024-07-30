let
  transposeModule = import ./transpose.nix;
in
{
  imports = [
    ./addons
    transposeModule
  ];

  flake = {
    homeModules.firefox = import ./home-module.nix;
    transposeModules.firefoxAddons = transposeModule;
  };

  perSystem = { pkgs, ... }: {
    builders.buildFirefoxXpiAddon =
      pkgs.callPackage (import ./build-firefox-xpi-addon.nix);
  };
}

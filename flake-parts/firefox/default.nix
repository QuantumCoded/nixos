args @ { ... }:

{
  flake = {
    homeModules.firefox = import ./home-module.nix args;
  };

  perSystem = { pkgs, ... }: {
    builders.buildFirefoxXpiAddon =
      pkgs.callPackage (import ./build-firefox-xpi-addon.nix);
  };
}

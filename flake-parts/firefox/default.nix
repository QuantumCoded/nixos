{ config, ... }:

{
  flake = {
    homeModules.firefox = import ./home-module.nix { inherit config; };
  };

  perSystem = { pkgs, ... }: {
    builders.buildFirefoxXpiAddon =
      pkgs.callPackage (import ./build-firefox-xpi-addon.nix);
  };
}

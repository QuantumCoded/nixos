{
  flake = {
    serviceModules.airsonic = import ./service.nix;
  };

  perSystem = { pkgs, ... }: {
    packages.airsonic-advanced = pkgs.callPackage ./package.nix { };
  };
}

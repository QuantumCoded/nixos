{
  flake = {
    nixosModules.deemix = import ./nixos.nix;
    serviceModules.deemix = import ./service.nix;
  };

  perSystem = { pkgs, ... }: {
    packages.deemix-server = pkgs.callPackage ./package.nix { };
  };
}

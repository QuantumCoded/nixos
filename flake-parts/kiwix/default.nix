{
  flake = {
    nixosModules.kiwix = import ./nixos.nix;
    serviceModules.kiwix = import ./service.nix;
  };
}

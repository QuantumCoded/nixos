{
  flake = {
    nixosModules.minecraft = import ./nixos.nix;
    serviceModules.minecraft = import ./service.nix;
  };
}

{
  flake = {
    # nixosModules.ankisyncd = import ./nixos.nix;
    serviceModules.ankisyncd = import ./service.nix;
  };
}

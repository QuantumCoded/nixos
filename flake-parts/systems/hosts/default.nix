{
  config.flake.hostModules = {
    avalon = import ./modules/avalon.nix;
    dad = import ./modules/dad.nix;
    hydrogen = import ./modules/hydrogen.nix;
    odyssey = import ./modules/odyssey.nix;
    quantum = import ./modules/quantum.nix;
  };
}

{
  config.flake.hostModules = {
    avalon = import ./modules/avalon.nix;
    hydrogen = import ./modules/hydrogen.nix;
    odyssey = import ./modules/odyssey.nix;
    quantum = import ./modules/quantum.nix;
  };
}

_: { config, ... }:

{
  flake.transpose = {
    builders = import ./builders.nix;
    home-config = import ./home-config.nix;
    default.imports = with config.flake; lib.combineModules transpose;
  };
}

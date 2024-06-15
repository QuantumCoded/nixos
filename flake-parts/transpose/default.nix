{ config, ... }:
let
  inherit (config.flake.lib)
    combineModules
    ;

  modules = {
    builders = import ./builders.nix;
    home-config = import ./home-config.nix;
    machines = import ./machines.nix;
    nixos-config = import ./nixos-config.nix;
  };
in
{
  imports = builtins.attrValues modules;

  flake.transpose = modules // {
    default.imports = combineModules config.flake.transpose;
  };
}

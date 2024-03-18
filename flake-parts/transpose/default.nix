_: { config, flake-parts-lib, ... }:
let
  inherit (config.flake.lib)
    combineModules
    ;

  inherit (flake-parts-lib)
    importApply
    ;

  modules = {
    builders = importApply ./builders.nix;
    home-config = importApply ./home-config.nix;
    machines = importApply ./machines.nix;
    nixos-config = importApply ./nixos-config.nix;
  };
in
{
  imports = builtins.attrValues modules;

  flake.transpose = modules // {
    default.imports = combineModules config.flake.transpose;
  };
}

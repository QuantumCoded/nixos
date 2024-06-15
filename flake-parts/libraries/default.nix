args @ { config, ... }:

{
  flake = {
    lib = {
      combineModules = import ./combine-modules.nix args;
      nvencUnlock = import ./nvenc-unlock.nix;
      nvfbcUnlock = import ./nvfbc-unlock.nix;
    };

    libraries = config.flake.lib;
  };
}

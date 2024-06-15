{
  flake = {
    lib = {
      nvencUnlock = import ./nvenc-unlock.nix;
      nvfbcUnlock = import ./nvfbc-unlock.nix;
    };

    nixosModules.nvidia = import ./nixos.nix;
  };
}

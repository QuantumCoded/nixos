_: { config, inputs, ... }:

{
  flake.nixosModules.wireguard = import ./nixos-module.nix;

  wireguard = {
    enable = true;

    networks.asluni = {
      peers.by-name = {
        hydrogen.sopsLookup = "luninet-hydrogen";
        quantum.sopsLookup = "luninet-quantum";
      };
    };
  };
}

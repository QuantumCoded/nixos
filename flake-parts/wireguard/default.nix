_: { config, ... }:

{
  flake = {
    nixosModules.wireguard = import ./nixos-module.nix;
    wireguardHosts = {
      hydrogen = import ./hosts/hydrogen.nix;
      quantum = import ./hosts/quantum.nix;
    };
  };

  wireguard = {
    enable = true;

    networks.luninet = {
      listenPort = 63723;
      sopsLookup = "legacynet";
      peers.by-name = {
        cardinal = {
          publicKey = "2Q5yU5ueoDcEc+Segj/FJZ61IIiLWUVHtzf4uV31NjI=";
          ipv4 = [ "172.16.2.1/32" ];
          selfEndpoint = "unallocatedspace.dev:63723";
        };

        artix = {
          publicKey = "3CThsm++hbh48Oe7BX6PNQhUyWoCMsaq3gd0KvCoITM=";
          ipv4 = [ "172.16.2.2/32" ];
          selfEndpoint = "23.94.99.203:63723";
        };

        cypress = {
          publicKey = "nvuYPHJ2BUjXGyUMwr03XZYTMZGSQDyv3vDfZpGzfwo=";
          ipv4 = [ "172.16.2.3/32" ];
          selfEndpoint = "98.46.211.251:63723";
        };

        hydrogen = {
          sopsLookup = "luninet-hydrogen";
          publicKey = "qXsTs+IsmHeq9+rulmG6M7XhVgu/3N/wEgEaHPuHciU=";
          ipv4 = [ "172.16.2.4/32" ];
        };

        quantum = {
          sopsLookup = "luninet-quantum";
          publicKey = "FuOo9TwnE8P/zDBorjGNtsyPImHsHPxA21ePNrElsD0=";
          ipv4 = [ "172.16.2.5/32" ];
        };
      };
    };
  };
}

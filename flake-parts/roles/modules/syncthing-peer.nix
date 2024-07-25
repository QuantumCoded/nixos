{ inputs, ... }: {
  base.syncthing = {
    enable = true;
    networks = inputs.homelab.syncthingNetworks;
  };
}

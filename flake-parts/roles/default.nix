{
  imports = [
    ./flake-module.nix
  ];

  config.roles = {
    desktop = import ./modules/desktop.nix;
    laptop = import ./modules/laptop.nix;
    podman = import ./modules/podman.nix;
    server = import ./modules/server.nix;
    syncthing-peer = import ./modules/syncthing-peer.nix;
    virtualization = import ./modules/virtualization.nix;
    workstation = import ./modules/workstation.nix;
  };
}

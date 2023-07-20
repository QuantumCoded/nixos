{
  imports = [
    ./services/dmx-server.nix
    ./services/minecraft.nix

    ./boot.nix
    ./flakes.nix
    ./home-manager.nix
    ./networkmanager.nix
  ];
}
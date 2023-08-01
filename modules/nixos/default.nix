{
  imports = [
    ./services/deemix-server.nix
    ./services/minecraft.nix

    ./boot.nix
    ./direnv.nix
    ./flakes.nix
    ./home-manager.nix
    ./networkmanager.nix
  ];
}

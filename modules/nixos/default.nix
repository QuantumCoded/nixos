{
  imports = [
    ./services/deemix-server.nix
    # FIXME: this is to be stablized in 23.11
    ./services/homepage-dashboard.nix
    ./services/minecraft.nix

    ./boot.nix
    ./direnv.nix
    ./flakes.nix
    ./home-manager.nix
    ./networkmanager.nix
    ./nvidia.nix
    ./tuigreet.nix
    ./virtualization.nix
  ];
}

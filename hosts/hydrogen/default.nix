{
  imports = [
    ../../roles/server.nix

    ../odyssey/hardware.nix
    ../odyssey/storage.nix
  ];

  networking.hostName = "quantum";
}
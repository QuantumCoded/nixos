{
  imports = [
    ../../roles/server.nix

    ../odyssey/hardware.nix
    ../odyssey/storage.nix
  ];

  networking.hostName = "hydrogen";

  fileSystems."/data" = {
    device = "docker.vmlan:/data";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
    ];
  };
}

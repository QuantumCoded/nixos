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

  users.users.jeff.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO0Z+jY49Owc0MeSyZLUgBdfct6PFEUWwvBfBmz0Cyzn"
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO0Z+jY49Owc0MeSyZLUgBdfct6PFEUWwvBfBmz0Cyzn"
  ];

  nix.settings = {
    trusted-public-keys = [
      (builtins.readFile ../../keys/binary-cache-key.pub.pem)
    ];

    trusted-users = [ "jeff" ];
  };
}

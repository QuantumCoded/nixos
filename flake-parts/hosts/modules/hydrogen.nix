{
  nixos = {
    networking = {
      hostName = "hydrogen";
      useDHCP = false;

      defaultGateway = "10.0.0.1";
      nameservers = [ "10.0.0.1" ];

      interfaces.eno1.ipv4.addresses = [
        { address = "10.0.0.2"; prefixLength = 16; }
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
        "jeff:QCsq/cN4wqrtxfE4366vn2HZEDh+nk6ywytHOl8LnVY="
      ];

      trusted-users = [ "jeff" ];
    };
  };
}

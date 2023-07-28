{
  imports = [
    ../../roles/server.nix

    ./hardware.nix
    ./storage.nix
  ];

  networking =
    let
      addresses = [
        { address = "10.0.0.2"; prefixLength = 16; }
      ];
    in
    {
      hostName = "hydrogen";
      useDHCP = false;
      defaultGateway = "10.0.0.1";
      nameservers = [ "10.0.0.1" ];
      # interfaces = {
      #   eth1.ipv4 = { address = "10.0.0.2"; prefixLength = 16; };
      #   eth2.ipv4 = { address = "10.0.0.2"; prefixLength = 16; };
      #   eth3.ipv4 = { address = "10.0.0.2"; prefixLength = 16; };
      #   eth4.ipv4 = { address = "10.0.0.2"; prefixLength = 16; };
      # };
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

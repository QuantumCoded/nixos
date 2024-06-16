let
  # Users
  jeff = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO0Z+jY49Owc0MeSyZLUgBdfct6PFEUWwvBfBmz0Cyzn";

  # Systems
  avalon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEcFB9THiR0c6K1pfCl+eG1kIPiJ5QZuCA1PbQJdmHT+";
  hydrogen = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOibBFyzpvrT7Q1F1kywc2gIOsog8HdVSUl5IXa1aHQs";
  odyssey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPzbqF8beGqcGqfij9TVBxWZ4wT0t651UYqFKOjSSXr/";
  quantum = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDoCx1wXiAMb01U2JAM5xHmdLlPnd81EITSNn4FDkMvK";

  allUsers = [ jeff ];
  allSystems = [ avalon hydrogen odyssey quantum ];

  everywhere = allUsers ++ allSystems;
in
{
  "attic-credentials.age".publicKeys = everywhere;
  "attic-local-token.age".publicKeys = everywhere;
  "luninet-hydrogen.age".publicKeys = everywhere;
  "luninet-quantum.age".publicKeys = everywhere;
  "pgadmin.age".publicKeys = everywhere;
  "wifi_5g.age".publicKeys = everywhere;
  "wifi.age".publicKeys = everywhere;
  "woodpecker-agent-env.age".publicKeys = everywhere;
  "woodpecker-server-env.age".publicKeys = everywhere;
}  

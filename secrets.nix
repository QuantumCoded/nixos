let
  # Users
  jeff = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKmy0ao1cTPHV7J+CHOQk/+QxDHVXtcBqzNMnGHzpD3X";

  # Systems
  quantum = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAzys7fCbrIfHZGYBu0jBOU/mdlMTPk7oZ26IBorBtt+";

  allUsers = [ jeff ];
  allSystems = [ quantum ];

  everywhere = allUsers ++ allSystems;
in
{
  "email.age".publicKeys = everywhere;
}  

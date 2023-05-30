let
  # Users
  jeff = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKmy0ao1cTPHV7J+CHOQk/+QxDHVXtcBqzNMnGHzpD3X";

  # Systems
  quantum = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAzys7fCbrIfHZGYBu0jBOU/mdlMTPk7oZ26IBorBtt+";
  odyssey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHnDCaJaBKHeaUW/VdH2CMVEpoRtKqnlg7+omBU7dvJg";

  allUsers = [ jeff ];
  allSystems = [ quantum odyssey ];

  everywhere = allUsers ++ allSystems;
in
{
  "email.age".publicKeys = everywhere;
}  

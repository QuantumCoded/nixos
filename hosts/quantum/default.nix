{ ... }:

{
  imports = [
    ../../roles/desktop.nix

    ./hardware.nix
    ./nvidia.nix
    ./storage.nix
  ];

  # set users and usernames here?
  # set the display resolution command!
}
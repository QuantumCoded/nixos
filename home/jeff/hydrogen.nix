{ ... }:

{
  imports = [
    ({ pkgs, ... }: {
      imports = [
        # Home
        (import ../../base/user/home/git.nix { userName = "QuantumCoded"; })
        (import ../../base/user/home/home-manager.nix { userName = "jeff"; })
      ];
    })
  ];

  home.stateVersion = "23.05";
}

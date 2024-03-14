_: { ... }: {
  perSystem = { inputs', pkgs, ... }: {
    packages = {
      airsonic-advanced = pkgs.callPackage ../../packages/airsonic-advanced.nix { };
      deemix-server = pkgs.callPackage ../../packages/deemix-server { };
      gdlauncher = pkgs.callPackage ../../packages/gdlauncher.nix { };
      nimbus-roman-ttf = pkgs.callPackage ../../packages/nimbus-roman.nix { };
      nomos-rebuild = pkgs.callPackage ../../packages/nomos-rebuild { };
      tetrust = pkgs.callPackage ../../packages/tetrust.nix { };
      xwinwrap = pkgs.callPackage ../../packages/xwinwrap.nix { };

      # Re-export correct version of disko
      disko = inputs'.disko.packages.disko;
    };
  };
}

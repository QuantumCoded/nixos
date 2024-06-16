{
  perSystem = { inputs', pkgs, ... }: {
    packages = {
      gdlauncher = pkgs.callPackage ./gdlauncher.nix { };
      nimbus-roman-ttf = pkgs.callPackage ./nimbus-roman.nix { };
      nomos-rebuild = pkgs.callPackage ./nomos-rebuild { };
      tetrust = pkgs.callPackage ./tetrust.nix { };
      xwinwrap = pkgs.callPackage ./xwinwrap.nix { };

      # Re-export correct version of disko
      disko = inputs'.disko.packages.disko;
    };
  };
}

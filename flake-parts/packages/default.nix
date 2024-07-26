{
  perSystem = { inputs', pkgs, ... }: {
    packages = {
      # Re-export correct version of disko
      inherit (inputs'.disko.packages) disko;

      breeze-custom = pkgs.callPackage ./breeze-custom { };
      ferret = pkgs.callPackage ./ferret { };
      gdlauncher = pkgs.callPackage ./gdlauncher.nix { };
      imhex = pkgs.callPackage ./imhex.nix { };
      nimbus-roman-ttf = pkgs.callPackage ./nimbus-roman.nix { };
      nomos-rebuild = pkgs.callPackage ./nomos-rebuild { };
      tetrust = pkgs.callPackage ./tetrust.nix { };
      xwinwrap = pkgs.callPackage ./xwinwrap.nix { };
    };
  };
}

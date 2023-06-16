{ device ? "/dev/disk/by-label/nix", fsType ? "ext4" }:

import ./generic.nix {
  inherit device fsType;
  mount = "/nix";
}

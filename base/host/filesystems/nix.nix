{ device ? "/dev/disk/by-label/store", fsType ? "ext4" }:

import ./generic.nix {
  inherit device fsType;
  mount = "/nix";
}

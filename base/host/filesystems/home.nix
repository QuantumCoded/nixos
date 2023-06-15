{ device ? "/dev/disk/by-label/home", fsType ? "ext4" }:

import ./generic.nix {
  inherit device fsType;
  mount = "/home";
}

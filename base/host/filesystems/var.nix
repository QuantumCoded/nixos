{ device ? "/dev/disk/by-label/var", fsType ? "ext4" }:

import ./generic.nix {
  inherit device fsType;
  mount = "/var";
}

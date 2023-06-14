{ device, mount }:
{ pkgs, ... }:

{
  # Install NFS utils
  environment.systemPackages =
    with pkgs;
    [
      nfs-utils
    ];

  # Enable Hydrogen NFS share
  fileSystems.${mount} = {
    inherit device;
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
    ];
  };
}

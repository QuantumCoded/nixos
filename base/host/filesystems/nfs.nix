{ device
, mount
, onDemand ? true
, timeout ? 600
}:
{ lib, pkgs, ... }:

{
  # Install NFS utils
  environment.systemPackages =
    with pkgs;
    [
      nfs-utils
    ];

  # Enable NFS
  fileSystems.${mount} = {
    inherit device;
    fsType = "nfs";
    options = lib.mkIf onDemand [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=${timeout}"
    ];
  };
}

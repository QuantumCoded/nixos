{ device
, fsType ? "ext4"
, mount
}:
{ ... }:

{
  fileSystems.${mount} = {
    inherit device fsType;
  };
}

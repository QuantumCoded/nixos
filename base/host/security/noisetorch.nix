{}:
{ pkgs, ... }:

{
  # Enable cap_sys_resource for noisetorch.
  security.wrappers.noisetorch = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_resource+ep";
    source = "${pkgs.noisetorch}/bin/noisetorch";
  };
}

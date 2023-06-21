{ videoDrivers }:
{ ... }:

{
  # Enable drivers.
  services.xserver.videoDrivers = { inherit videoDrivers; };
}

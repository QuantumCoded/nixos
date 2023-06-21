{ enableAlsa ? true
, enablePulse ? true
, enableJack ? false
}:
{ ... }:

{
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = enableAlsa;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = enablePulse;
    jack.enable = enableJack;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };
}

{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.denoising;
in
{
  options.base.denoising = {
    enable = mkEnableOption "denoising";
  };

  config = mkIf cfg.enable {
    services.pipewire.extraConfig.pipewire = {
      "90-denoising" = {
        "context.modules" = [
          {
            name = "libpipewire-module-filter-chain";
            args = {
              "node.description" = "Noise Canceling Source";
              "media.name" = "Noise Canceling Source";

              "filter.graph" = {
                nodes = [
                  {
                    type = "ladspa";
                    name = "rnnoise";
                    plugin = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                    label = "noise_suppressor_mono";
                    control = {
                      "VAD Threshold (%)" = 85;
                      "VAD Grace Period (ms)" = 100;
                      "Retroactive VAD Grace (ms)" = 0;
                    };
                  }
                ];
              };

              "capture.props" = {
                "node.name" = "capture.rnnoise_source";
                "node.passive" = true;
                "audio.rate" = 48000;
              };

              "playback.props" = {
                "node.name" = "rnnoise_source";
                "media.class" = "Audio/Source";
                "audio.rate" = 48000;
              };
            };
          }
        ];
      };
    };
  };
}

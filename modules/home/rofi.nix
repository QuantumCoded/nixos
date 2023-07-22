{ config, lib, ... }:
let
  inherit (builtins) replaceStrings;
  inherit (lib)
    concatStringsSep
    foldlAttrs
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.base.rofi;
in
{
  options.base.rofi = {
    enable = mkEnableOption "Rofi";
    websites.enable = mkEnableOption "Rofi Websites";
    websites.sites = mkOption {
      type = with types; attrsOf str;
      default = { };
    };
    websites.keybind = mkOption {
      type = types.str;
      default = "super + shift + w";
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      # TODO: consolodate font info
      font = "FiraCode Nerd Font Mono 10";
    };

    services.sxhkd.keybindings =
      let
        sanitize = string:
          replaceStrings
            [ "'" "\n" "\t" "&"]
            [ "\\'" "\\n" "\\t" "\&" ]
            string;

        formatSites = acc: name: value: acc ++ [ "${name}|${value}" ];
        formattedSites = foldlAttrs formatSites [ ] cfg.websites.sites;
        rofiInput = sanitize (concatStringsSep "\n" formattedSites);
        command = ''
          xdg-open `echo -e '${rofiInput}' | column -ts '|' | rofi -dmenu | grep -oP '\S+$'`
        '';
      in
      mkIf cfg.websites.enable {
        ${cfg.websites.keybind} = command;
      };
  };
}

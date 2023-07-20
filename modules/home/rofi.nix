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
            [ "'" "\n" "\t" ]
            [ "\\'" "\\n" "\\t" ]
            string;

        formatSites = acc: name: value: acc ++ [ "${name}\t${value}" ];
        formattedSites = foldlAttrs formatSites [ ] cfg.websites.sites;
        rofiInput = sanitize (concatStringsSep "\n" formattedSites);
        command = ''
          bash -c 'xdg-open `echo -e \'${rofiInput}\' | rofi -dmenu | grep -oP \'(?<=\t).*$\'`'
        '';
      in
      mkIf cfg.websites.enable {
        ${cfg.websites.keybind} = command;
      };
  };
}

# bash -c 'xdg-open `echo -e \'Github\thttps://github.com\nHome Manager Appendix A\thttps://nix-community.github.io/home-manager/options.html\nLast.FM\thttps://last.fm\nNix Builtins\thttps://nixos.org/manual/nix/stable/language/builtins.html\nNix Lib & Builtins\thttps://teu5us.github.io/nix-lib.html\nNixOS Appendix A\thttps://nixos.org/manual/nixos/unstable/options.html\nNixpkgs Github\thttps://github.com/NixOS/nixpkgs\nSearch NixOS Packages\thttps://search.nixos.org/packages\' | rofi -dmenu | grep -oP \'(?<=\t).*$\'`'
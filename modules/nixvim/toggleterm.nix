{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.nixvim.toggleterm;
in
{
  options.base.nixvim.toggleterm = {
    enable = mkEnableOption "toggleterm";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [ toggleterm-nvim ];
      extraConfigLuaPost = builtins.readFile ./lua/toggleterm.lua;
    };
  };
}


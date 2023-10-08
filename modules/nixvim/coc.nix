{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.nixvim.coc;
in
{
  options.base.nixvim.coc = {
    enable = mkEnableOption "coc";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [
        coc-nvim
        coc-rust-analyzer
      ];

      extraConfigLua = ''
        require('lspconfig').rust_analyzer.setup{
          settings = {
            ['rust-analyzer'] = {
              cargo = {
                sysroot = "${pkgs.rust-bin.stable.latest.default}";
              }
            }
          }
        }
        require('lspconfig').nil_ls.setup{}
      '';

      extraConfigLuaPost = builtins.readFile ./lua/coc.lua;
    };
  };
}


{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.nixvim;
in
{
  options.base.nixvim = {
    enable = mkEnableOption "nixvim";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      plugins = {
        treesitter = {
          enable = true;
          # indent = true;
          # folding = true;
        };


      };

      extraPlugins = with pkgs.vimPlugins; [
        # LSP and friends
        coc-nvim
        coc-rls
        lsp-zero-nvim
        nvim-cmp
        cmp-nvim-lsp
        nvim-lspconfig

        # Languages
        vim-nix

        # Theme
        vim-code-dark
      ];

      extraConfigLua = ''
        -- Enables hybrid line numbers
        vim.wo.number = true
        vim.wo.relativenumber = true

        require('lspconfig').rust_analyzer.setup{}
      '';

      extraConfigVim = ''
        "Enable vim-code-dark color theme"
        let g:codedark_modern=1
        colorscheme codedark
      '';
    };
  };
}

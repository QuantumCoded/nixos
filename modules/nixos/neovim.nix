{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  inherit (pkgs)
    fetchFromGitHub
    ;

  inherit (pkgs.vimUtils)
    buildNeovimPluginFrom2Nix
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

        lualine.enable = true;
      };

      extraPlugins = with pkgs.vimPlugins; [
        # LSP and friends
        coc-nvim
        coc-rust-analyzer
        lsp-zero-nvim
        nvim-cmp
        cmp-nvim-lsp
        nvim-lspconfig

        # Direnv
        direnv-vim

        # Languages
        vim-nix

        # Theme
        vim-code-dark

        # Tetris
        (buildVimPluginFrom2Nix {
          pname = "nvim-tetris";
          version = "2021-06-28";
          src = fetchFromGitHub {
            owner = "alec-gibson";
            repo = "nvim-tetris";
            rev = "d17c99fb527ada98ffb0212ffc87ccda6fd4f7d9";
            hash = "sha256-+69Fq5aMMzg9nV05rZxlLTFwQmDyN5/5HmuL2SGu9xQ=";
          };
        })
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

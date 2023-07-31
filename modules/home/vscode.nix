{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.base.vscode;
in
{
  options.base.vscode = {
    enable = mkEnableOption "VSCode";
    fontSize = mkOption {
      type = types.int;
      default = 14;
    };
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.unstable.vscodium;

      extensions =
        with pkgs.vscode-extensions;
        with pkgs.vscode-marketplace;
        with pkgs.vscode-marketplace-release;
        [
          alefragnani.bookmarks
          bodil.prettier-toml
          eamodio.gitlens
          grapecity.gc-excelviewer
          gruntfuggly.todo-tree
          jnoortheen.nix-ide
          jock.svg
          kokakiwi.vscode-just
          mkhl.direnv
          ms-python.python
          ms-vsliveshare.vsliveshare
          pkief.material-icon-theme
          qwtel.sqlite-viewer
          rhaiscript.vscode-rhai
          rust-lang.rust-analyzer
          serayuzgur.crates
          tamasfe.even-better-toml
          usernamehw.errorlens
        ];

      userSettings = {
        # Enable autosave.
        "files.autoSave" = "afterDelay";

        # Enable nix LSP. 
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";

        # Use nixpkgs-fmt with nil
        "nix.serverSettings" = {
          nil.formatting.command = [ "nixpkgs-fmt" ];
        };

        # Put the sidebar on the right.
        "workbench.sideBar.location" = "right";

        # Change the font.
        "editor.fontFamily" = "FiraCode Nerd Font Mono";

        # Change the terminal font.
        "terminal.integrated.fontFamily" = "MesloLGS Nerd Font";

        # Enable font ligatures.
        "editor.fontLigatures" = true;

        # Change the font size.
        "editor.fontSize" = cfg.fontSize;

        # Disable workspace trust.
        "security.workspace.trust.enabled" = false;

        # Disable bracket pair colorization.
        "editor.bracketPairColorization.enabled" = false;

        # Change workbench icons to material icons.
        "workbench.iconTheme" = "material-icon-theme";

        # Change the integrated terminal profile to zsh.
        "terminal.integrated.defaultProfile.linux" = "fish";

        # Disable prompting for confirmation when syncing git changes.
        "git.confirmSync" = false;

        # Disable prompting for confirmation during drag and drop.
        "explorer.confirmDragAndDrop" = false;

        # Disable prompting for confirmation when deleting files.
        "explorer.confirmDelete" = false;

        # Enable git auto fetch.
        "git.autofetch" = true;

        # Disable compacting folders in the tree view.
        "explorer.compactFolders" = false;

        # Enable custom title bar style.
        "window.titleBarStyle" = "custom";

        # Add a vertical rule at 100 characters.
        "editor.rulers" = [ 100 ];

        # Disable integrated terminal chords.
        "terminal.integrated.allowChords" = false;

        # Disable welcome message.
        "workbench.startupEditor" = "none";

        # Change git lens commit graph layout to be in the editior.
        "gitlens.graph.layout" = "editor";
        "bookmarks.sideBar.countBadge" = "off";
        "terminal.integrated.shellIntegration.enabled" = false;
        "files.exclude"."**/.git" = false;
      };
    };
  };
}

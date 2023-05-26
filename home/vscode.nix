{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;

    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      matklad.rust-analyzer
      usernamehw.errorlens
      eamodio.gitlens
      serayuzgur.crates
      tamasfe.even-better-toml
      grapecity.gc-excelviewer
      ms-vsliveshare.vsliveshare
      pkief.material-icon-theme
      ms-python.python
      gruntfuggly.todo-tree

      # TODO: Manually install these extensions
      # Prettier TOML
      # Rhai Language Support
      # SQLite Viewer
    ];

    userSettings = {
      # Enable autosave.
      "files.autoSave" = "afterDelay";

      # Enable nix LSP. 
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";

      # Put the sidebar on the right.
      "workbench.sideBar.location" = "right";

      # Change the font.
      "editor.fontFamily" = "FiraCode Nerd Font Mono";

      # Enable font ligatures.
      "editor.fontLigatures" = true;

      # Change the font size.
      "editor.fontSize" = 13;

      # Disable workspace trust banner.
      "security.workspace.trust.banner" = "never";

      # Disable bracket pair colorization.
      "editor.bracketPairColorization.enabled" = false;

      # Change workbench icons to material icons.
      "workbench.iconTheme" = "material-icon-theme";

      # Change the integrated terminal profile to zsh.
      "terminal.integrated.defaultProfile.linux" = "zsh";

      # Disable prompting for confirmation when syncing git changes.
      "git.confirmSync" = false;

      # Disable prompting for confirmation during drag and drop.
      "explorer.confirmDragAndDrop" = false;

      # Disable prompting for confirmation when deleting files.
      "explorer.confirmDelete" = false;

      # Enable git auto fetch.
      "git.autofetch" = true;

      "nix.serverSettings" = {
        nil.formatting.command = [ "nixpkgs-fmt" ];
      };
    };
  };
}

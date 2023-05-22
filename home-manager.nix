{ config, pkgs, home, lib, ... }:

{
  # Load the overlays.
  imports = [ ./overlays.nix ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jeff";
  home.homeDirectory = "/home/jeff";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jeff/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Let Home Manager manager VSCode.
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
    };
  };

  # Let Home Manager manager Zsh.
  programs.zsh = {
    # The powerlevel theme I'm using is distgusting in TTY, let's default
    # to something else
    # See https://github.com/romkatv/powerlevel10k/issues/325
    # Instead of sourcing this file you could also add another plugin as
    # this, and it will automatically load the file for us
    # (but this way it is not possible to conditionally load a file)
    # {
    #   name = "powerlevel10k-config";
    #   src = lib.cleanSource ./p10k-config;
    #   file = "p10k.zsh";
    # }
    # if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
    #   [[ ! -f ${configThemeNormal} ]] || source ${configThemeNormal}
    # else
    #   [[ ! -f ${configThemeTTY} ]] || source ${configThemeTTY}
    # fi

    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableVteIntegration = true;
    history.ignoreDups = true;
    historySubstringSearch.enable = true;

    plugins = with pkgs; [
      {
        file = "powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };

  # Let Home Manager manage kitty.
  programs.kitty = {
    enable = true;
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
    };
  };
}

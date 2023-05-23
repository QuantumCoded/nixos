{ pkgs, ... }:
{
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
      src = lib.cleanSource ../p10k-config;
      file = "p10k.zsh";
    }
  ];
}
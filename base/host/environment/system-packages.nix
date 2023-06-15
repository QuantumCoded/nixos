{}:
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    micro
    tmux
    vim
    wget
  ];
}

{}:
{ config, inputs, ... }:

{
  programs.kitty.extraConfig = builtins.readFile (config.scheme inputs.base16-kitty);
}

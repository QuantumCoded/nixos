{ ... }:

{
  options = { };

  config = {
    programs.fish = {
      enable = true;

      # TODO: tide and its configs need to be set as an option
      # plugins = [];
    };
  };
}

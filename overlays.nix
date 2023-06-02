{ system
, nixpkgs-unstable
, nixpkgs-racoon
, nur
, ...
}:
let
  overlay-racoon = final: prev: {
    racoon = import nixpkgs-racoon {
      inherit system;
    };
  };

  overlay-unstable = final: prev: {
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  };
in
{
  nixpkgs.overlays = [ nur.overlay overlay-racoon overlay-unstable ];
}

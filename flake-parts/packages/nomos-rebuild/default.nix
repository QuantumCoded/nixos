{ stdenvNoCC, nixos-rebuild }:

stdenvNoCC.mkDerivation {
  name = "nomos-rebuild";

  src = nixos-rebuild;

  buildInputs = [
    nixos-rebuild
  ];

  patches = [ ./nomos-rebuild.patch ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp bin/nixos-rebuild $out/bin/nomos-rebuild
    runHook postInstall
  '';
}

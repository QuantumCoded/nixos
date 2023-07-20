{ stdenv }:

stdenv.mkDerivation {
  name = "dmx-server";
  src = ./.;
  phases = "installPhase";
  installPhase = ''
    mkdir -v $out
    cp -rv $src/bin $out
  '';
}

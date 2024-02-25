{ stdenv }:

stdenv.mkDerivation {
  name = "deemix-server";
  src = ./.;
  phases = "installPhase";
  installPhase = ''
    mkdir -v $out
    cp -rv $src/bin $out
  '';
}

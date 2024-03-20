{ fetchFromGitHub, stdenvNoCC }:

stdenvNoCC.mkDerivation {
  phases = [ "installPhase" ];

  name = "nimbus-roman-ttf";

  src = fetchFromGitHub {
    owner = "ArtifexSoftware";
    repo = "urw-base35-fonts";
    rev = "3c0ba3b5687632dfc66526544a4e811fe0ec0cd9";
    hash = "sha256-WD5q5ajG2F5aIZJB8tJL0X+YsL++ysIBrBKgq0ROrIY=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype

    for font in $(find $src -type f -name 'Nimbus*.ttf'); do
      cp -v $font $out/share/fonts/truetype
    done
  '';
}

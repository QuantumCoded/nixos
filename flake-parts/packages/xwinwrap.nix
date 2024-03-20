# fork of pkgs.xwinwrap with support for spanning multi monitors
{ stdenv
, fetchFromGitHub
, xorg
}:

stdenv.mkDerivation {
  name = "xwinwrap";

  src = fetchFromGitHub {
    owner = "ujjwal96";
    repo = "xwinwrap";
    rev = "ec32e9b72539de7e1553a4f70345166107b431f7";
    hash = "sha256-6ar1HgEWIc/20MJzy07FvuwV2sXBdFumzzVRibh5dlA=";
  };

  buildInputs = with xorg; [
    libX11
    libXext
    libXrender
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp xwinwrap $out/bin
  '';
}

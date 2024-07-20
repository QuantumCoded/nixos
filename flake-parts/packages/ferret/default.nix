{ antlr
, buildGoModule
, fetchFromGitHub
, go
, stdenv
}:

buildGoModule {
  name = "ferret";
  src = fetchFromGitHub {
    owner = "MontFerret";
    repo = "ferret";
    rev = "v0.18.0";
    hash = "sha256-nFnmZ2Bo5B6N5nQW9xe/piUuhyEhFRQ9XotTMKe0Hrk=";
  };
  patches = [ ./rm-google-test.patch ];
  vendorHash = "sha256-q7UGtYj0oLKK9UcjfUFqMLE/ZrJ8aruRtUnVmnJZMM0=";
  buildInputs = [ stdenv go antlr ];

  postInstall = ''
    mv $out/bin/e2e $out/bin/ferret
  '';
}

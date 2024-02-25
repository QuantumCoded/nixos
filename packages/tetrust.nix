{ fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage {
  pname = "tetrust";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "ha-shine";
    repo = "tetrust";
    rev = "5e5a174cc95b740478c87a8d5af79ffde06bdd1d";
    hash = "sha256-nxjj8mvjxx55KPr5ErejG1NOx5/Jq/+vtIlKkAVFBzs=";
  };

  cargoHash = "sha256-T9KD0/Fd3umlw88pdK6VDAAGTe5Ty1LBEFIEfzsuFbE=";
}


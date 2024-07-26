{ plasma5Packages, stdenvNoCC }:
let
  inherit (plasma5Packages) plasma-workspace;
in
stdenvNoCC.mkDerivation rec {
  name = "breeze-custom";

  dontBuild = true;
  sourceRoot = ".";
  srcs = [
    ./.
    plasma-workspace
  ];

  installPhase = ''
    mkdir -p $out/share/sddm/themes

    mkdir srcs
    mv * srcs || true

    cp -r srcs/${plasma-workspace.name}/share/sddm/themes/breeze ${name}
    cp srcs/${name}/wallpaper.png $out

    sed \
      -i "/background/c\background=$out/wallpaper.png" \
      ${name}/theme.conf

    cp -r ${name} $out/share/sddm/themes/${name}
  '';
}

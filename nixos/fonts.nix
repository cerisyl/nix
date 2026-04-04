{ pkgs }: pkgs.stdenv.mkDerivation {
  name = "ceri-fonts";
  version = "1.0";
  src = ../extra/fonts.zip;
  unpackPhase = ":";
  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    ${pkgs.unzip}/bin/unzip -qq $src -d $out/share/fonts/truetype
  '';
}
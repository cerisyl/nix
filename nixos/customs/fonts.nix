{ config, pkgs, lib, ... }:
pkgs.stdenv.mkDerivation {
  name = "ceri-fonts";
  version = "1.0";
  src = builtins.fetchurl {
    name = "ceri-fonts";
    url = ./assets/fonts.zip;
    sha256 = "c1e7e061fe0296e94f03a3326d0fe0ae8fd4eeb73f8c79968ab7b504fd50d12c";
  };
  installPhase = ''
    mkdir -p $out/share/X11/fonts
    ${pkgMap.unzip}/bin/unzip -qq -o $src -x / -d $out/share/X11/fonts
  '';
};
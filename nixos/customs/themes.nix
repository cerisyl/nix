{ config, pkgs, lib, ... }:
pkgs.stdenv.mkDerivation {
  name = "ceri-themes";
  version = "1.0";
  src = builtins.fetchurl {
    name = "ceri-themes";
    url = "https://www.dropbox.com/scl/fo/lym7a5h68pxibl2fwkl4r/AObWCCVHSwMMA6YnJHckmzo?rlkey=hsjqv6dnle5ysgsppyj0gtfm7&st=m5axlvg7&dl=1";
    sha256 = "3cd8645d42184bcbbaff080040b48126347e892b5cfcb360e0f961908227238b";
  };
  unpackPhase = ''
    ${pkgs.unzip}/bin/unzip $src -x / -d /tmp/themes
  '';
  installPhase = ''
    installTheme () {
      mkdir -p "$2"
      rm -rf "$2"
      ${pkgs.unzip}/bin/unzip -qq $1 -d "$2"
    }
    ls /tmp/themes
    for zip in $(${pkgs.fd}/bin/fd ".*\.zip$" /tmp/themes); do
      theme=$(basename $(dirname $zip))
      file=$(basename $zip)
      type=''${file%.*}
      if [[ $zip == *"main"* ]] || [[ $zip == *"window"* ]]; then
        installTheme $zip "$out/share/themes/$theme-$type"
      elif [[ $zip == *"sounds"* ]]; then
        installTheme $zip "$out/share/sounds/$theme"
      else
        installTheme $zip "$out/share/icons/$theme-$type"
      fi
    done
  '';
  fixupPhase = ''
    rm -rf /tmp/themes
  '';
};
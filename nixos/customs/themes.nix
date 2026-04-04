{ pkgs }: pkgs.stdenv.mkDerivation {
  name = "ceri-themes";
  version = "1.0";
  src = builtins.fetchurl {
    name = "ceri-themes";
    url = "https://www.dropbox.com/scl/fo/lym7a5h68pxibl2fwkl4r/AObWCCVHSwMMA6YnJHckmzo?rlkey=hsjqv6dnle5ysgsppyj0gtfm7&st=m5axlvg7&dl=1";
    sha256 = "f8b118b68cb0e4b2c4e73d4af4ad10f0db2f940642d17b37ad71c507bb4e5c1c";
  };
  unpackPhase = ''
    ${pkgs.unzip}/bin/unzip -qq $src -x / -d /tmp/themes
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
}
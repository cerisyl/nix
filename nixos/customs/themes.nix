{ pkgs }: let
  themeFallback = "ceres";
  theme = if (builtins.pathExists ../../.current_theme)
    then let
      themeName = builtins.readFile ../../.current_theme;
      themePath = ../../themes + "/${themeName}";
    in if (builtins.pathExists themePath)
      then themeName
      else themeFallback
    else themeFallback;
in pkgs.stdenv.mkDerivation {
  name = "ceri-themes";
  version = "1.0";
  src = builtins.fetchurl {
    name = "ceri-themes";
    url = "https://www.dropbox.com/scl/fo/lym7a5h68pxibl2fwkl4r/AObWCCVHSwMMA6YnJHckmzo?rlkey=99g6a54rq8gjkp3gzy2zleda5&st=o27idbom&dl=1";
    sha256 = "0fcdf7555c27193106b4c49f708f1af34d3d97c1ae6cebb76cbda34f8a4f39dd";
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

    declare -A routes
    routes["main"]="themes"
    routes["window"]="themes"
    routes["grub"]="themes"
    routes["icons"]="icons"
    routes["cursors"]="icons"
    routes["sounds"]="sounds"

    for zip in $(${pkgs.fd}/bin/fd ".*\.zip$" /tmp/themes); do
      theme=$(basename $(dirname $zip))
      file=$(basename $zip)
      type=''${file%.*}
      route=''${routes[$type]}
      installTheme $zip "$out/share/$route/$theme-$type"
    done

    for type in "''${!routes[@]}"; do
      route=''${routes[$type]}
      target="$out/share/$route/${theme}-$type"
      dest="$out/share/$route/current-$type"
      if [ -d $target ]; then
        ln -s $target $dest
      elif [[ $type != "window" ]]; then
        ln -s "$out/share/$route/ceres-$type" $dest
      fi
    done
  '';
  fixupPhase = ''
    rm -rf /tmp/themes
  '';
}
{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "fade-in";
  version = "5.0.11";
  arch = "amd64";
  nativeBuildInputs = with pkgs; [ dpkg autoPatchelfHook ];
  propagatedBuildInputs = with pkgs; [
    libuuid
    gtk3
    pango
    cairo
    gdk-pixbuf
    glib
    libx11
    wayland
    libsm
    libxkbcommon
    fontconfig
    curl
    webkitgtk_4_1
  ];
  src = builtins.fetchurl {
    name    = "fade-in";
    url     = "https://www.fadeinpro.com/download/demo/fadein-linux-x64-demo.deb";
    sha256  = "1q2w2nqpw9kwnlkx0q4w1clq2n1nq34n9s8in981k090bhn0142a";
  };
  sourceRoot = ".";
  unpackPhase = ''
    dpkg-deb -x $src .
  '';
  installPhase = ''
    cp -r usr $out
    for size in 16 24 32 48 64 128 256 512; do
      mkdir -p $out/share/icons/hicolor/"$size"x"$size"/apps
      cp $out/share/fadein/icon_app/fadein_icon_"$size"x"$size".png $out/share/icons/hicolor/"$size"x"$size"/apps/fade-in.png
    done
  '';
}

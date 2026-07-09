{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "falcon-sensor";
  version = "1.0";
  arch = "amd64";
  nativeBuildInputs = with pkgs; [ dpkg autoPatchelfHook ];
  propagatedBuildInputs = with pkgs; [ openssl libnl zlib ];
  src = builtins.fetchurl {
    name = "falcon-sensor";
    url = "https://uofi.app.box.com/index.php?rm=box_download_shared_file&shared_name=6ygz74yw198grpn752s4yjrgao1iraet&file_id=f_2209156038813";
    sha256 = "0fbd1f488e4cb36a8df3e055ca362d2bbe48813f107a20ea0adf79fa5a81bcfd";
  };
  sourceRoot = ".";
  unpackPhase = ''
    dpkg-deb -x $src .
  '';
  installPhase = ''
    cp -r . $out
  '';
}

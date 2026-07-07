{ pkgs, lib }:
pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "fooyin";
  version = "0.11.1";

  src = pkgs.fetchFromGitHub {
    owner = "fooyin";
    repo = "fooyin";
    tag = "v" + finalAttrs.version;
    hash = "sha256-228hxjKkxE0ILzP8dnIS21R3AW9Y0+wutgcYlQdCgXc=";
  };

  buildInputs = with pkgs; [
    kdePackages.qcoro
    kdePackages.qtbase
    kdePackages.qtsvg
    kdePackages.qtwayland
    taglib
    ffmpeg
    icu
    kdsingleapplication
    alsa-lib
    pipewire
    SDL2
    libebur128
    libvgm
    libsndfile
    libarchive
    libopenmpt
    game-music-emu
  ];

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    kdePackages.qttools
    kdePackages.wrapQtAppsHook
  ];

  cmakeFlags = [
    (lib.cmakeBool "BUILD_TESTING" finalAttrs.finalPackage.doCheck)
    # we need INSTALL_FHS to be true as the various artifacts are otherwise just dumped in the root
    # of $out and the fixupPhase cleans things up anyway
    (lib.cmakeBool "INSTALL_FHS" true)
  ];

  env.LANG = "C.UTF-8";
})

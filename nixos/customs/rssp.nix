{ lib, rustPlatform, fetchFromGitHub }: let
  name    = "rssp";
  version = "8a57847fed6e6aaf7f55a194b2f6f5a38195ea87";
  lockfile = ./deps/rssp.lock;
in rustPlatform.buildRustPackage {
  inherit name version;
  arch = "amd64";
  src = fetchFromGitHub {
    owner = "pnn64";
    repo  = name;
    rev   = version;
    hash  = "sha256-e3gH0MkpkeUmvL6I39Bmf287ry0oooloWCxJI716I0w=";
  };
  cargoLock.lockFile = lockfile;
  doCheck = false;
  postPatch = ''
    cp ${lockfile} Cargo.lock
  '';
  meta = with lib; {
    description = "High-performance Rust parser/analyzer for StepMania simfiles";
    homepage = "https://github.com/pnn64/rssp";
    license = licenses.mit;
    mainProgram = "rssp";
  };
}

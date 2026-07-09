# Templated file, do not touch!
{ inputs, config, libutils, pkgs, pkgsUnstable, pkgsGit, lib, ... }: let
  myHostname = "nova";
in
import ../../configuration.nix {
  inherit inputs config libutils pkgs pkgsUnstable pkgsGit lib myHostname;
}

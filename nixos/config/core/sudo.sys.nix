{ config, lib, pkgs, myHostname, ... }: let
  bypass = [
    "nix"
    "nixos-rebuild"
    "virsh"
    "rmmod"
    "modprobe"
  ];
in {
  security.sudo.extraRules = [{
    groups = [ "wheel" ];
    commands = map ( cmd: {
      command = "/run/current-system/sw/bin/${cmd}";
      options = [ "NOPASSWD" ];
    }) bypass;
  }];
}
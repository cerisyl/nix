{ config, lib, pkgs, myHostname, ... }:
if myHostname == "astore" then {
  services.xrdp = { 
    enable = true;
    defaultWindowManager = "${pkgs.xfce.xfce4-session}/bin/xfce4-session";
  };
} else {}
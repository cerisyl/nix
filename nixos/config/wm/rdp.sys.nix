{ config, lib, pkgs, myHostname, ... }:
if myHostname == "astore" then {
  services.xrdp = { 
    defaultWindowManager = "${pkgs.xfce4.xfce4-session}/bin/xfce4-session";
  };
} else {}
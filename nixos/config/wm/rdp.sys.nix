{ config, lib, pkgs, myHostname, ... }:
if myHostname == "astore" || myHostname == "engrit" then {
  services.xrdp = { 
    enable = true;
    defaultWindowManager = "${pkgs.xfce.xfce4-session}/bin/xfce4-session";
  };
} else {}
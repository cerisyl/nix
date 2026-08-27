{ pkgs, myHostname, ... }:
if myHostname != "nova" || myHostname != "medea" then {
  services.xrdp = {
    enable = true;
    defaultWindowManager = "${pkgs.xfce.xfce4-session}/bin/xfce4-session";
  };
} else {}

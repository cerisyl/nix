{ config, lib, pkgMap, myHostname, ... }:
if myHostname != "astore" && myHostname != "medea" then {
  services.remmina = {
    enable  = true;
    package = pkgMap.remmina;
  };
} else {}
{ config, lib, pkgMap, myHostname, ... }:
if myHostname == "lux" || myHostname == "engrit" then {
  services.remmina = {
    enable  = true;
    package = pkgMap.remmina;
  };
} else {}
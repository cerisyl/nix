{ config, lib, myHostname, ... }:
if myHostname == "lux" then {
  services.open-webui = {
    enable = true;
    port  = 10000;
  };
} else {}
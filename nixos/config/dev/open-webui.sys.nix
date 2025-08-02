{ config, lib, myHostname, ... }:
if myHostname == "lux" then {
  services.open-webui = {
    enable = true;
    port  = 10000;
    environment = {
      WEBUI_AUTH = "False";
      OFFLINE_MODE = "True";
    };
  };
} else {}
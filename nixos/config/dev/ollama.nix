{ config, lib, pkgMap, myHostname, ... }:
if myHostname == "lux" then {
  services = {
    ollama = {
      enable        = true;
      package       = pkgMap.ollama;
      acceleration  = "cuda";
    };
  };
} else {}
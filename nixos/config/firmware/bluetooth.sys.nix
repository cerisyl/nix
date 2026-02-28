{ config, lib, pkgs, myHostname, ... }:
if (myHostname == "nova" || myHostname == "engrit") then {
  hardware.bluetooth = {
    enable      = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
} else {}
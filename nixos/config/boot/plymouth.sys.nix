{ config, pkgMap, lib, ... }: {
  boot.plymouth = {
    enable = true;
    theme  = "spinner";
    #logo   = "/run/current-system/sw/share/themes/current-main/img/boot.png";
  };
}
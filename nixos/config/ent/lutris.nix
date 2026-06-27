{ config, pkgMap, lib, ... }:
if pkgMap ? "lutris" then {
  programs.lutris = {
    enable  = true;
    package = pkgMap.lutris;
    winePackages = with pkgMap; [ wineWow64Packages.stable ];
    extraPackages = with pkgMap; [ winetricks umu-launcher ];
  };
} else {}
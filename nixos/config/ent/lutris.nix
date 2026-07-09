{ pkgs, pkgMap, ... }:
if pkgMap ? "lutris" then {
  programs.lutris = {
    enable  = true;
    package = pkgMap.lutris;
    winePackages  = [ pkgs.wineWow64Packages.full ];
    extraPackages = with pkgMap; [ winetricks umu-launcher ];
  };
} else {}

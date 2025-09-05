{ config, pkgMap, myHostname, theme, getThemeFile, lib, ... }:
if (pkgMap ? "thunderbird" || pkgMap ? "thunderbird-140") then {
  programs.thunderbird = {
    enable  = true;
    package = if myHostname != "engrit" then pkgMap.thunderbird else pkgMap.thunderbird-140;
    profiles.main = {
      isDefault = true;
    };
  };
} else {}
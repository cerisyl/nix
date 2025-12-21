{ config, pkgMap, theme, getThemeFile, homedir, myHostname, lib, ... }: let
  displays = {
    lux = {
      "Default/DP-1/RefreshRate" = 99.95;
    };
    nova = {
      # ...
    };
    engrit = {
      # Left DP monitor
      "Default/DP-1-1/Primary"        = true;
      "Default/DP-1-1/RefreshRate"    = 120;
      "Default/DP-2-1/Primary"        = true;
      "Default/DP-2-1/RefreshRate"    = 120;
      "Default/DP-1-2-2/Primary"      = true;
      "Default/DP-1-2-2/RefreshRate"  = 120;
      # Right DP monitor
      "Default/DP-1-2/Primary"        = false;
      "Default/DP-1-2/RefreshRate"    = 120;
      "Default/DP-2-2/Primary"        = false;
      "Default/DP-2-2/RefreshRate"    = 120;
      "Default/DP-1-3-3/Primary"      = false;
      "Default/DP-1-3-3/RefreshRate"  = 120;
    };
    medea = {
      # ...
    };
    astore = {
      "Default/DP-1/RefreshRate" = 99.95;
      "Default/DP-2/RefreshRate" = 99.95;
    };
    vm = {
      # ...
    };
  };
in {
  xfconf.settings.displays = displays."${myHostname}";
}

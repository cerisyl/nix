{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  services.picom = {
    enable  = true;
    package = pkgMap.picom;
    backend = "xrender";
  };
}
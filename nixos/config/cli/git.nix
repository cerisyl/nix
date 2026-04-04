{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  programs.git = {
    enable  = true;
    package = pkgMap.git;
    settings.user = {
      name  = "Spencer Gunning";
      email = "csit@cering.dev";
    };
    lfs.enable = true;
  };
}
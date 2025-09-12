# Automatically reads in anything in extra/autostart
{ config, pkgMap, theme, getThemeFile, myHostname, lib, ... }: let
  baseDir = ../../../extra/autostart;
  
  # Launcher exclusions
  exclude = {
    work    = [ "floorp-work" "slack" "teams" ];
    lesser  = [ "dropbox" "steam" "telegram" ];
  };
  hostExclusions = {
    lux     = [ "battery" ] ++ exclude.work;
    nova    = [ ] ++ exclude.lesser ++ exclude.work;
    astore  = [ "battery" "birdtray" "discord" ] ++ exclude.work ++ exclude.lesser;
    medea   = [ "birdtray" "discord" ] ++ exclude.work ++ exclude.lesser;
    engrit  = [ "birdtray" "discord" ] ++ exclude.lesser;
    vm      = [ "battery" "birdtray" ] ++ exclude.work ++ exclude.lesser;
  };

  filenames = builtins.filter (name:
    let
      filename    = builtins.baseNameOf (lib.removeSuffix ".desktop" name);
      isExcluded  = builtins.elem filename hostExclusions."${myHostname}";
    in
      isExcluded == false && lib.hasSuffix ".desktop" name
  ) (builtins.attrNames (builtins.readDir baseDir));

  autostartFiles = builtins.listToAttrs (map (name: {
    name = "autostart/${name}";
    value = {
      text = builtins.readFile (baseDir + "/${name}");
    };
  }) filenames);
in {
  xdg.configFile = autostartFiles;
}
{ myHostname, ... }:
if myHostname != "astore" && myHostname != "medea" then {
  programs.craftapps = {
    enable = true;
    apps = {
      photocraft.enable   = true;
      vectorcraft.enable  = true;
      effectcraft.enable  = myHostname == "lux";
      wordcraft.enable    = true;
      gridcraft.enable    = true;
      deckcraft.enable    = true;
    };
  };
} else {}

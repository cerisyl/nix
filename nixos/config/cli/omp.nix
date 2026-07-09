{ pkgMap, getThemeFile, ... }: {
  programs.oh-my-posh = {
    enable    = true;
    package   = pkgMap.oh-my-posh;
    settings  = builtins.fromJSON (builtins.readFile (getThemeFile "omp.json"));
  };
}

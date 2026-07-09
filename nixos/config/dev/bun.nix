{ pkgMap, ... }: {
  programs.bun = {
    enable      = true;
    package     = pkgMap.bun;
  };
}

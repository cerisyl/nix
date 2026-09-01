{ pkgMap, homedir, ... }: {
  programs.nh = {
    enable  = true;
    package = pkgMap.nh;
    flake   = "${homedir}/.nix/.";
  };
}

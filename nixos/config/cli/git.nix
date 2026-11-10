{ pkgMap, myHostname, ... }: {
  programs.git = {
    enable  = true;
    package = pkgMap.git;
    settings.user = {
      name  = if myHostname != "engrit" then "ceri" else "Spencer Gunning";
      email = if myHostname != "engrit" then "csit@cering.dev" else "sgunning@illinois.edu";
    };
    lfs.enable = true;
  };
}

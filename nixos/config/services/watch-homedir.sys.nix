{ ... }: {
  systemd.user.services.watch-homedir = {
    enable      = true;
    description = "Watch and remove generated directories";
    after       = [ "network.target" ];
    serviceConfig = {
      Type        = "simple";
      ExecStart   = "/home/ceri/.nix/extra/services/watch-homedir.sh";
      Restart     = "always";
      RestartSec  = 3;
    };
    wantedBy = [ "default.target" ];
  };
}

{ ... }: {
  systemd.user.services.homewatch = {
    enable      = true;
    description = "Watch and remove generated directories";
    after       = [ "network.target" ];
    serviceConfig = {
      Type        = "simple";
      ExecStart   = "/home/ceri/.nix/extra/services/homewatch.sh";
      Restart     = "always";
      RestartSec  = 3;
    };
    wantedBy = [ "default.target" ];
  };
}

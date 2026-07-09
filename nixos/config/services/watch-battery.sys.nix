{ myHostname, ... }:
if (myHostname == "nova" || myHostname == "engrit") then {
  systemd.user.services.watchbattery = {
    enable      = true;
    description = "Watch battery life";
    after       = [ "network.target" ];
    serviceConfig = {
      Type        = "simple";
      ExecStart   = "/home/ceri/.nix/extra/services/watch-battery.sh";
      Restart     = "always";
      RestartSec  = 3;
    };
    wantedBy = [ "default.target" ];
  };
} else {}

{ pkgs, myHostname, ... }:
let
  falcon = pkgs.callPackage ../../customs/falcon-sensor.nix { };
  cid = "";
  startPreScript = pkgs.writeScript "init-falcon" ''
    #! ${pkgs.bash}/bin/sh
    /run/current-system/sw/bin/mkdir -p /opt/CrowdStrike
    ln -sf ${falcon}/opt/CrowdStrike/* /opt/CrowdStrike
    ${pkgs.bash}/bin/bash -c "${falcon}/opt/CrowdStrike/falconctl -s --cid=${cid} -f --trace=debug"
  '';
in if myHostname == "engrit" then {
  systemd.services.falcon-sensor = {
    enable = true;
    description = "CrowdStrike Falcon Sensor";
    unitConfig.DefaultDependencies = false;
    after = [ "local-fs.target" ];
    conflicts = [ "shutdown.target" ];
    before = [ "sysinit.target" "shutdown.target" ];
    serviceConfig = {
      ExecStartPre = "${startPreScript}";
      ExecStart = "${pkgs.bash}/bin/bash -c \"${falcon}/opt/CrowdStrike/falcond\"";
      Type = "forking";
      PIDFile = "/run/falcond.pid";
      Restart = "no";
      TimeoutStopSec = "60s";
      KillMode = "process";
    };
    wantedBy = [ "multi-user.target" ];
    environment.LD_LIBRARY_PATH = "${pkgs.openssl.out}/lib:${pkgs.glibc.out}/lib:${pkgs.zlib.out}/lib:${pkgs.libnl.out}/lib";
  };
} else {}
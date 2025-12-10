{ config, lib, myHostname, ... }: let
  # 445    smb
  # 3389   vnc
  # 50951  ssh
  ports = {
    lux     = { tcp = [ 445 ]; };
    nova    = { tcp = []; };
    vm      = { tcp = []; };
    astore  = { tcp = [ 445 3389 50951 ]; };
    medea   = { tcp = [ 3389 ]; };
    engrit  = { tcp = []; };
  };
in {
  networking.firewall = {
    allowedTCPPorts = ports."${myHostname}".tcp;
  };
}
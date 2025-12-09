{ config, lib, myHostname, ... }: let
  ports = {
    lux     = { tcp = [ 445 3389 50951 ]; };
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
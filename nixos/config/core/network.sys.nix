{ myHostname, ... }: let
  # 445    smb
  # 3389   rdp
  # 50951  ssh
  # 50952  mc
  ports = {
    lux     = { tcp = [ 445 3389 ]; };
    nova    = { tcp = [ ]; };
    vm      = { tcp = [ ]; };
    astore  = { tcp = [ 445 3389 50951 50952 ]; };
    medea   = { tcp = [ ]; };
    engrit  = { tcp = [ 3389 ]; };
  };
in {
  networking.firewall = {
    allowedTCPPorts = ports."${myHostname}".tcp;
  };
}

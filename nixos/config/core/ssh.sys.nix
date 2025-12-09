{ config, lib, myHostname, ... }:
if myHostname == "lux" or myHostname == "astore" then {
  services.openssh = {
    enable  = true;
    ports   = [ 50951 ];
    settings = {
      PasswordAuthentication  = true;
      PubkeyAuthentication    = false;
      AllowUsers      = [ "ceri" "mang" ];
      UseDns          = true;
      X11Forwarding   = false;
      PermitRootLogin = "no";
    };
  };
} else {}
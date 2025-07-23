{ config, lib, myHostname, ... }:
if myHostname == "lux" then {
  services.openssh = {
    enable  = true;
    ports   = [ 22 ];
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
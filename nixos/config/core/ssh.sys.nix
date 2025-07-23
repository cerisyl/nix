{ config, lib, myHostname, ... }:
if myHostname == "lux" then {
  services.openssh = {
    enable  = true;
    ports   = [ 22 ];
    settings = {
      PasswordAuthentication  = false;
      PubkeyAuthentication    = false;
      AllowUsers      = [ "ceri" "mang" ];
      UseDns          = true;
      X11Forwarding   = false;
      PermitRootLogin = "no";
    };
    extraConfig     = ''
      Match Address 192.168.200.245,192.168.200.246
        PasswordAuthentication yes
    '';
  };
} else {}
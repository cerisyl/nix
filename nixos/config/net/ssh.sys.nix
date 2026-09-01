{ myHostname, ... }:
if myHostname == "lux" || myHostname == "astore" then {
  services.openssh = {
    enable  = true;
    ports   = [ 50951 ];
    settings = {
      PasswordAuthentication        = false;
      KbdInteractiveAuthentication  = false;
      PubkeyAuthentication          = true;
      AllowUsers      = [ "ceri" ];
      UseDns          = true;
      X11Forwarding   = false;
      PermitRootLogin = "no";
    };
  };
} else {}

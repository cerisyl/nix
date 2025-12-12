{ config, lib, myHostname, ... }: let
  # Define shares
  smbShares = if myHostname == "lux" then {
    home = { 
      path              = "/home/ceri";
      browseable        = "yes";
      writeable         = "yes";
      "guest ok"        = "no";
      "valid users"     = "ceri";
      "create mask"     = "0644";
      "directory mask"  = "0755";
    };
  } else if myHostname == "astore" then {
    astore = { 
      path              = "/mnt/astore";
      browseable        = "yes";
      writeable         = "yes";
      "guest ok"        = "no";
      "valid users"     = "ceri";
      "create mask"     = "0644";
      "directory mask"  = "0755";
    };
    share = {
      path              = "/mnt/share";
      browseable        = "yes";
      writeable         = "yes";
      "guest ok"        = "no";
      "valid users"     = "ceri, mang";
      "create mask"     = "0644";
      "directory mask"  = "0755";
    };
  } else {};
  
  # Define interfaces
  interfaces = {
    lux     = "lo enp5s0 virbr0";
    astore  = "enp0s31f6";
  };

in if myHostname == "lux" || myHostname == "astore" then {
  services.samba = {
    enable        = true;
    securityType  = "user";
    shares        = smbShares;
    settings.global = {
      "hosts allow" = "192.168.122.0/24 192.168.123.0/24 127.0 192.168.200.245 192.168.200.246";
      "interfaces"  = interfaces."${myHostname}";
      "bind interfaces only" = "yes";
    };
  };
} else {}
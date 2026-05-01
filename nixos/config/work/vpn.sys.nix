{ config, lib, pkgsUnstable, myHostname, ... }:
if myHostname == "nova" || myHostname == "engrit" then {
  networking.networkmanager = {
    plugins = with pkgsUnstable; [ networkmanager-openconnect ];
    ensureProfiles = {
      profiles.myVpn = {
        connection = {
          id = "UIUC AnyConnect";
          type = "vpn";
        };
        vpn = rec {
          gateway = "vpn.illinois.edu";
          remote = gateway;
          username = "sgunning";

          service-type = "org.freedesktop.NetworkManager.openconnect";
          protocol = "anyconnect";
          useragent = "AnyConnect";
          authtype = "password";
        };
      };
    };
  };
} else {}
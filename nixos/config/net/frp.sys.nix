{ pkgs, config, myHostname, ... }:
if myHostname == "astore" then {
  services.frp = {
    package = pkgs.frp;
    instances.default = {
      enable    = true;
      role      = "client";
      settings  = {
        serverAddr  = "51.83.161.40";
        serverPort  = 7000;
        auth.tokenSource = {
          type      = "file";
          file.path = config.sops.secrets.nanachi.path;
        };
        proxies = [
          {
            name        = "rdp";
            type        = "tcp";
            localIP     = "127.0.0.1";
            localPort   = 3389;
            remotePort  = 48885;
          }
          {
            name        = "ssh";
            type        = "tcp";
            localIP     = "127.0.0.1";
            localPort   = 50951;
            remotePort  = 52599;
          }
        ];
      };
    };
  };
} else {}

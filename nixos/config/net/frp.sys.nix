{ pkgs, config, myHostname, ... }:
if myHostname == "astore" then {
  sops.templates.frp = {
    mode = "0400";
    content = ''
      FRP_IP=${config.sops.placeholder."nanachi/ip"}
      FRP_TOKEN=${config.sops.placeholder."nanachi/token"}
    '';
  };
  services.frp = {
    package = pkgs.frp;
    instances.default = {
      enable    = true;
      role      = "client";
      environmentFiles = [ config.sops.templates.frp.path ];
      settings  = {
        serverAddr  = "{{ .Envs.FRP_IP }}";
        serverPort  = 7000;
        auth = {
          method  = "token";
          token   = "{{ .Envs.FRP_TOKEN }}";
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

{ config, lib, pkgs, myHostname, ... }:
if (myHostname == "astore") then {
  services.minecraft-servers = {
    enable = true;
    eula = true;
    dataDir = "/srv/minecraft/";
    openFirewall = true;
    servers.greggies = {
      enable = true;
      autoStart = true;
      # Version
      ##package = pkgs.fabricServers.fabric-1_20_1;
      package = pkgs.minecraftServers.vanilla-1_20_1;
      # Java args
      jvmOpts = "-Xms6144M";
      # Properties
      serverProperties = {
        server-port = 50952;
        difficulty = 0; #normal
        gamemode = 0; #survival
        max-players = 10;
        motd = "Greggies test server";
        white-list = true;
      };
      # Whitelist
      whitelist = {
        cering = "8dd710ce-fd30-45a5-9252-739d3c03df19";
        mang   = "840ad485-1060-4bcf-8730-c552e5c8d62a";
        tetaes = "4b149260-d56e-4835-b3f6-2dce173a92a5";
        sega   = "e6d510e6-a1d3-4801-8a5e-52d2c75b2446";
        draz   = "1d912f45-978b-4edc-b026-26bd5ed6ce31";
        aura   = "65332e35-744e-4570-82e5-ab935f68564e";
        jade   = "241d7103-4c9d-4c45-9464-83b5365ce48e";
        teri   = "c18dcc3b-6c11-42e9-b7d8-4b458ea7017d";
        sorae  = "9639d272-4c20-459d-adea-4aa89ee3cdc1";
        plight = "de87f3e6-d44f-40af-8bff-48828694b616";
      };
    };
  };
} else {}
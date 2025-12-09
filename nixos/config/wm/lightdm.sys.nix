{ config, lib, myHostname, ... }: {
  services.xserver.displayManager.lightdm = {
    enable = true;
  };
}
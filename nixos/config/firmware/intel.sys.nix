{ config, lib, pkgs, myHostname, ... }:
if myHostname == "engrit" then {
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
  hardware = {
    graphics.enable = true;
    enableAllFirmware = true;
    opengl.extraPackages = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
      libva-vdpau-driver
      #intel-ocl
      intel-media-driver
    ];
  };
} else {}
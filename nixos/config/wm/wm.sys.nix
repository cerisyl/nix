{ config, pkgs, pkgMap, lib, ... }: {
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      xfce.enable = false;
    };

    excludePackages = [ pkgs.xterm ];
  };

  nixpkgs.config.pulseaudio = true;
  services.displayManager = {
    defaultSession = "none+i3";
    gdm.enable = true;
  };
  windowManager.i3.enable = true;

  #environment.xfce.excludePackages = with pkgs.xfce // pkgs; [
	# mousepad
	# parole
	# ristretto
  # xfce4-appfinder
  # xfce4-icon-theme
	# xfce4-taskmanager
  # xfce4-terminal
  # xfwm4-themes
  #];
}
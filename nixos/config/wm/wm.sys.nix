{ config, pkgs, pkgMap, lib, ... }: {
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
    displayManager.lightdm = {
      enable = true;
      greeters.gtk = {
        enable = true;
        # https://discourse.nixos.org/t/override-default-lightdm-gtk-greeter-conf-in-configuration-nix/73028/49
        # Config below this assignment does not seem to work
        extraConfig = ''
          background        = /home/ceri/.nix/themes/ceres/img/bg.png
          theme-name        = ceres-main
          icon-theme-name   = ceres-icons
          cursor-theme-name = ceres-cursors
          cursor-theme-size = 24
          font-name         = Barlow Regular 10
          position          = center,center
          indicators        = ~host;~spacer;~clock;~spacer;~session;~power
        '';
      };
    };
    excludePackages = [ pkgs.xterm ];
  };

  nixpkgs.config.pulseaudio = true;
  services.displayManager.defaultSession = "xfce";
  environment.xfce.excludePackages = with pkgs.xfce // pkgs; [
		mousepad
		parole
		ristretto
    xfce4-appfinder
    xfce4-icon-theme
		xfce4-taskmanager
    xfce4-terminal
    xfwm4-themes
  ];
}
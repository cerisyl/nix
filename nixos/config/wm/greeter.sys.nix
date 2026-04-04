{ config, pkgs, pkgMap, lib, ... }: {
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.gtk = {
      enable = true;
      theme.name = "ceres-main";
      iconTheme.name = "ceres-icons";
      cursorTheme = {
        name = "ceres-cursors";
        size = 24;
      };
      clock-format = "%d %b %Y | %I:%M:%S";
      indicators = [ "~host" "~spacer" "~clock" "~spacer" "~session" "~power"];
      # Extremely jank solution
      extraConfig = ''
        background          = /run/current-system/sw/share/themes/ceres-main/img/bg.png
        default-user-image  = /run/current-system/sw/share/themes/ceres-main/img/fetch.png
        font-name           = Barlow 10
      '';
    };
  };
}
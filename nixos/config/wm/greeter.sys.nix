{ config, pkgs, pkgMap, lib, ... }: {
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.gtk = {
      enable = true;
      theme.name = "current-main";
      iconTheme.name = "current-icons";
      cursorTheme = {
        name = "current-cursors";
        size = 24;
      };
      clock-format = "%d %b %Y | %I:%M:%S";
      indicators = [ "~host" "~spacer" "~clock" "~spacer" "~session" "~power"];
      # Extremely jank solution
      extraConfig = ''
        background            = /run/current-system/sw/share/themes/current-main/img/lock.png
        default-user-image    = /run/current-system/sw/share/themes/current-main/img/fetch.png
        font-name             = Barlow 10
        draw-user-backgrounds = false
      '';
    };
  };
}
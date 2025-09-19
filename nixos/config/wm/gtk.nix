{ config, pkgMap, theme, getThemeFile, lib, ... }: let 
  gtkExtras = {
    gtk-enable-event-sounds           = true;
    gtk-enable-input-feedback-sounds  = true;
    gtk-sound-theme-name              = "luna"; #theme;
  };
in {
  gtk = {
    enable = true;
    gtk3 = {
      extraCss = builtins.readFile (getThemeFile "gtk.css");
      extraConfig = gtkExtras;
    };
    gtk4.extraConfig = gtkExtras;
  };
}
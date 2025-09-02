{ config, pkgMap, theme, getThemeFile, homedir, myHostname, lib, ... }: let
  # Theme-specific properties
  themeProps = {
    ceres = {
      font              = "Barlow Regular 10";
      fontTitle         = "Barlow Semi-Bold 10";
      desktopFontSize   = 10;
      cursorSize        = 24;
      dpi               = 96;
      antialias         = 1;
      syncThemes        = true;
      windowTitleAlign  = "left";
      windowTheme       = "${theme}-main";
    };
    aero = {
      font              = "Segoe UI Regular 10";
      fontTitle         = "Segoe UI Regular 9";
      desktopFontSize   = 10;
      cursorSize        = 24;
      dpi               = 98;
      antialias         = 1;
      syncThemes        = false;
      windowTitleAlign  = "left";
      windowTheme       = "${theme}-window";
    };
    luna = {
      font              = "Tahoma Regular 8";
      fontTitle         = "Trebuchet MS Bold 10";
      desktopFontSize   = 8;
      cursorSize        = 24;
      dpi               = 96;
      antialias         = 0;
      syncThemes        = true;
      windowTitleAlign  = "left";
      windowTheme       = "${theme}-main";
    };
    memphis = {
      font              = "MS Sans Serif Regular 9";
      fontTitle         = "MS Sans Serif Bold Bold 9";
      desktopFontSize   = 9;
      cursorSize        = 24;
      dpi               = 92;
      antialias         = 0;
      syncThemes        = true;
      windowTitleAlign  = "left";
      windowTheme       = "${theme}-main";
    };
    note = {
      font              = "Roboto Regular 9";
      fontTitle         = "Roboto Bold 10";
      desktopFontSize   = 10;
      cursorSize        = 24;
      dpi               = 95;
      antialias         = 1;
      syncThemes        = false;
      windowTitleAlign  = "left";
      windowTheme       = "${theme}-window";
    };
    osx = {
      font              = "Helvetica Neue Regular 9";
      fontTitle         = "Inter SemiBold 9";
      desktopFontSize   = 10;
      cursorSize        = 24;
      dpi               = 101;
      antialias         = 1;
      syncThemes        = false;
      windowTitleAlign  = "center";
      windowTheme       = "${theme}-window";
    };
  };

  # Get a list of displays and prep them for xfce4-desktop (for backgrounds)
  displays = {
    lux = {
      "backdrop/screen0/monitorDP-1/workspace0/last-image" = "${homedir}/.nix/themes/${theme}/img/bg.png";
    };
    nova = {
      "backdrop/screen0/monitorDP-1/workspace0/last-image" = "${homedir}/.nix/themes/${theme}/img/bg.png";
    };
    engrit = {
      "backdrop/screen0/monitoreDP-1/workspace0/last-image" = "${homedir}/.nix/themes/${theme}/img/bg.png";
      "backdrop/screen0/monitorDP-1-1/workspace0/last-image" = "${homedir}/.nix/themes/${theme}/img/bg.png";
      "backdrop/screen0/monitorDP-1-2/workspace0/last-image" = "${homedir}/.nix/themes/${theme}/img/bg.png";
      "backdrop/screen0/monitorDP-2-1/workspace0/last-image" = "${homedir}/.nix/themes/${theme}/img/bg.png";
      "backdrop/screen0/monitorDP-2-2/workspace0/last-image" = "${homedir}/.nix/themes/${theme}/img/bg.png";
    };
    medea = {
      # "backdrop/screen0/monitorHDMI-0/workspace0/last-image" = "${homedir}/.nix/themes/${theme}/img/bg.png";
    };
    astore = {
      "backdrop/screen0/monitorHDMI-0/workspace0/last-image" = "${homedir}/.nix/themes/${theme}/img/bg.png";
    };
    vm = {
      "backdrop/screen0/monitorVirtual-1/workspace0/last-image" = "${homedir}/.nix/themes/${theme}/img/bg.png";
    };
  };

in {
  # Remove backup files on activation
  home.activation.removeBackups = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgMap.fd}/bin/fd -H ".*\.63a4305d$" ~ -X rm
  '';

  xfconf.settings = {
    # Session
    xfce-session = {
      "general/LockCommand" = "${pkgMap.lightdm}/bin/dm-tool lock";
    };

    # Disable screensaver
    xfce4-screensaver = {
      "saver/enabled" = false;
      "saver/idle-activation/enabled" = false;
    };

    # Background + desktop
    xfce4-desktop = {
      # Desktop icons
      "desktop-icons/show-tooltips"               = false;
      "desktop-icons/file-icons/show-trash"       = true;
      "desktop-icons/file-icons/show-home"        = true;
      "desktop-icons/file-icons/show-filesystem"  = false;
      "desktop-icons/file-icons/show-removable"   = false;
      "desktop-icons/show-hidden-files"           = false;
      "desktop-icons/single-click"                = true;
      "desktop-icons/use-custon-font-size"        = true;
      "desktop-icons/font-size"                   = themeProps."${theme}".desktopFontSize;
      "desktop-icons/icon-size"                   = 48;
    } // displays."${myHostname}";

    # Windows
    xfwm4 = {
      "general/button_layout"     = "O|HMC";
      "general/placement_mode"    = "mouse";
      "general/scroll_workspaces" = false;
      "general/snap_width"        = 28;
      "general/theme"             = themeProps."${theme}".windowTheme; # Window theme
      "general/title_alignment"   = themeProps."${theme}".windowTitleAlign;
      "general/title_font"        = themeProps."${theme}".fontTitle;
      "general/toggle_workspaces" = false;
      "general/workspace_count"   = 1;
      "general/wrap_windows"      = false;
      "general/workspace_names"   = [ "main" ];
    };

    xsettings = {
      # Net
      "Net/ThemeName"                 = "${theme}-main"; # General theme
      "Net/IconThemeName"             = "${theme}-icons";
      "Net/EnableEventSounds"         = true;
      "Net/EnableInputFeedbackSounds" = true;
      # Gtk
      "Gtk/ButtonImages"        = false;
      "Gtk/ColorPalette"        = "";
      "Gtk/CursorThemeName"     = "${theme}-cursors";
      "Gtk/CursorThemeSize"     = 24;
      "Gtk/FontName"            = themeProps."${theme}".font;
      "Gtk/MenuBarAccel"        = "";
      "Gtk/MonospaceFontName"   = "JetBrainsMono Nerd Font 10";
      "Gtk/TitlebarMiddleClick" = "";
      "Gtk/ToolbarIconSize"     = "";
      "Gtk/ToolbarStyle"        = "";
      # Xfce
      "Xfce/LastCustomDPI"      = themeProps."${theme}".dpi;
      "Xfce/SyncThemes"         = themeProps."${theme}".syncThemes;
      # Xft
      "Xft/DPI"                 = themeProps."${theme}".dpi;
      "Xft/Antialias"           = themeProps."${theme}".antialias;
      "Xft/Hinting"             = 1; # On
      "Xft/HintStyle"           = "hintfull";
    };

    # Notifications
    xfce4-notifyd = {
      "applications/muted_applications" = [ ];
      "notify-location" = "bottom-right";
    };
  };

  # Home directories (see thunar.nix)
  xdg = {
    enable = true;
    userDirs = {
      enable             = true;
      createDirectories  = true;
      publicShare        = null;
      templates          = null;
    };
  };
}

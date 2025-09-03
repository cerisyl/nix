{ config, pkgMap, theme, getThemeFile, lib, ... }: let

  # Define colors
  # TODO: Define other themes
  colors = {
    bg        = "#1a1a1f";
    bgBrite   = "#25252e";
    comment   = "#515167";
    fg        = "#b8b8c7";
    fgBrite   = "#f2f3f5";
    accent    = "#855ee8";
    urgent    = "#e8d572";
  };

in {
  services.polybar = {
    enable    = true;
    package   = pkgMap.polybar;
    script    = "polybar bar &";
    settings  = {
      # Global settings
      "global/wm" = {
        margin-bottom   = 16;
      };
      # Additional settings
      "settings" = {
        screenchange-reload = true;
      };
      # Main bar settings
      "bar/main" = {
        width           = "100%";
        height          = 28;
        radius          = 8;
        fixed-center    = true;
        bottom          = false;
        monitor         = "";
        background      = colors.bg;
        foreground      = colors.fg;

        font-0          = "JetbrainsMono Nerd Font:style=Bold:size=10;2";
        font-1          = "Barlow Regular SC:style=Bold:size=10;1";

        border-size     = 0;
        border-color    = colors.accent;

        padding         = 1;
        module-margin   = 1;

        modules-left    = "menu i3";
        modules-center  = "";
        modules-right   = "datetime";

        wm-restack      = "i3";

        cursor-click    = "default";
        tray-position   = "right";
        tray-maxsize    = 16;
        enable-ipc      = true;
      };
      # Start menu / rofi
      "module/menu" = {
        type                = "custom/text";
        content             = "   ";
        content-foreground  = colors.fg;
        content-padding     = 0;
        click-left          = "pkill rofi || rofi -show";
      };
      # Workspaces
      "module/i3" = {
        type          = "internal/i3";
        show-urgent   = true;
        index-sort    = true;
        enable-click  = true;
        enable-scroll = false;

        format = "<label-state> <label-mode>";

        label-focused             = "%icon%";
        label-focused-foreground  = colors.fgBrite;
        label-focused-background  = colors.bgBrite;
        label-focused-padding     = 1;

        label-occupied            = "%icon%";
        label-occupied-foreground = colors.fg;
        label-occupied-padding    = 1;
        label-urgent              = "%icon%";

        label-urgent-background   = colors.urgent;
        label-urgent-foreground   = colors.bg;
        label-urgent-overline     = colors.urgent;
        label-urgent-underline    = colors.urgent;
        label-urgent-padding      = 1;

        label-empty               = "%icon%";
        label-empty-foreground    = colors.comment;
        label-empty-padding       = 1;
      };
      # Datetime
      "module/datetime" = {
        type                = "internal/date";
        interval            = 1;
        label-foreground    = colors.fg;
        time                = "%d %b %Y | %L:%M:%S %p";
        label               = "%time%";
      };
    };
  };
}
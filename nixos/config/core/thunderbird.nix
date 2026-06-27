{ config, pkgMap, myHostname, theme, getThemeFile, lib, ... }: let
  # Shoutouts https://kb.mozillazine.org/About:config_entries
  defaultSettings = {
    # UI
    "mail.uidensity"              = 0;      # Compact view
    "mail.uifontsize"             = 13;     # Font size, px
    "mail.threadpane.listview"    = 1;      # List view
    "mailnews.default_view_flags" = 0;      # Unthreaded view
    "mail.pane_config.dynamic"    = 0;      # Classic view layout
    "mailnews.start_page.enabled" = false;  # Disable start page
    # Time
    "intl.date_time.pattern_override.date_short" = "y MMM dd";
    "intl.date_time.pattern_override.time_short" = "hh:mmaaaaa";
  };
in if pkgMap ? "thunderbird"  then {
  programs.thunderbird = {
    enable  = true;
    package = pkgMap.thunderbird;
    profiles.main = {
      isDefault = true;
      settings  = defaultSettings;
    };
  };
} else {}
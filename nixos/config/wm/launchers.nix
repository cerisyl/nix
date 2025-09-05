{ config, pkgMap, theme, getThemeFile, myHostname, homedir, lib, ... }: let
  removeLaunchers = [
    "btop"
    "cups"
    "kitty"
    "micro"
    "nixos-manual"
    "org.pulseaudio.pavucontrol"
    "panel-preferences"
    "thunar"
    "thunar-bulk-rename"
    "thunar-settings"
    "syncthing-ui"
    "volctl"
    "winetricks"
    "XColor"
    "xfce4-about"
    "xfce-backdrop-settings"
    "xfce4-notifyd-config"
    "xfce4-power-manager"
    "xfce4-screensaver-preferences"
    "xfce-wm-settings"
    "xfce-wmtweaks-settings"
    "xfce-workspaces-settings"
    "xfce4-screenshooter"
  ];
  mappedRemovals = builtins.listToAttrs (map (name: {
    inherit name;
    exec = name;
    value = {
      inherit name;
      noDisplay = true;
    };
  }) removeLaunchers);

  # Used when removeLaunchers simply doesn't cut it.
  # These files go into .local/share/applications
  overwrite = name: filename: exec: { inherit name filename exec; };
  overwriteLaunchers = [
    #overwrite Name                     .desktop file                     Exec (true if == .desktop file)
    (overwrite "Accessibility"          "xfce4-accessibility-settings"    true)
    (overwrite "Appearance"             "xfce-ui-settings"                "xfce4-appearance-settings")
    (overwrite "Birdtray"               "com.ulduzsoft.Birdtray.desktop"  "birdtray")
    (overwrite "Color Profiles"         "xfce4-color-settings"            true)
    (overwrite "Default Applications"   "xfce4-mime-settings"             true)
    (overwrite "Keyboard"               "xfce-keyboard-settings"          "xfce4-keyboard-settings")
    (overwrite "Log Out"                "xfce4-session-logout"            true)
    (overwrite "Mail Reader"            "xfce4-mail-reader"               "exo-open --launch MailReader %u")
    (overwrite "Mouse and Touchpad"     "xfce-mouse-settings"             "xfce4-mouse-settings")
    (overwrite "Session and Startup"    "xfce-session-settings"           "xfce4-session-settings")
    (overwrite "Settings Editor"        "xfce4-settings-editor"           true)
    (overwrite "Settings Manager"       "xfce4-settings-manager"          true)
    (overwrite "Web Browser"            "xfce4-web-browser"               "exo-open --launch WebBrowser %u")
    (overwrite "Rofi"                   "rofi"                            "rofi -show")
    (overwrite "Rofi Theme Selector"    "rofi-theme-selector"             true)
    (overwrite "Syncthing Tray"         "syncthingtray"                   "syncthingtray --wait --single-instance")
  ];
  mappedOverwrites = builtins.listToAttrs (map (obj: {
    name = ".local/share/applications/${obj.filename}.desktop";
    value.text = ''
      [Desktop Entry]
      Name=${obj.name}
      Type=Application
      Exec=${if obj.exec == true then obj.filename else obj.exec}
      NoDisplay=true
    '';
  }) overwriteLaunchers);

  # Use binary to determine what packages we should download
  # TODO: Pull this from main config file- possibly see if this is syncable with the init defined in /packages
  # maybe it could be an extra option in pkgMap...
  hostMap = {
    "lux"     = "l";
    "nova"    = "n";
    "vm"      = "n";
    "astore"  = "a";
    "medea"   = "m";
    "engrit"  = "e";
  };
  hostID = hostMap.${myHostname};

  # GPU command stuff
  gpuShPath = "${homedir}/.nix/extra/zshfx/gpu";
  gpuCmd = cmd: (if myHostname == "lux"
    then ''sh -c "sh ${gpuShPath} run ${cmd};"''
    else cmd);

  custom = init: name: filename: exec: icon: { inherit init name filename exec icon; };
  customLaunchers = [
    #custom init      Name                      .desktop file                     Exec (true if == .desktop file)                       Icon (true if == .desktop file)
    # core
    (custom "ln..e"   "Email"                   "thunderbird"                     true                                                  "ceri-email")
    (custom "lname"   "KeePassXC"               "org.keepassxc.KeePassXC"         "keepassxc"                                           "ceri-pass")
    (custom "lname"   "Lock"                    "lock"                            "xflock4"                                             "ceri-lock")
    (custom "lname"   "Restart"                 "restart"                         "reboot"                                              "ceri-reboot")
    (custom "lname"   "Shutdown"                "shutdown"                        "shutdown now"                                        "ceri-shutdown")
    (custom "lname"   "xnviewmp"                "xnviewmp"                        "xnviewmp"                                            "ristretto")
    # core (laptop)
    (custom ".n.me"   "Suspend"                 "suspend"                         "systemctl suspend"                                   "ceri-lock")
    (custom ".n.me"   "Hibernate"               "hibernate"                       "systemctl hibernate"                                 "ceri-lock")
    # create
    (custom "l...."   "Blender"                 "blender"                         (gpuCmd "blender %f")                                 true)
    (custom "ln..."   "Kdenlive"                "org.kde.kdenlive"                (gpuCmd "kdenlive")                                   "ceri-kden")
    (custom "ln..."   "OBS Studio"              "com.obsproject.Studio"           "obs"                                                 "ceri-obs")
    # ent
    (custom "ln..."   "ArrowVortex"             "av"                              "wine ${homedir}/games/ArrowVortex/ArrowVortex.exe"   "${homedir}/games/ArrowVortex/av.ico")
    (custom "lnam."   "Deluge"                  "deluge"                          true                                                  "ceri-deluge")
    (custom "ln..."   "ITGmania"                "itgmania"                        "itgmania"                                            "ceri-itg")
    (custom "ln..."   "Minecraft"               "org.prismlauncher.PrismLauncher" (gpuCmd "prismlauncher")                              "ceri-mc")
    (custom "ln..."   "Steam"                   "steam"                           true                                                  "ceri-steam")
    (custom "ln..e"   "Tauon"                   "tauonmb"                         "tauon"                                               "ceri-music")
    (custom "lname"   "VLC Media Player"        "vlc"                             true                                                  "ceri-media")
    # soc
    (custom "ln..."   "Discord"                 "discord"                         "vesktop --enable-blink-features=MiddleClickAutoscroll --disable-smooth-scrolling"      "ceri-cord")
    # util
    (custom "ln..."   "Discord Chat Exporter"   "discordchatexporter"             true                                                  "ceri-cord")
    # vm
    (custom "l...."   "Looking Glass Client"    "looking-glass-client"            "looking-glass-client -s -m 97"                       "looking-glass")
    (custom "lname"   "Virtual Machine Manager" "virt-manager"                    true                                                  "ceri-vm")
    # wm
    (custom "lname"   "File Manager"            "xfce4-file-manager"              "exo-open --launch FileManager %u"                    "ceri-files")
  ];

  # Only import packages containing the hostID in the init string
  filteredCustoms = builtins.filter (entry:
    lib.strings.hasInfix hostID entry.init
  ) customLaunchers;

  # TODO: Maybe combine this into one command
  mappedCustoms = builtins.listToAttrs (map (obj: {
    name = ".local/share/applications/${obj.filename}.desktop";
    value.text = ''
      [Desktop Entry]
      Name=${obj.name}
      Type=Application
      Exec=${if obj.exec == true then obj.filename else obj.exec}
      Icon=${if obj.icon == true then obj.filename else obj.icon}
    '';
  }) filteredCustoms);

  # Windows 11 command (command varies by host)
  win11Cmd = {
    lux     = ''sh -c "sh ${gpuShPath} vm; virsh --connect qemu:///system start win11; looking-glass-client -s -m 97 -F;"'';
    nova    = "virt-manager --connect qemu:///system --show-domain-console win11";
    astore  = "virt-manager --connect qemu:///system --show-domain-console win11";
    engrit  = "remmina /home/ceri/.local/share/remmina/win11.remmina";
    vm      = "virt-manager --connect qemu:///system --show-domain-console win11";
  };
  winLauncher = ''
    [Desktop Entry]
    Name=Windows 11
    Type=Application
    Exec=${win11Cmd.${myHostname}}
    Icon=${homedir}/.icons/ceres-icons/apps/scalable/ceri-start.svg
    ${if myHostname == "astore" then "NoDisplay=true" else ""}
  '';

in {
  # Create custom launchers here
  xdg.desktopEntries = mappedRemovals;
  home.file = {
    # Floorp
    ".local/share/applications/floorp.desktop".text = ''
      [Desktop Entry]
      Actions=new-private-window;new-window;profile-manager-window
      Categories=Network;WebBrowser
      Exec=floorp --enable-blink-features=MiddleClickAutoscroll
      GenericName=Web Browser
      Icon=ceri-web
      MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;x-scheme-handler/http;x-scheme-handler/https
      Name=Floorp
      StartupNotify=true
      StartupWMClass=floorp
      Terminal=false
      Type=Application
      Version=1.4

      [Desktop Action new-private-window]
      Exec=floorp --private-window --enable-blink-features=MiddleClickAutoscroll
      Name=New Private Window

      [Desktop Action new-window]
      Exec=floorp --new-window --enable-blink-features=MiddleClickAutoscroll
      Name=New Window
    '';
    ".local/share/applications/win11.desktop".text = winLauncher;
  } // mappedOverwrites // mappedCustoms;
}

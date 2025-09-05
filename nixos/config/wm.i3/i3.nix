{ config, pkgMap, theme, getThemeFile, homedir, myHostname, lib, ... }: let

  # Define autostarts
  autostart = {
    discord     = "vesktop --enable-blink-features=MiddleClickAutoscroll --disable-smooth-scrolling";
    greenclip   = "greenclip daemon";
    keepassxc   = "keepassxc";
    pasteblock  = "xmousepasteblock";
    slack       = "slack -u";
    steam       = "steam -silent";
    syncthing   = "syncthingtray qt-widgets-gui --single-instance --wait";
    tdx         = "floorp https://help.uillinois.edu/TDNext/Home/Desktop/Default.aspx";
    teams       = "teams-for-linux";
    telegram    = "Telegram -startintray";
    thunderbird = "thunderbird";
    volctl      = "volctl";
  };
  autostartAll  = with autostart; [ greenclip keepassxc pasteblock syncthing volctl ];

  # Set autostarts per host
  hostAutostarts = {
    lux     = with autostart; [ discord steam telegram thunderbird ];
    nova    = with autostart; [ discord thunderbird ];
    astore  = [ ];
    medea   = [ ];
    engrit  = with autostart; [ slack tdx teams thunderbird ];
    vm      = with autostart; [ discord ];
  };

  # Create a string of all autostarts to inject into config file
  myAutostarts = builtins.concatStringsSep "\n" (map (entry:
    "exec --no-startup-id ${entry}"
  ) (autostartAll ++ hostAutostarts."${myHostname}"));

  # Set monitor configurations (xrandr --output)
  hostDisplays = {
    lux = [
      "DP-1 --mode 2560x1440 -r 143.97 --primary" # main
      #"HDMI-1 --mode 2560x1440 -r 59.95 --same-as DP-1" # dummy
    ];
    nova    = [ "DP-1 --mode 1920x1080 -r 59.95 --primary" ];
    astore  = [ "" ];
    medea   = [ "" ];
    engrit  = [
      "DP-1-1 --mode 2560x1440 -r 120 --primary" # left
      "DP-1-2 --mode 2560x1440 -r 120 --right-of DP-1-1" # right
      "eDP-1 --mode 1920x1080 -r 60" # screen
    ];
    vm = [ "Virtual-1 --mode 1600x900 -r 60 --primary" ];
  };

  # Create a string of all xrandr commands to inject into config file
  myDisplays = builtins.concatStringsSep "\n" (map (entry:
    "exec_always --no-startup-id xrandr --output ${entry}"
  ) hostDisplays."${myHostname}");

  # Icons
  iconSocial  = if myHostname != "engrit" then "" else "󰊻";
  iconMail    = if myHostname != "engrit" then "" else "󰴢";

in {
  home.file.".config/i3/config".text = ''
    # Set mod key
    set $mod Mod4
    set $alt Mod1

    # Font for window titles
    font pango:Barlow Regular 10

    # NetworkManager is the most popular way to manage wireless networks on Linux,
    # and nm-applet is a desktop environment-independent system tray GUI for it.
    exec --no-startup-id nm-applet

    # Set refresh_i3status
    set $refresh_i3status killall -SIGUSR1 i3status

    # Set monitors
    ${myDisplays}

    # Set compositor
    exec_always picom

    # Start polybar
    exec_always --no-startup-id polybar

    # Use Mouse+$mod to drag floating windows to their wanted position
    floating_modifier $mod

    # kill focused window
    bindsym $mod+Shift+q kill

    # change focus
    bindsym $mod+Left focus left
    bindsym $mod+Down focus down
    bindsym $mod+Up focus up
    bindsym $mod+Right focus right

    # move focused window
    bindsym $mod+Shift+Left move left
    bindsym $mod+Shift+Down move down
    bindsym $mod+Shift+Up move up
    bindsym $mod+Shift+Right move right

    # split in horizontal orientation
    bindsym $mod+h split h

    # split in vertical orientation
    bindsym $mod+v split v

    # enter fullscreen mode for the focused container
    #bindsym $mod+f fullscreen toggle

    # change container layout (stacked, tabbed, toggle split)
    bindsym $mod+s layout stacking
    bindsym $mod+w layout tabbed
    bindsym $mod+p layout toggle split

    # toggle tiling / floating
    bindsym $mod+Shift+space floating toggle

    # change focus between tiling / floating windows
    bindsym $mod+space focus mode_toggle

    # focus the parent container
    bindsym $mod+a focus parent

    # focus the child container
    #bindsym $mod+d focus child

    # Define names for default workspaces
    set $ws1  1 "${iconSocial}₁" # socials 
    set $ws2  2 "₂" # vms
    set $ws3  3 "${iconMail}₃" # email
    set $ws4  4 "₄" # code
    set $ws5  5 "5"
    set $ws6  6 "6"
    set $ws7  7 "7"
    set $ws8  8 "8"
    set $ws9  9 "9"
    set $ws10 10 "󰗮₀" # tauon

    # forced loading on workspaces
    assign [class="discord"] $ws1
    assign [class="discord"] $ws1
    assign [class=".virt-manager-wrapped"] $ws2
    assign [class="looking-glass-client"] $ws2
    assign [class="thunderbird"] $ws3
    assign [class="Code"] $ws4
    assign [class="tauonmb"] $ws10

    # switch to workspace
    bindsym $mod+1 workspace number $ws1
    bindsym $mod+2 workspace number $ws2
    bindsym $mod+3 workspace number $ws3
    bindsym $mod+4 workspace number $ws4
    bindsym $mod+5 workspace number $ws5
    bindsym $mod+6 workspace number $ws6
    bindsym $mod+7 workspace number $ws7
    bindsym $mod+8 workspace number $ws8
    bindsym $mod+9 workspace number $ws9
    bindsym $mod+0 workspace number $ws10

    # move focused container to workspace
    bindsym $mod+Shift+1 move container to workspace number $ws1
    bindsym $mod+Shift+2 move container to workspace number $ws2
    bindsym $mod+Shift+3 move container to workspace number $ws3
    bindsym $mod+Shift+4 move container to workspace number $ws4
    bindsym $mod+Shift+5 move container to workspace number $ws5
    bindsym $mod+Shift+6 move container to workspace number $ws6
    bindsym $mod+Shift+7 move container to workspace number $ws7
    bindsym $mod+Shift+8 move container to workspace number $ws8
    bindsym $mod+Shift+9 move container to workspace number $ws9
    bindsym $mod+Shift+0 move container to workspace number $ws10

    # always boot into blank workspace (5)
    exec --no-startup-id i3-msg workspace 5

    # reload the configuration file
    bindsym $mod+Shift+c reload
    # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
    bindsym $mod+Shift+r restart
    # exit i3 (logs you out of your X session)
    bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"

    # resize window
    mode "resize" {
      bindsym Left resize   shrink width 10 px or 10 ppt  # shrink width
      bindsym Down resize   grow height 10 px or 10 ppt   # grow height
      bindsym Up resize     shrink height 10 px or 10 ppt   # shrink height
      bindsym Right resize  grow width 10 px or 10 ppt   # grow width

      # back to normal: Enter or Escape or $mod+r
      bindsym Return mode "default"
      bindsym Escape mode "default"
      bindsym $mod+r mode "default"
    }
    bindsym $mod+$alt+Left   resize shrink width 10 px or 10 ppt  # shrink width
    bindsym $mod+$alt+Down   resize grow height 10 px or 10 ppt   # grow height
    bindsym $mod+$alt+Up     resize shrink height 10 px or 10 ppt   # shrink height
    bindsym $mod+$alt+Right  resize grow width 10 px or 10 ppt   # grow width

    bindsym $mod+r mode "resize"

    # Move workspace to next monitor
    bindsym $mod+Shift+m move workspace to output next

    # Cycle workspaces
    bindsym $alt+Tab workspace next
    bindsym $alt+Shift+Tab workspace prev

    # Shortcuts ----------------------------------------------------------------

    # Lock computer
    bindsym $mod+l exec loginctl lock-session
    # btop / Task manager
    bindsym Ctrl+Shift+Escape exec kitty --hold btop
    # Windows key (toggle rofi "start menu")
    bindsym --release 133 exec rofi -show
    # Emoji/symbol picker (rofimoji)
    bindsym $mod+e exec "rofimoji"
    # Show clipboard history (rofi-greenclip)
    bindsym $mod+c exec rofi -modi "clipboard:greenclip print" -show clipboard -no-show-icons
    # Show desktop toggle (toggle blank workspace)
    #bindsym $mod+d exec "sh ${homedir}/.nix/extra/panel/showdesktop.sh"
    # Start file explorer
    bindsym $mod+f exec thunar
    # Start terminal
    bindsym $mod+Return exec kitty

    # Screenshots
    bindsym Ctrl+Shift+3  exec "${homedir}/.nix/extra/screenshot/capture-full.sh";
    bindsym Ctrl+Shift+4  exec "${homedir}/.nix/extra/screenshot/capture-partial.sh";
    bindsym Ctrl+Shift+o  exec "${homedir}/.nix/extra/screenshot/ocr.sh";
    bindsym $mod+$alt+c   exec "${homedir}/.nix/extra/screenshot/color-picker.sh";

    # Volume
    bindsym XF86AudioLowerVolume  exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -1% && $refresh_i3status
    bindsym XF86AudioRaiseVolume  exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +1% && $refresh_i3status
    bindsym XF86AudioMute         exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status

    # Brightness
    bindsym XF86MonBrightnessUp   exec --no-startup-id brightnessctl set +5% && $refresh_i3status
    bindsym XF86MonBrightnessDown exec --no-startup-id brightnessctl set 5%- && $refresh_i3status

    # Set background
    exec_always feh --bg-scale "${homedir}/.nix/themes/${theme}/img/bg.png"

    # Autostarts
    ${myAutostarts}

    # Themeing -----------------------------------------------------------------
    # TODO: integrate other color palettes

    # No title bars
    default_border pixel 1
    default_floating_border pixel 1

    # Gaps
    gaps inner 16
    gaps outer 16

    # Borders
    border_radius 8

    # Smart features
    smart_gaps inverse_outer
    smart_borders no_gaps

    # Don't follow pointer window to window
    focus_follow_mouse no

    # colors
    set $bg          #1a1a1f
    set $act         #855ee8
    set $act_text    #b8b8c7
    set $inact       #515167
    set $inact_text  #515167
    set $urg         #e8d572
    set $urg_text    #1a1a1f
    set $ind         #f2f3f5

    # class                 border  backgr. text         indicator
    client.focused          $act    $act    $act_text    $ind
    client.focused_inactive $inact  $inact  $inact_text  $ind
    client.unfocused        $inact  $inact  $inact_text  $ind
    client.urgent           $urg    $urg    $urg_text    $ind
  '';
  xsession.windowManager.i3 = {
    extraConfig = ''
    '';
  };
}
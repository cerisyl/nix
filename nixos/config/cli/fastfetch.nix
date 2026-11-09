{ pkgMap, ... }: {
  programs.fastfetch = {
    enable    = true;
    package   = pkgMap.fastfetch;
    settings  = {
      logo = {
        source  = "/run/current-system/sw/share/themes/current-main/img/fetch.png";
        type    = "kitty-direct";
        width   = 33;
        height  = 15;
        padding = {
          left      = 3;
          top       = 2;
        };
      };
      display = {
        separator         = " ";
        key.width         = 12;
        color             = "blue";
        size.binaryPrefix = "jedec";
        freq.ndigits      = 1;
      };
      modules = [
        "break"
        "title"
        { type = "custom";    format = "::::::::::::::::::::::::::::::::"; }
        { type = "os";        key = "system";     format = "{name} {version}"; }
        { type = "host";      key = "mainboard"; }
        { type = "uptime";    key = "uptime"; }
        { type = "packages";  key = "pkgs";       format = "{all} 󱄅 {nix-all}"; }
        { type = "display";   key = "display/{index}"; }
        { type = "wm";        key = "wm";         format = "{pretty-name}"; }
        { type = "shell";     key = "shell"; }
        { type = "terminal";  key = "terminal";   format = "{pretty-name}"; }
        { type = "cpu";       key = "processor";  format = "{name} ({cores-physical})"; }
        { type = "gpu";       key = "gpu[{index}]"; }
        { type = "memory";    key = "memory"; }
        { type = "disk";      key = "disk::{index}"; }
        "break"
        "colors"
        "break"
      ];
    };
  };
}

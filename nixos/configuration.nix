{ inputs, myHostname, config, libutils, pkgs, pkgsUnstable, pkgsGit, lib, ... }: let

  # Get host ID
  hostID = libutils.getHostId myHostname;

  # Variable + utility function to determine what theme file should be loaded
  themeFallback = "ceres";
  theme = if (builtins.pathExists ../.current_theme)
    then let
      themeName = builtins.readFile ../.current_theme;
      themePath = ../themes + "/${themeName}";
    in if (builtins.pathExists themePath)
      then themeName
      else themeFallback
    else themeFallback;
  getThemeFile = file: (
    let path = ../themes + "/${theme}/${file}";
    in
      if (builtins.pathExists path) then path
      else ../themes + "/${themeFallback}/${file}"
  );

  # Package management - determine what packages we should download
  # Load and parse our pkgs.csv
  pkgsCsv = builtins.readFile ./pkgs.csv;
  pkgsClean = builtins.filter (entry:
    !(lib.strings.hasInfix "#" entry) && !(entry == "")
  ) (lib.strings.splitString "\n" pkgsCsv);
  pkgsSplit = map (entry:
    lib.strings.splitString "|" entry
  ) pkgsClean;
  allPkgs = map (entry: {
    init        = builtins.elemAt entry 0;
    isUnstable  = lib.strings.hasInfix "*" (builtins.elemAt entry 1);
    isCustom    = lib.strings.hasInfix "@" (builtins.elemAt entry 1);
    pkg         = lib.strings.trim (builtins.elemAt entry 2);
  }) pkgsSplit;

  # Only import packages containing the hostID in the init string
  enabledPkgs = builtins.filter (entry:
    lib.strings.hasInfix hostID entry.init
  ) allPkgs;

  # Get our packages using the specified channel of choice
  systemPkgs = map (entry:
    if entry.isUnstable == true
      then libutils.getAttrByStr pkgsUnstable entry.pkg
    else if entry.isCustom == true
      then pkgs.callPackage ./customs/${entry.pkg}.nix {}
    else
      libutils.getAttrByStr pkgs entry.pkg
  ) enabledPkgs;

  # Also spawn an object to use in loading proper packages in config
  pkgMap = builtins.listToAttrs (map (entry:
    if entry.isUnstable == true
    then { name = entry.pkg; value = libutils.getAttrByStr pkgsUnstable entry.pkg; }
    else { name = entry.pkg; value = libutils.getAttrByStr pkgs entry.pkg; }
  ) enabledPkgs);
in {
  # Main params
  networking.hostName = myHostname;
  time.timeZone       = "America/Chicago";
  i18n.defaultLocale  = "en_US.UTF-8";

  # Networking
  networking.networkmanager.enable = true;

  # Import hardware config
  imports = [
    ./hosts/${myHostname}/hardware-configuration.nix
  ] ++ import ./config { role = "system"; };

  # Sops config
  sops = if myHostname == "lux" then {
    # Set up secrets
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/ceri/.config/sops/age/keys.txt";

    # Import secrets
    secrets.samba = {};
  } else {};

  # Users
  programs.zsh.enable = true;
  users = {
    groups.share = {};
    users = {
      ceri = {
        isNormalUser  = true;
        shell         = pkgsUnstable.zsh;
        extraGroups   = [ "wheel" "input" "networkmanager" "deluge" "libvirtd" "share" ];
      };
    # Only add mang as a secondary user on lux host
    } // (if myHostname == "lux" || myHostname == "astore" then {
      mang = {
        isSystemUser  = true;
        shell         = pkgsUnstable.zsh;
        group         = "share";
        extraGroups   = [ "deluge" ];
      };
    } else {});
  };

  # Import/set home configuration
  home-manager = {
    # Users
    users.ceri = {
      home.stateVersion  = "24.11";
      imports = import ./config/default.nix { role = "home"; };
    };
    # Packages, etc.
    extraSpecialArgs = {
      inherit libutils pkgMap theme getThemeFile myHostname;
      homedir  = "/home/ceri";
      timezone = config.time.timeZone;
      zmod = pkgsGit.zmod;
    };
    # Handle backup files
    backupFileExtension = "63a4305d";
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 30d";
  };

  # Define packages
  nixpkgs.config.allowUnfree  = true;
  environment.systemPackages  = systemPkgs;

  # Allow dynamically linked executables
  programs.nix-ld.enable    = true;
  programs.nix-ld.libraries = [];

  # Fonts
  fonts.fontDir.enable = true;
  fonts.packages = [
    pkgsUnstable.nerd-fonts.jetbrains-mono
    pkgs.inter
    pkgs.roboto
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-color-emoji
    (pkgs.callPackage ./fonts.nix {}) # custom fonts
  ];

  # Buffer/parallel downloads, enable flakes
  nix.settings = {
    download-buffer-size  = 524288000;
    max-substitution-jobs = 4;
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Disable documentation, since it breaks in 26.05
  documentation.doc.enable = false;

  # NEVER EVER CHANGE THIS.
  system.stateVersion = "24.11";
}

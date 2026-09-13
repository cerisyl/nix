# ceri's nix
[![NixOS](https://img.shields.io/badge/NixOS-26.05-blue.svg?logo=NixOS&logoColor=white)](https://nixos.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE.md)

this is my multi-host configuration for NixOS! it provides stable, unstable, and user-defined packages, along with configurations, themes, and Home Manager support. currently, it is in active use across both my personal and work systems.

these files are also intended to be forked and modified for those who may want to learn Nix through editing an existing configuration. it is not, by any means, the definitive method to learn the both Nix language and operating system!

![](/img/ceres.webp)

## features

below is a brief overview of important files and directories within this repository:

```
nixos/          main directory containing all configuration files
  config/       configuration files, split into directories categorically
  customs/      user-defined packages
  hosts/        host-specific configuration.nix/hardware-configuration.nix files
  fonts.nix     packager for custom fonts to be installed to fonts.packages. sources extra/fonts.zip
  pkgs.csv      the list of packages to be installed
  utils.nix     utility functions used across .nix files in this configuration
secrets/        YAML file(s) of SOPS-encrypted variables
themes/         theme-specific configuration files to apply
extra/          miscellaneous files
```

the two most important locations for configuration are files within the `nixos/config` directory and [`pkgs.csv`](/nixos/pkgs.csv). these files provide virtually all of the packages and configuration to provide to each host.

### packages
[`pkgs.csv`](/nixos/pkgs.csv) file provides a list of packages to be loaded on a given system. each line contains a pipe-delimited string, which tells us the hosts to install the package on, the branch the package is located on (either stable/unstable/custom), and the name of the package. a line with `#` at the beginning is treated as a comment.

here is one example of an entry, which installs the `itgmania` package:
```
ln... | * | itgmania
```
- `ln...` tells us we should only install this package on hostIDs matching `l` (lux) and `n` (nova). hostIDs are single-character definitions that live the `getHostId` function in [`utils.nix`](/nixos/utils.nix). the dots are ignored and are only for beautification.
- the `*` tells us we should download this package from the **unstable** branch. omitting this character will download the package from the stable branch instead. an `@` symbol will target a custom package, located in `nixos/customs/`.
- `itgmania` tells us to install the `itgmania` package.

some packages are defined in a few places outside of pkgs.csv:
- fonts are defined in the main [`configuration.nix`](/nixos/configuration.nix), in the `fonts.packages` attribute set.
- some kernel module packages are loaded in [`grub.sys.nix`](/nixos/config/boot/grub.sys.nix) within the `hostOptions` attribute set.

### configuration

the `nixos/config` directory provides most of the configuration of a system. a [`default.nix`](/nixos/config/default.nix) file in the root of the directory recursively sources all files ending in `.nix`, importing them into the main [`configuration.nix`](/nixos/configuration.nix). the `default.nix` file also handles exclusions within the `excludedFiles` list. since Home Manager options exist in their own environment, files ending in `.sys.nix` are treated separately and imported into `imports`. Home Manager options are imported into `home-manager.users.<user>.imports`.

the `default.nix` file also provides an `excludedFiles` set, where you can exclude specific configuration files from the recursive import.

if you are adding programs, it's also a good idea to wrap any configuration files in conditions:
```nix
# remmina.nix
{ pkgMap, myHostname, ... }:
if myHostname == onlythishost { # or even myHostname != notthishost
  services.remmina = {
    enable  = true;
    package = pkgMap.remmina;
    # other configuration ...
  };
} else {}
```
in the above snippet, note that a `pkgMap` attribute set is passed to the file, so we do not have to specify a specific nixpkgs branch.

### themes
this repository provides a few themes, both complete and incomplete. these themes are hosted on [Dropbox](https://www.dropbox.com/scl/fo/lym7a5h68pxibl2fwkl4r/AObWCCVHSwMMA6YnJHckmzo?rlkey=99g6a54rq8gjkp3gzy2zleda5&st=o27idbom&dl=0), separated from this repository to reduce size.

because of the nature of NixOS, i have opted to build theme content directly into configurations in order to ensure maximum reproducibility. a `getThemeFile` function is provided in [`utils.nix`](/nixos/utils.nix) to provide dynamic file paths from the `themes` directory:
```nix
getThemeFile "kitty.conf" # grabs theme/<current_theme>/kitty.conf
```
the `.current_theme` file specifies which theme `getThemeFile` should point to. the **ceres** theme is used as the default fallback.

|                                        |                                              |                                         |
| :------------------:                   | :------------------:                         | :------------------:                    |
| ![](/img/ceres.webp)                   | ![](/img/aero.webp)                          | ![](/img/luna.webp)                     |
| _**ceres**, the default theme_         | _**aero**, a Win7-inspired theme_            | _**luna**, a WinXP-inspired theme_      |
| ![](/img/memphis.webp)                 | ![](/img/note.webp)                          | ![](/img/osx.webp)                      |
| _**memphis**, a Win9x-inspired theme_  | _**note**, an Android KitKat-inspired theme_ | _**osx**, a macOS 10.6-inspired theme_  |

## installation

refer to [**INSTALL.md**](/INSTALL.md) for full installation instructions.

## license & credit

this project is made available under the [**MIT License**](LICENSE.md).

- [**@vibrantrida**](https://bsky.app/profile/vibrantrida.bsky.social) - fetch/face icon
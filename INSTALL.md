# installation

## initial setup

download and boot a minimal ISO image of NixOS from the [NixOS website](https://nixos.org/download/). after booting into the live image, ensure you have a working internet connection (Ethernet is preferred).

run the following commands, which elevates you to root, then clones this repository:
```sh
sudo su
git clone https://github.com/cerisyl/nix
cd nix
```
this next step is optional, but you can use and/or modify `disko.nix` to reproduce a partition configuration. the file provided in this repository assumes an NVME drive to be formatted with a 1 GB UEFI boot partition, 4 GB of swap space, and the remaining capacity to be formatted as an ext4 filesystem.
```sh
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode destroy,format,mount nix/disko.nix
```
next, generate the initial configuration, copy the "ephemeral" configuration from [`.setup/configuration.nix`](/.setup/configuration.nix), and install NixOS:
```sh
nixos-generate-config --root /mnt
cp .setup/configuration.nix /mnt/etc/nixos/configuration.nix
nixos-install
```
>[!NOTE]
> if you want to provide additional packages during this stage of setup, you can modify the `environment.systemPackages` option within [`.setup/configuration.nix`](/.setup/configuration.nix).

after the installation is complete, you will be prompted to set a root password. make sure to set a user password as well:
```sh
passwd ceri
```
finally, reboot your system and boot into the partition NixOS was installed to.

## after 1st reboot

first, log into the user account defined in [`.setup/configuration.nix`](/.setup/configuration.nix)'s `users.users` option.

because we only copied a single configuration file, we'll need to download this repository again- this time to a permanent location. many files in this configuration point directly to `~/.nix` to source additional files, so we'll use that:
```sh
git clone https://github.com/cerisyl/nix .nix
cd .nix
```

we need to save the hardware-specific configuration for the host we're setting up, so copy that from `/etc`:
```sh
mkdir -p nixos/hosts/$myhost # if this host doesn't exist within the configuration
cp /etc/nixos/hardware-configuration.nix nixos/hosts/$myhost/hardware-configuration.nix
```

## for new hosts
if you are defining a completely new host, there are a few more configuration steps we need to address before we rebuild to the desired configuration:

1. [`flake.nix`](/flake.nix) - add a host definition in the `nixosConfigurations` option
2. [`utils.nix`](/nixos/utils.nix) - add a hostId for the new host
3. [`grub.sys.nix`](/nixos/config/boot/grub.sys.nix) - add host to the `hostKernelParams` and `hostOptions` attribute sets
4. [`firewall.sys.nix`](/nixos/config/net/firewall.sys.nix) - add host to the `ports` attribute set
5. [`xsettings.nix`](/nixos/config/wm/xsettings.nix) - add host to the `displays` attribute set
6. [`displays.nix`](/nixos/config/wm.xfce/displays.nix) - add host to the `displays` attribute set
7. [`autostart.nix`](/nixos/config/wm.xfce/autostart.nix) - add host to the `hostExclusions` attribute set

we also need a host-specific `configuration.nix` file to import the universal configuration file:
```nix
# Templated file, do not touch!
{ inputs, config, libutils, pkgs, pkgsUnstable, pkgsGit, lib, ... }: let
  myHostname = "myhost";
in
import ../../configuration.nix {
  inherit inputs config libutils pkgs pkgsUnstable pkgsGit lib myHostname;
}
```
place this file in `nixos/hosts/{myhost}/configuration.nix`.

## finishing up

rebuild the configuration:
```sh
nixos-rebuild switch --flake .#$myhost
```
this will take a while. when finished, reboot into the new configuration, and you're virtually finished at this point!

## secrets

this repository provides secrets via SOPS, so you may optionally want to set that up:
```sh
mkdir -p ~/.config/sops/age
nix shell nixpkgs#age -c age-keygen -o ~/.config/sops/age/keys.txt
```
you'll need to add the resulting public key into [`.sops.yaml`](/.sops.yaml), under `keys` and `creation_rules.key_groups.age`.

if you're setting up a new encrypted file like a [`secrets.yaml`](/secrets/secrets.yaml) for the first time, you can do so by running:
```sh
cd ~/.nix
sops secrets/secrets.yaml
```
if you're adding new secrets into the file itself, you will need to also update the main [`configuration.nix`](/nixos/configuration.nix) file with any secrets to import in the `sops.secrets` attribute set.
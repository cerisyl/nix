# sudo su
# git clone https://github.com/cerisyl/nix

# Initial build
cd nix
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode destroy,format,mount nix/disko.nix
nixos-generate-config --root /mnt
cp .setup/configuration.nix /mnt/etc/nixos/configuration.nix
nixos-install
# Reboot...
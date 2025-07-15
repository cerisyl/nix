# $1 - hostname
# git clone https://github.com/cerisyl/nix
# cd nix

cd nix
cp /etc/nixos/hardware-configuration.nix nixos/hosts/$1/hardware-configuration.nix
nixos-rebuild switch --flake .#$1
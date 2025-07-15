# $1 - hostname
# git clone https://github.com/cerisyl/dotfiles
# cd dotfiles

cd dotfiles
cp /etc/nixos/hardware-configuration.nix nixos/hosts/$1/hardware-configuration.nix
nixos-rebuild switch --flake .#$1
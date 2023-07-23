HOSTNAME=$1
DISK=$2
USERNAME=$3

nix run \
  --extra-experimental-features flakes \
  --extra-experimental-features nix-command \
  github:nix-community/disko -- --mode disko system/disko.nix --arg disks "[ \"${DISK}\" ]"

mkpasswd -m sha-512 > /mnt/persist/etc/users/${USERNAME}

nixos-install --impure --flake .#${HOSTNAME}

HOSTNAME=$1
DISK=$2
USERNAME=$3

nix run \
  --extra-experimental-features flakes \
  --extra-experimental-features nix-command \
  github:nix-community/disko -- --mode disko system/disko.nix --arg disks "[ \"${DISK}\" ]"

mount -t tmpfs tmpfs /mnt

mkdir -p /mnt/boot
mount /dev/${DISK}1 /mnt/boot

mkdir -p /mnt/persist
mount -t btrfs -o subvol=@persist /dev/mapper/cryptroot /mnt/persist

mkdir -p /mnt/nix
mount -t btrfs -o subvol=@nix /dev/mapper/cryptroot /mnt/nix

mkdir -p /mnt/nix/persist/etc/nixos
mkdir -p /mnt/nix/persist/system
mkdir -p /mnt/nix/persist/home
mkdir -p /mnt/nix/persist/etc/users
mkdir -p /mnt/nix/persist/etc/NetworkManager
mkdir -p /mnt/nix/persist/etc/ssh
mkdir -p /mnt/nix/persist/etc/wireguard
mkdir -p /mnt/nix/persist/var/log
mkdir -p /mnt/nix/persist/var/lib

echo "Enter password for user ${USERNAME}"
mkpasswd -m sha-512 > /mnt/nix/persist/etc/users/${USERNAME}

echo "Enter password for user root"
mkpasswd -m sha-512 > /mnt/nix/persist/etc/users/root

nixos-install --impure --flake .#${HOSTNAME}

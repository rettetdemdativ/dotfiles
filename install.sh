HOSTNAME=$1
DISK=$2
USERNAME=$3

nix run \
  --extra-experimental-features flakes \
  --extra-experimental-features nix-command \
  github:nix-community/disko -- --mode disko system/disko.nix --arg disks "[ \"${DISK}\" ]"

MOUNT="/mnt2"
umount $MOUNT
mkdir $MOUNT
mount -t btrfs -o subvol=@ /dev/mapper/cryptroot "$MOUNT"
# Make tmp and srv directories so subvolumes are not autocreated
# by systemd, stopping deletion of root subvolume
mkdir -p "$MOUNT/root/srv"
mkdir -p "$MOUNT/root/tmp"

mkdir -p "$MOUNT/persist"
mount -t btrfs -o subvol=@persist /dev/mapper/cryptroot ${MOUNT}/persist
mkdir -p "$MOUNT/persist/etc/users"

mkpasswd -m sha-512 > ${MOUNT}/persist/etc/users/${USERNAME}

cryptsetup close cryptroot
umount "$MOUNT/persist"
umount "$MOUNT"

mount -t btrfs -o subvol=@ /dev/mapper/cryptroot /mnt
mkdir -p /mnt/boot
mount /dev/vda1 /mnt/boot
mkdir -p /mnt/nix
mkdir -p /mnt/home
mkdir -p /mnt/persist

mount -t btrfs -o subvol=@nix /dev/mapper/cryptroot /mnt/nix
mount -t btrfs -o subvol=@home /dev/mapper/cryptroot /mnt/home
mount -t btrfs -o subvol=@persist /dev/mapper/cryptroot /mnt/persist

mkdir -p /mnt/persist/etc/nixos
mkdir -p /mnt/persist/etc/users
mkdir -p /mnt/persist/etc/NetworkManager
mkdir -p /mnt/persist/etc/ssh
mkdir -p /mnt/persist/etc/wireguard
mkdir -p /mnt/persist/var/log
mkdir -p /mnt/persist/var/lib

nixos-install --impure --flake .#${HOSTNAME}

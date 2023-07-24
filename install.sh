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

mount -t btrfs -p subvol=@ /dev/mapper/cryptroot /mnt
mkdir /mnt/nix
mkdir /mnt/home
mkdir /mnt/persist

mount -t btrfs -p subvol=@nix /dev/mapper/cryptroot /mnt/nix
mount -t btrfs -p subvol=@home /dev/mapper/cryptroot /mnt/home
mount -t btrfs -p subvol=@persist /dev/mapper/cryptroot /mnt/persist

nixos-install --impure --flake .#${HOSTNAME}

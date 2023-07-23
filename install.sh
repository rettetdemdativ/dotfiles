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

nixos-install --impure --flake .#${HOSTNAME}

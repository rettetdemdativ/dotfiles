HOSTNAME=$1
DISK=$2
USERNAME=$3

nix run \
  --extra-experimental-features flakes \
  --extra-experimental-features nix-command \
  github:nix-community/disko -- --mode disko system/disko.nix --arg disks "[ \"${DISK}\" ]"

MOUNT="/mnt2"
mkdir $MOUNT
mount -o subvol=@ "$DISK"3 "$MOUNT"
# Make tmp and srv directories so subvolumes are not autocreated
# by systemd, stopping deletion of root subvolume
mkdir -p "$MOUNT/root/srv"
mkdir -p "$MOUNT/root/tmp"

cryptsetup luksOpen "$DISK"2 cryptroot
mount -o subvol=@persist "/dev/mapper/cryptroot" /mnt/persist

mkpasswd -m sha-512 > /mnt/persist/etc/users/${USERNAME}

cryptsetup close cryptroot
umount "$MOUNT"

nixos-install --impure --flake .#${HOSTNAME}

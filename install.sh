hostname=$1
diskname=$2
username=$3

sfdisk /dev/${diskname} < sda.sfdisk

mkfs.fat -F 32 /dev/${diskname}1
fatlabel /dev/${diskname}1 NIXBOOT
mkfs.btrfs -f -L NIXPERSIST /dev/${diskname}2
cryptsetup luksFormat --label NIXCRYPT /dev/${diskname}3
cryptsetup luksOpen /dev/disk/by-label/NIXCRYPT cryptroot
mkfs.btrfs -f -L NIXROOT /dev/mapper/cryptroot

mount /dev/disk/by-label/NIXROOT /mnt
mkdir /mnt/boot
mount /dev/disk/by-label/NIXBOOT /mnt/boot
mount /dev/disk/by-label/NIXPERSIST /mnt/persist

mkdir -p /mnt/persist/etc/nixos
mkdir -p /mnt/persist/etc/users
mkdir -p /mnt/persist/etc/NetworkManager/system-connections
mkdir -p /mnt/persist/etc/ssh
mkdir -p /mnt/persist/etc/wireguard/
mkdir -p /mnt/persist/var/log
mkdir -p /mnt/persist/var/lib/bluetooth

mkpasswd -m sha-512 > /mnt/persist/etc/users/${username}

nixos-install --impure --flake .#${hostname}

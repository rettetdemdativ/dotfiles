hostname=$1
diskname=$2
username=$3

sfdisk /dev/${diskname} < sda.sfdisk

mkfs.fat -F 32 /dev/${diskname}1
fatlabel /dev/${diskname}1 NIXBOOT
mkfs.btrfs -L NIXPERSIST /dev/${diskname}2 -f
cryptsetup luksFormat --label NIXCRYPT /dev/${diskname}3
cryptsetup luksOpen /dev/${diskname}3 cryptroot
mkfs.btrfs -L NIXROOT /dev/mapper/cryptroot -f

mount -t tmpfs tmpfs /mnt

mkdir /mnt/nix
mount /dev/mapper/cryptroot /mnt/nix

mkdir /mnt/persist
mount /dev/${diskname}2 /mnt/persist

mkdir /mnt/boot
mount /dev/${diskname}1 /mnt/boot

mkdir -p /mnt/persist/etc/nixos
mkdir -p /mnt/persist/etc/users
mkdir -p /mnt/persist/etc/NetworkManager/system-connections
mkdir -p /mnt/persist/etc/ssh
mkdir -p /mnt/persist/etc/wireguard/
mkdir -p /mnt/persist/var/log
mkdir -p /mnt/persist/var/lib/bluetooth

mkpasswd -m sha-512 > /mnt/persist/etc/users/${username}

nixos-install --impure --flake .#${hostname}

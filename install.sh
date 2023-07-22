hostname=$1
diskname=$2
username=$3

sudo sfdisk /dev/${diskname} < sda.sfdisk

sudo mkfs.fat -F 32 /dev/${diskname}1
sudo fatlabel /dev/${diskname}1 NIXBOOT
sudo mkfs.btrfs -L NIXPERSIST /dev/${diskname}2
sudo cryptsetup luksFormat --label NIXCRYPT /dev/${diskname}3
sudo cryptsetup luksOpen /dev/disk/by-label/NIXCRYPT cryptroot
sudo mkfs.btrfs -L NIXROOT /dev/mapper/cryptroot

sudo mount /dev/disk/by-label/NIXROOT /mnt
sudo mkdir /mnt/boot
sudo mount /dev/disk/by-label/NIXBOOT /mnt/boot
sudo mount /dev/disk/by-label/NIXPERSIST /mnt/persist

sudo mkdir -p /mnt/persist/etc/nixos
sudo mkdir -p /mnt/persist/etc/users
sudo mkdir -p /mnt/persist/etc/NetworkManager/system-connections
sudo mkdir -p /mnt/persist/etc/ssh
sudo mkdir -p /mnt/persist/etc/wireguard/
sudo mkdir -p /mnt/persist/var/log
sudo mkdir -p /mnt/persist/var/lib/bluetooth

sudo mkpasswd -m sha-512 /mnt/persist/etc/users/${username}

sudo nixos-install --impure --flake .#${hostname}

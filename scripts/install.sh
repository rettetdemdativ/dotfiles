HOSTNAME=$1
DISK=$2
USERNAME=$3

nix run \
  --extra-experimental-features flakes \
  --extra-experimental-features nix-command \
  github:nix-community/disko/latest -- --mode destroy,format,mount ./system/disko.nix --arg disks "[ \"${DISK}\" ]" --arg usernames "[ \"${USERNAME}\" ]"

mkdir -p /mnt/persist/etc/nixos
mkdir -p /mnt/persist/system

mkdir -p /mnt/persist/home/${USERNAME}
chmod 777 /mnt/persist/home/${USERNAME}

mkdir -p /mnt/persist/etc/users
mkdir -p /mnt/persist/etc/NetworkManager
mkdir -p /mnt/persist/etc/ssh
mkdir -p /mnt/persist/etc/wireguard
mkdir -p /mnt/persist/var/log
mkdir -p /mnt/persist/var/lib

echo "Enter password for user ${USERNAME}"
mkpasswd -m sha-512 > /mnt/persist/etc/users/${USERNAME}

echo "Enter password for user root"
mkpasswd -m sha-512 > /mnt/persist/etc/users/root

nixos-install --impure --flake ./hosts/${HOSTNAME}#${HOSTNAME}

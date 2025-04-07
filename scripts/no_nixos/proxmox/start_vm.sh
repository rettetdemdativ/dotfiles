#!/bin/bash
VMID=$1
HOSTNAME=$2
FORMAT="${FORMAT:=raw}"
STORAGE="${STORAGE:=local-lvm}"
DISKSIZE="${DISKSIZE:=32}"
BIOS="${BIOS:=seabios}"
IP="192.168.27.$VMID"

if [ "$#" -lt 2 ]; then
	echo "dev-vm-create-pve VMID HOSTNAME"
	exit 1
fi

if [ "$BIOS" = "seabios" ]; then
	BIOS_OPTS="--bios seabios"
elif [ "$BIOS" = "ovmf" ]; then
	BIOS_OPTS="--efidisk0 $STORAGE:1 --bios ovmf"
else
	echo "unknown bios: $BIOS"
	exit 1
fi

SOURCE_ISO="/var/lib/vz/template/iso/proxmox-ve_8.3-1.iso"
DEST_ISO_NAME="proxmox-ve_8.3-1-install-$VMID.iso"
DEST_ISO="/var/lib/vz/template/iso/$DEST_ISO_NAME"
DIR="/tmp/create-$VMID"

sudo echo can do sudo

if [ -e "/etc/pve/qemu-server/$VMID.conf" ]; then
	echo "VM $VMID already exists"
	exit 1
fi

mkdir "$DIR"

cat > "$DIR/answer.toml" <<ENDANSWER
[global]
keyboard = "de"
country = "at"
fqdn = "$HOSTNAME.ella.proxmox.com"
mailto = "mail@test.invalidd"
timezone = "Europe/Vienna"
root_password = "Test123!"
root_ssh_keys = [
	"$(cat ~/.ssh/id_rsa.dev.pub)"
]

[network]
source = "from-answer"
cidr = "$IP/16"
dns = "192.168.2.15"
gateway = "10.1.1.1"
filter.ID_NET_NAME = "*"

[disk-setup]
filesystem = "ext4"
disk_list = ["sda"]
ENDANSWER

proxmox-auto-install-assistant validate-answer "$DIR/answer.toml" || exit 1

proxmox-auto-install-assistant prepare-iso $SOURCE_ISO --fetch-from iso \
	--answer-file "$DIR/answer.toml" --tmp /tmp --output "$DIR/$DEST_ISO_NAME" || exit 1

sudo mv "$DIR/$DEST_ISO_NAME" "$DEST_ISO"

sudo qm create $VMID --memory 16384 --cores 8 --net0 virtio,bridge=vmbr0 \
	--cpu host \
	--name $HOSTNAME --boot 'order=scsi0;ide2' --scsihw virtio-scsi-single \
	--ostype l26 --scsi0 "$STORAGE:$DISKSIZE,iothread=1,discard=on,format=$FORMAT" \
	--ide2 local:iso/$DEST_ISO_NAME,media=cdrom $BIOS_OPTS || exit 1

sudo qm start $VMID || exit 1

echo waiting for VM to come up ...
sleep 90

for i in $(seq 1 100)
do
	echo try to connect ...
	if ssh $IP echo; then
		echo 'VM is online! Cleaning up ...'
		sudo qm set $VMID --ide2 none
		sudo rm "$DEST_ISO"
		rm -rf "$DIR"
		echo 'Setting up Debian repos ...'
		ssh $IP <<"ENDSSH"
		(
		  echo deb http://mirror.intra.proxmox.com/base/latest/ bookworm main contrib non-free-firmware
		  echo deb http://mirror.intra.proxmox.com/updates/latest/ bookworm-updates main contrib non-free-firmware
		  echo deb http://mirror.intra.proxmox.com/security/latest/ bookworm-security main contrib non-free-firmware
		  echo deb http://security.debian.org/debian-security bookworm-security main
		  echo deb http://mirror.intra.proxmox.com/backports/latest/ bookworm-backports main contrib non-free-firmware
		  echo deb http://repo.proxmox.com/staging/ceph-quincy bookworm  ceph-17
		  echo deb http://repo.proxmox.com/staging/pve bookworm pve-8
		  echo deb http://download.proxmox.com/debian/devel/ bookworm main
		) > /etc/apt/sources.list
		rm /etc/apt/sources.list.d/*
		apt update
		apt dist-upgrade -y
		reboot
ENDSSH
		echo 'Waiting ...'
		sleep 10
		echo 'Rebooting once more ...'
		for j in $(seq 1 100)
		do
			echo try to connect ...
			if ssh $IP echo; then
				echo 'done.'
				notify-send -a "dev-create-vm-pve" "VM $VMID is ready at $IP!"
				exit 0
			fi
		done
	fi
done

echo could not reach VM
exit 1


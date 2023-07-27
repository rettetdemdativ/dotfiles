{ disks ? [ "/dev/vda" ], username, ... }: {
  disko.devices = {
    disk = {
      vda = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            luks = {
              end = "-16G";
              content = {
                type = "luks";
                name = "cryptroot";
                extraOpenArgs = [ "--allow-discards" ];
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    "/@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/@persist" = {
                      mountpoint = "/persist";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                  };
                };
              };
            };
            swap = {
              size = "100%";
              content = {
                type = "swap";
                randomEncryption = true;
                resumeDevice = true; # resume from hibernation from this device
              };
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=2G" "mode=755"
        ];
      };
      "/home/${username}" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=4G" "mode=777"
        ];
      };
    };
  };
}

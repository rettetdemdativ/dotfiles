{ disks ? [ "/dev/vda" ], ... }: {
  disko.devices = {
    disk = {
      vda = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "table";
          format = "gpt";
          partitions = {
            ESP = {
              type = "partition";
              name = "ESP";
              start = "1MiB";
              end = "1G";
              fs-type = "fat32";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              name = "luks";
              type = "partition";
              start = "1G";
              end = "-16G";
              extraArgs = [ "--label NIXCRYPT" ];
              content = {
                type = "luks";
                name = "cryptroot";
                content = {
                  type = "btrfs";
                  extraArgs =
                    [ "-f" "--label NIXROOT" ]; # Override existing partition
                  subvolumes = {
                    "/home" = { mountOptions = [ "compress=zstd" ]; };
                    "/nix" = { mountOptions = [ "compress=zstd" "noatime" ]; };
                    "/persist" = {
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/log" = {
                      mountpoint = "/var/log";
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
                resumeDevice = true; # resume from hiberation from this device
              };
            };
          };
        };
      };
    };
  };
}

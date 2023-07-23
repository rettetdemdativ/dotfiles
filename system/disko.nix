{ disks ? [ "/dev/vda" ], ... }: {
  disko.devices = {
    disk = {
      vda = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
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
            }
            {
              name = "swap";
              type = "partition";
              start = "1G";
              end = "17G";
              part-type = "primary";
              extraArgs = [ "--label NIXSWAP" ];
              content = {
                type = "swap";
                randomEncryption = true;
              };
            }
            {
              name = "luks";
              type = "partition";
              start = "17G";
              end = "100%";
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
            }
          ];
        };
      };
    };
  };
}

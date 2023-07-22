let
  inet = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOqlxvPpxPoKiI2ayq2ACngcEU3pwMvY5BlNWzj5YpeA michael@koeppl.dev";
  # users = [ inet ];

  nixxps = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOsyxRgommxUwWK69RwCRC1yrtfIKrHUxp8Q9/dRWkGz root@nixxps";
  # systems = [];
in
{
  "secrets/inet-hashed.age".publicKeys = [ inet nixxps ];
}

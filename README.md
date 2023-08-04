# NixOS config files

## Structure

```
├── develop          ... contains environments for development
├── lib              ... helper functions, etc.
├── scripts
├── system           ... system configuration
│   ├── nixxps       ... config for specific host
│   ├── <host>       ... additional hosts
│   ├── default.nix  ... default system config for any host
│   ├── disko.nix    ... config for disko
│   ├── fs.nix       ... filesystem config for any host
├── users
│   ├── inet         ... config for specific user
│   ├── <user>       ... additional users
│   ├── default.nix  ... default user config for any user
└── flake.nix        ... Flake
```

## Installation

* Get the minimal NixOS ISO, burn it to disk/usb, etc. and boot from it
* Run `git clone https://github.com/rettetdemdativ/dotfiles && cd dotfiles`
* (optional) Update the config to suit your host(s) and user(s)
* Run `./scripts/install.sh <host> <user> <disk path>` (e.g. `./scripts/install.sh nixxps inet /dev/sda`)

## Update the system

Run `update-all`

## Apply changes

Run `apply-system`

## Clean generations

Run `clean-generations <time>` (e.g. `clean-generations 5d` deletes generations older than 5 days)

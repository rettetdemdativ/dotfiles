#!/bin/sh

GEN_MAX_AGE="${1:-14d}"

echo "Deleting generations older than $GEN_MAX_AGE"

doas nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than $GEN_MAX_AGE
nix-collect-garbage

#!/usr/bin/env bash
set -e

# Check if the script is run as root (UID 0)
if [ "$EUID" -ne 0 ]; then
  echo "-> This script requires root privileges. Switching to sudo..."
  exec sudo "$0" "$@"
fi

echo "-> Backing up current /etc/nixos to /etc/nixos.bak..."
if [ -d "/etc/nixos" ]; then
  rm -rf /etc/nixos.bak
  cp -r /etc/nixos /etc/nixos.bak
fi

echo "-> Replacing /etc/nixos with local configuration..."
# Assuming the current directory contains your NixOS configuration files (configuration.txt/nix, modules/, etc.)
# We clear /etc/nixos (or use rsync/cp to sync)
rm -rf /etc/nixos/*
cp -r ./* /etc/nixos/

echo "-> Done! /etc/nixos has been completely replaced with the local directory."
#!/usr/bin/env bash
set -euo pipefail

HERE=$(dirname "$(realpath "$0")")
cd "$HERE"

# This script links all files (not directories) from ./config into ~/.config using stow.
# It creates any missing directories in ~/.config as needed.

# Creates all the subdirs of $source below $dest.
function makedirs() {
    local -r source="$1"; local -r dest="$2"
    find "$source" -type d -printf "$HOME/$dest/%P\n" | xargs mkdir -pv
}

# Links all the files contained below $source to $dest.
function lnk() {
    local -r source="$1"; local -r dest="$2"
    makedirs "$source" "$dest"
    stow -v "$source" -t "$HOME/$dest"
}

lnk config .config

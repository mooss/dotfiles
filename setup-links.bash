#!/usr/bin/env bash
set -euo pipefail

HERE=$(dirname "$(realpath "$0")")
cd "$HERE"

# This script links all files (not directories) from ./config into ~/.config using stow.
# It creates any missing directories in ~/.config as needed.

# Creates a link if it does not already exists.
function link-file() {
    local -r from="$1"; local -r to="$2"
    if ! test -e "$to"; then
        ln -vs "$from" "$to"
    fi
}

# Creates the missing links and directories for one dotfile.
function create-one() {
    local -r sourcedir="$1"; local -r dest="$2"; local -r path="$3"
    local -r sourcepath="$PWD/$sourcedir/$path"; local -r destpath="$HOME/$dest/$path"

    if test -d "$sourcepath"; then
        mkdir -pv "$destpath"
    elif test -f "$sourcepath"; then
        link-file "$sourcepath" "$destpath"
    else
        echo >&2 "$sourcepath is not a file or directory"
    fi
}

# Creates the corresponding link or directory for all entries of null-separated STDIN.
function create-all() {
    local -r source="$1"; local -r dest="$2"; local path

    while IFS= read -r -d '' path; do
        create-one "$source" "$dest" "$path"
    done
}

# Links all the files contained below $source to $dest.
function lnk() {
    local -r source="$1"; local -r dest="$2"

    if test -d "$source"; then
        find "$source" -printf "%P\n" | grep . | tr '\n' '\0' | create-all "$source" "$dest"
    else
        link-file "$PWD/$source" "$HOME/$dest"
    fi
}

DOTTED='config zshrc'
for file in $DOTTED; do
    lnk $file .$file
done


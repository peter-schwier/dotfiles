#!/bin/sh

set -e # -e: exit on error

[ -f ~/miniforge3/condabin/conda ] && exit 0 # Exit because it it alredy installed

rm -rf ~/miniforge3

if [ "$(command -v curl)" ]; then
    curl -sSL https://github.com/conda-forge/miniforge/release/latest/download/Miniforge3-Linux-x86_64.sh | bash /dev/stdin -h
elif [ "$(command -v wget)" ]; then
    wget -qO- https://github.com/conda-forge/miniforge/release/latest/download/Miniforge3-Linux-x86_64.sh | bash /dev/stdin -h
else
    echo "To install miniforge3, you must have curl or wget installed." >&2
    exit 1
fi


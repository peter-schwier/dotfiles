#!/bin/sh

set -e # -e: exit on error

if [ "$(command -v curl)" ]; then
    curl -sSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh | bash /dev/stdin -b -f -p '~/.local/miniconda3'
elif [ "$(command -v wget)" ]; then
    wget -qO- https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh | bash /dev/stdin -b -f -p '~/.local/miniconda3'
else
    echo "To install dotnet, you must have curl or wget installed." >&2
    exit 1
fi

~/.local/dotnet/dotnet tool install --global PowerShell

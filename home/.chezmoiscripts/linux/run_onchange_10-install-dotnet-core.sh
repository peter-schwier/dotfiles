#!/bin/sh

set -e # -e: exit on error

[ -f ~/.dotnet/dotnet ] && exit 0 # Exit because it is already installed

if [ "$(command -v curl)" ]; then
    curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS #--install-dir ~/.dotnet --version latest
elif [ "$(command -v wget)" ]; then
    wget -qO- https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS #--install-dir ~/.dotnet --version latest
else
    echo "To install dotnet, you must have curl or wget installed." >&2
    exit 1
fi

#!/bin/sh

set -e # -e: exit on error

if [ "$(command -v curl)" ]; then
    curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --install-dir '~/.local/dotnet' --channel STS --version latest --verbose
elif [ "$(command -v wget)" ]; then
    wget -qO- https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --install-dir '~/.local/dotnet' --channel STS --version latest --verbose
else
    echo "To install dotnet, you must have curl or wget installed." >&2
    exit 1
fi

~/.local/dotnet/dotnet tool install --global PowerShell

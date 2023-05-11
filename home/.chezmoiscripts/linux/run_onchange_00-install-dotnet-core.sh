#!/bin/sh

set -e # -e: exit on error

if [ "$(command -v curl)" ]; then
    curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --install-dir '~/.dotnet' --channel STS --version latest --verbose
    sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$bin_dir"
elif [ "$(command -v wget)" ]; then
    wget -qO- https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --install-dir '~/.dotnet' --channel STS --version latest --verbose
else
    echo "To install dotnet, you must have curl or wget installed." >&2
    exit 1
fi

~/.dotnet/dotnet tool install --global PowerShell

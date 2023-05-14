#!/bin/sh

set -e # -e: exit on error

[ -f ~/.dotnet/tools/pwsh ] && exit 0 # Already installed
export DOTNET_ROOT=~/.dotnet
export PATH=$DOTNET_ROOT:$DOTNET_ROOT/tools:$PATH
~/.dotnet/dotnet tool install --global PowerShell --version 6

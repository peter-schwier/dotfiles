#!/bin/sh

set -e # -e: exit on error

export DOTNET_ROOT=~/.dotnet
export PATH=$DOTNET_ROOT:$DOTNET_ROOT/tools:$PATH
# ~/.dotnet/tools/pwsh -Command "Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser"
